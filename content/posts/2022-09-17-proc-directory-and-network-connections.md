---
title: "Fooling around with the proc directory and network connections"
date: 2022-09-17T12:01:53+02:00
tags: [golang, systems, network, netsnoop]
draft: false
---

Lately I have been curious to try to know if certain linux users are accessing certain resources, in an effort to
discover and expose dependencies between services.

This users are actually the ones with which containers are being run with from k8s itself (in toolforge, each k8s user
has a linux user, and it's containers run as that user).

To do so, I wrote a [small golang script](https://github.com/david-caro/netsnoop). Here's some notes on trying to get
that information.


# Where to get the info from

The ideal would be to operationalize the code, so the services themselves send statistics about their dependencies, but
given the nature of the services (self-hoster, volunteer driven, any language, etc.) trying to touch all the services
code is a no-go.

For that reason the information has to be gotten in a passible form.

Some ideas would be:

* Using a transparent proxy
* Hooking into the kernel (using systemtap, ebpf or overryding the system libraries)
* Sniffing the host traffic

I don't have much experience (hello world!) with systemtap and ebpf, and I had less than a week to complete the
project, so I went with the network sniffing :)


# Sniffing in golang
This was way easier than I though it would be, there's a module named
[gopacket](https://pkg.go.dev/github.com/google/gopacket) that provides a quite easy API to do so, that will give you a
channel where you can extract packets from:

{{< highlight go "linenos=table" >}}

import (
    //...
	"github.com/google/gopacket"
	"github.com/google/gopacket/layers"
	"github.com/google/gopacket/pcap"
    //...
)

//...

// Opening Device
// for now capturing size 0, not interested in the contents
// not interested in promiscuous listening either, only packets from this host
handle, err := pcap.OpenLive(*iface, int32(0), false, pcap.BlockForever)
if err != nil {
    log.Fatal(err)
}

defer handle.Close()

err = handle.SetBPFFilter(bpfFilter)
if err != nil {
    log.Fatalf("error applying BPF Filter ", bpfFilter, "  error:", err)
}

packetSource := gopacket.NewPacketSource(handle, handle.LinkType())
packetChannel := packetSource.Packets()
{{< / highlight >}}

Then all you have to do is receive from that channel the packages:
{{< highlight go >}}
	for {
		select {
		case packet := <-packetChannel:
           // do something
        case default:
           // do something if there's no packages yet
        }
    }
{{< / highlight >}}

Anyhow, from there, from the IP layer we can get the IPs involved, and from the TCP or UDP layers we can get the ports
associated with each.

From that information, how do we know which process is the one sending that package?

# How does `ss` do it?

I was curious to check what the `ss` command (the successor of `netstat`) does to get that information, so I went and
straced it xd

{{< highlight shell >}}
$ strace ss -tnp 2>&1 1>/dev/null | vim -
{{< /highlight >}}

From there I was seeing that it's navigating the whole `/proc/<pid>` tree, and for each is checking the `fd`, and then
doing a `readlink` on each of the entries, checking then where are they pointing too and using that info to get the
sockets and ports:

{{< highlight shell >}}
...  lots of permission denied, I was not root
openat(AT_FDCWD, "/proc/3105/fd/", O_RDONLY|O_NONBLOCK|O_CLOEXEC|O_DIRECTORY) = 4
...
readlink("/proc/3105/fd/0", "/dev/null", 63) = 9
readlink("/proc/3105/fd/1", "socket:[31324]", 63) = 14  # this is a socket on port 31324
...
{{< /highlight >}}


So that was interesting, `netstat` ends up doing the same too.

# /proc/net

Another option is `/proc/net`, here you'll find all the network connections. So that's the first thing I tried.

Easy enough, that was working really well when trying to sniff on simple processes (ex. on one terminal you start the
sniffer, and on another you run a `curl` command), but you will not see things running on containers, here's why:

`/proc/net` is a link to `/proc/self/net`, and `/proc/self` is in itself a link to `/proc/<pid>` where `pid` is the
process id of the current process.

Now, anything under  `/proc/<pid>/net` show all the connections **in that process network namespace**, and well, in
linux containers are implemented with those namespaces so what you are seeing is actually the network connections for
the namespace of the current process, and that most probably does not include containers.

Another thing to have into account, is that `/proc/<pid>/net` has **all** the network connections in the process network
namespace, including the ones not started by that process, so you still have to filter them out.

So on a quick note, here's how many processes are there on each network namespace on a k8s node (looking directly into
`/proc/<pid>/ns` as docker does not add an entry in the global `/var/run/netns`):

{{< highlight shell >}}
dcaro@tools-k8s-worker-32:~/netstnoop$ sudo ls -la /proc/*/ns/net | awk '{print $11}' | sort | uniq -c | head
ls: cannot read symbolic link '/proc/17747/ns/net': No such file or directory
      1
    209 net:[4026531992]
      1 net:[4026532222]
     20 net:[4026532352]
      6 net:[4026532449]
      9 net:[4026532534]
      6 net:[4026532607]
      7 net:[4026532807]
      9 net:[4026533066]
      ...
{{< /highlight >}}

Note also that even the time between bash expanding `/proc/*/ns/net` and ls reading the files some processes don't
exist anymore, giving the `No such file` error.


# How to figure all that out then?
{{< highlight pseudocode >}}
for every pid in `/proc`, do
    if it's namespace has not been visited:
        check the `net/*` directories for the services we are interested in
        if any matches:
            add user owner of the namespace file and the namespace service counts to the stats
        add namespace to visited list
    if it has been visited:
        do nothing 
{{< /highlight >}}

This is because:
* we don't care about that specific packet, just any "user" that has a namespace in which a process is contacting those services
* the namespace file owner is the same as the user we care about

# How could you find out the specific process that sent the package?

That is a bit more complicated :/

For that we have to:

* Follow the process above to get which namespace is the one that is contacting that IP/port
* Once you have the namespace, you can also extract the inode (from the same net file `/proc/<pid>/net/*`)
* With the inode, you can then look at all the open files for each process on that same namespace (`/proc/*/fd/*`)
* That will give you the processes that have that socket open (note that could be more than one!)

Enjoy!
