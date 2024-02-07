#!/bin/bash

read -p "Do you want to install H.265 codec support? (y/n): " install_h265
if [ "$install_h265" == "y" ]; then
    echo "Installing RPMFusion and H.265 codec..."
    if sudo dnf install -y \
        https://mirrors.rpmfusion.org/free/fedora/rpmfusion-free-release-$(rpm -E %fedora).noarch.rpm \
        https://mirrors.rpmfusion.org/nonfree/fedora/rpmfusion-nonfree-release-$(rpm -E %fedora).noarch.rpm && \
        sudo dnf swap ffmpeg-free ffmpeg --allowerasing && \
        sudo dnf groupupdate multimedia --setop="install_weak_deps=False" --exclude=PackageKit-gstreamer-plugin && \
        sudo dnf groupupdate sound-and-video; then
        echo "Done!"
    else
        echo "Installation failed. Please check for errors."
    fi
else
    echo "Skipping H.265 codec installation. You can manually install it later if needed."
fi
