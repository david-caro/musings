---
tags: [sway, vscode, protonmail]
title: "Fixing Fonts for Vscode and Protonmail in sway (Electron Apps)"
date: 2025-10-26T12:15:50+01:00
draft: false
---

Dropping this here as I have not found many places in the internet that note it.

If you see blurry/when running an app based on chromium under sway window
manager (ex. electron apps, like protonmail or vscode), you might be able to fix
it by specifying the following option when starting your application:

```shell
>$ code --ozone-platform=wayland path/to/mycode
```

Not sure why that's not detected by default, but don't have the time or interest
right now to go investigate. There's a bunch more info here:

https://chromium.googlesource.com/chromium/src/+/lkgr/docs/ozone_overview.md
