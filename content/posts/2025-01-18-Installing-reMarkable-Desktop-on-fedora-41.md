---
title: "Installing ReMarkable Desktop on Fedora 41"
date: 2025-01-18T16:29:54+01:00
draft: false
tags: [remarkable, programming]
---

I was able today to get installed (finally) the reMarkable Desktop app (3.16.1)
on my fedora 41 machine, this post is to write down the shenanigans I had to do
to get it working :)

So first of all, make sure you have a clean wine installation (I had been
messing with wine and had some custom things going on):

```shell
> sudo dnf remove wine
> sudo dnf remove winetricks  # optional
> rm -rf ~/.wine  # careful if you have more stuff installed in the default wine prefix
```

Reinstall:

```shell
> sudo dnf install wine winetricks
```

Run the reMarkable installer (you'll have to download it from their page):

```shell
> wine reMarkable-3.16.1.901-win64.exe
```

And install it, make sure to remember the path you install it in.

If you are getting an error there, maybe you are using the wrong wine prefix,
make sure you are using a clean one.

After installation, when trying to run it you'll be getting an error like:

```shell
wine: Unhandled page fault on read access to 0000000000000000 at address 00006FFFF3B04A48 (thread 01cc), starting debugger...
01ec:fixme:dbghelp:elf_search_auxv can't find symbol in module
01ec:fixme:dbghelp:elf_search_auxv can't find symbol in module
```

What you have to do, is disable the offending libraries from the reMarkable
installation:

```shell
> cd <path_where_you_installed_reMarkable>
> mv ./networkinformation/qnetworklistmanager.dll ./networkinformation/qnetworklistmanager.dll.disabled
```

Try to run it again and voila! \o/

Even sharing the device screen works like a charm :)
