---
title: "Starting envoy on Rpi 4 - recompiling a new kernel"
date: 2023-04-17T13:38:17+02:00
tags: [envoy, rpi, homelab, kernel]
draft: false
---
My main server died the other day, and it was the one running envoy for the rest of the lab hosts, so I decided to move envoy to one of the raspberry pi 4 that I have idling around.

# First try

Now, these raspberries are running debian bullseye, but it seems that envoy [does not build packages for debian](https://github.com/envoyproxy/envoy/issues/16867), and Tetrate (the ones that build some) stopped building them in 2021 :/

I saw though that there's [official images for arm64](https://hub.docker.com/r/envoyproxy/envoy/tags/?page=1&name=latest) (yay!), so I decided to use one of those :)

Little I knew that they would actually not work out of the box:
```
$ sudo podman run  --privileged --arch arm64 --rm docker.io/envoyproxy/envoy:v1.24-latest
Trying to pull docker.io/envoyproxy/envoy:v1.24-latest...
Getting image source signatures
Copying blob 6a82b170b6f7 done
Copying blob 7d588ee5d67c done
Copying blob 7a2e7d9bd4cc done
Copying blob a774dfcdedc7 done
Copying blob 420cd3903add done
Copying blob dcb0f7060b9e done
Copying blob 28c3e1133804 done
Copying blob 6e730ab52427 done
Copying config 10c90469e5 done
Writing manifest to image destination
Storing signatures
external/com_github_google_tcmalloc/tcmalloc/system-alloc.cc:614] MmapAligned() failed - unable to allocate with tag (hint, size, alignment) - is something limiting address placement? 0x41900000000 1073741824 1073741824 @ 0x55944021fc 0x55943fd76c 0x55943fd118 0x55943e4700 0x55943fa044 0x55943f9e5c 0x55943d8ef8 0x5594312618 0x559430e710 0x55943cf0c8 0x7f9d1b4db8
external/com_github_google_tcmalloc/tcmalloc/arena.cc:58] FATAL ERROR: Out of memory trying to allocate internal tcmalloc data (bytes, object-size); is something preventing mmap from succeeding (sandbox, VSS limitations)? 131072 600 @ 0x559440255c 0x55943e4790 0x55943fa044 0x55943f9e5c 0x55943d8ef8 0x5594312618 0x559430e710 0x55943cf0c8 0x7f9d1b4db8
```

Hmm... it seems that it gets out of memory somehow... but it has more than enough.
It turns out that it runs out of **virtual memory**!

This is because by default, the raspberry-pi kernel is built using a [smaller amount of bits for the virtual memory addressing](https://github.com/envoyproxy/envoy/issues/15235#issuecomment-850516622), it uses 39 instead of the common 48, and envoy relies on the 48 when doing the memory allocation at boot.

To fix this, you have to recompile the kernel changing that specific option. Let's see the steps:

# Compiling a new kernel

The steps followed are from [here mostly](https://www.raspberrypi.com/documentation/computers/linux_kernel.html):

```
# clone the repo
git clone --depth=1 https://github.com/raspberrypi/linux
cd linux
make bcm2711_defconfig  # add default configs
make menuconfig  # this allows easily changing any settings
# for this change, you have to go to "Kernel features -> Virtual address space size"
# Change from 39 to 48
make -j4 Image.gz modules dtbs  # this takes a while
KERNEL=kernel8  # name of your new kernel
sudo make modules_install
sudo cp arch/arm64/boot/dts/broadcom/*.dtb /boot/
sudo cp arch/arm64/boot/dts/overlays/*.dtb* /boot/overlays/
sudo cp arch/arm64/boot/dts/overlays/README /boot/overlays/
sudo cp arch/arm64/boot/Image.gz /boot/$KERNEL.img
```

Once done, you can just reboot and you are in your new kernel!
```
$ uname -a
Linux node5 6.1.23-v8+ #1 SMP PREEMPT Sun Apr 16 21:52:56 BST 2023 aarch64 GNU/Linux
```

Okok, back to envoy now.

## Envoy success!

Now with the new kernel, envoy works!

```
$ sudo podman run --privileged --arch arm64 --rm docker.io/envoyproxy/envoy:v1.24-latest
...
[2023-04-17 16:21:31.005][1][info][admin] [source/server/admin/admin.cc:67] admin address: 0.0.0.0:9901
[2023-04-17 16:21:31.006][1][info][config] [source/server/configuration_impl.cc:131] loading tracing configuration
[2023-04-17 16:21:31.006][1][info][config] [source/server/configuration_impl.cc:91] loading 0 static secret(s)
[2023-04-17 16:21:31.006][1][info][config] [source/server/configuration_impl.cc:97] loading 1 cluster(s)
[2023-04-17 16:21:31.011][1][info][config] [source/server/configuration_impl.cc:101] loading 1 listener(s)
[2023-04-17 16:21:31.016][1][info][config] [source/server/configuration_impl.cc:113] loading stats configuration
[2023-04-17 16:21:31.018][1][info][main] [source/server/server.cc:915] starting main dispatch loop
...
```

\o/
Next step, configuring envoy