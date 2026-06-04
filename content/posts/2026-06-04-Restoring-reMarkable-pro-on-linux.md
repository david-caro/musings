---
tags: ["computer science", "Remarkable"]
title: "Restoring ReMarkable Pro on Linux"
date: 2026-06-04T10:18:38+02:00
draft: false
---

Today I borked my remarkable pro tablet by trying to set a passcode. Right after
confirming the passcode it rebooted and got in a reboot loop (my guess, it tried
to encrypt the disk and something failed or timed out, and then the reboot was
unable to go through).

In any case, trying to recover it is not straightforward as reMarkable does not
officially support Linux. However, I did find a way to get it working again.

First of all, you have to **make sure the remarkable is charged**, for that you
have to plug it into a laptop usb for say 30min (socket chargers might just
ignore it if it does not have enough charge already, learn that the hard way).

Run the following script:

```bash
#!/bin/bash
# See https://developer.remarkable.com/documentation/recovery-for-linux-host

set -o errexit
set -o nounset
set -o pipefail

PAPER_PRO_VENDOR_ID="1fc9:0134"
RECOVER_TOOL_DEST_PATH="$HOME/bin/rm_recover"
RECOVERY_TOOL_URL_PREFIX="https://device-recovery.cloud.remarkable.com/host/"
RECOVERY_TOOL_URL_POSTFIX="/x86_64-unknown-linux-gnu-public/bin/rm_recover"
KNOWN_VERSION="1.14.1"
KNOWN_SHA="2e835990e57737b2c780be7660608cf1eed22a9d87a0014656a2ef0a20b14662"


get_latest_version() {
    local version_data \
        major_version \
        minor_version \
        patch_version
    version_data=$(rm_recover check-version | grep 'Latest release')
    major_version=$(echo "$version_data"| grep -o -P '(?<=major: )[^,]*')
    minor_version=$(echo "$version_data"| grep -o -P '(?<=minor: )[^,]*')
    patch_version=$(echo "$version_data"| grep -o -P '(?<=patch: )[^ }]*')
    echo "$major_version.$minor_version.$patch_version"
}


get_current_version() {
    local version_data \
        major_version \
        minor_version \
        patch_version
    version_data=$(rm_recover check-version | grep 'This version')
    major_version=$(echo "$version_data"| grep -o -P '(?<=major: )[^,]*')
    minor_version=$(echo "$version_data"| grep -o -P '(?<=minor: )[^,]*')
    patch_version=$(echo "$version_data"| grep -o -P '(?<=patch: )[^ }]*')
    echo "$major_version.$minor_version.$patch_version"
}


check_in_development_mode() {
    lsusb | grep -q "$PAPER_PRO_VENDOR_ID"
}

download_recovery_tool() {
    local version="${1?No version passed}"
    local sha="${2:-}"
    echo "Downloading recovery tool..."
    curl "$RECOVERY_TOOL_URL_PREFIX$version$RECOVERY_TOOL_URL_POSTFIX" -o "$RECOVER_TOOL_DEST_PATH"
    sha256sum rm_recover | grep -q "$sha" || {
        cat <<EOH
ERROR: Failed to verify the download of the recovery tool, maybe the sha changed?

You can try checking the webpage for updates
     https://developer.remarkable.com/documentation/recovery-for-linux-host

Got downloaded tool sha:
$(sha256sum rm_recover)

Expected tool sha:
$sha
EOH
        exit 1
    }
}

install() {
    local version="${1:-$KNOWN_VERSION}"
    local sha="${2:-}"
    download_recovery_tool "$version" "$sha"
    chmod u+x rm_recover
    echo "Downloading uuu and other tools, the recovery tool will fail this first time"
    rm_recover restore 2>/dev/null 1>&2|| :
    artifacts_dir=$(rm_recover artifacts | grep 'Artifacts dir: ' | grep -o '/.*')
    echo -e "\n\nGot artifacts in $artifacts_dir, adding uuu to the path"
    [[ -f /usr/local/bin/uuu ]] || sudo ln -s "$artifacts_dir/uuu" /usr/local/bin/uuu
    echo "Remarkable tools installed."
}


main() {
    if ! command -v rm_recover; then
        install "$KNOWN_VERSION" "$KNOWN_SHA"
    else
        echo "Using already installed rm_recover"
    fi

    echo "Checking for updates"
    latest_version=$(get_latest_version)
    current_version=$(get_current_version)
    if [[ "$latest_version" != "$current_version" ]]; then
        echo "Found a newer version, want to upgrade it? [y/n]"
        read response
        if [[ "$response" =~ ^[yY] ]]; then
            echo "Upgrading to $latest_version"
            install "$latest_version" ""
        fi
    else
        echo "   already in the latest version $current_version"
    fi

    sudo $(which rm_recover) "$@"
}


main "$@"
```

This will download the latest version of the official linux client (only
available from the development forums), and set it up.

Note that this does not setup the udev rules for you to be able to restore your
remarkable as a regular user, for that you can check
[this page](https://developer.remarkable.com/documentation/recovery-for-linux-host).

With that I was able to reset to factory my remarkable and save me the trouble
of having to either find a windows/macos machine, or send my device to get
replaced.
