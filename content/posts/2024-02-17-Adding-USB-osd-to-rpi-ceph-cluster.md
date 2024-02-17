---
title: "Adding USB Osd to Rpi Ceph Cluster"
date: 2024-02-17T23:58:16+01:00
tags: [envoy, rpi, homelab, ceph]
---

I was trying to add some new USB disks to my ceph cluster, and then I remembered
that ceph-volume
[does not support to use removable USB devices for OSDs](https://tracker.ceph.com/issues/38833)
:/

To do so, I had to go to the host with the new drives, and then open a
`cephadm shell` and modify the `ceph-volume` library:

```
root@node1:~# cephadm shell
Inferring fsid d49b287a-b680-11eb-95d4-e45f010c03a8
Inferring config /var/lib/ceph/d49b287a-b680-11eb-95d4-e45f010c03a8/mon.node1/config
Using recent ceph image quay.io/ceph/ceph@sha256:6d83dc7540a56ba51c05f412c3def8e2d7e624501b25e5a00e31f3d53d4cf578

root@node1:/# vi /usr/lib/python3.6/site-packages/ceph_volume/util/disk.py
# remove the following lines:
804         if get_file_contents(os.path.join(_sys_block_path, dev, 'removable')) == "1":
805             continue
```

That allows you to then zap and prepare the osds, but we have to set the keyring
first:

```
root@node1:/# ceph auth get client.bootstrap-osd > /var/lib/ceph/bootstrap-osd/ceph.keyring
```

Now we are ready to zap + prepare:

```
root@node1:/# ceph-volume lvm zap /dev/sda
...

root@node1:/# ceph-volume lvm prepare --data /dev/sda
```

Once we have done that, we can tell ceph-orch to create the osd daemons, it will
pick up all of them:

```
root@node1:/# ceph orch daemon add osd node1:/dev/sda lvm
...
```

And voilà!

We got our new osds up and running :)
