#!/bin/bash

# Check if the system is Fedora
if [ -f /etc/fedora-release ]; then
    echo -n "This system is running Fedora. "
    
    # Prompt user for H.265 codec installation
    read -p "Do you want to install H.265 codec support? (y/n): " install_h265
    if [ "$install_h265" == "y" ]; then
        echo "Installing RPMFusion..."
        sudo dnf install -y https://download1.rpmfusion.org/free/fedora/rpmfusion-free-release-$(rpm -E %fedora).noarch.rpm https://download1.rpmfusion.org/nonfree/fedora/rpmfusion-nonfree-release-$(rpm -E %fedora).noarch.rpm
        sleep 1

        echo "Installing libheic..."
        sudo dnf install -y libheif
        sleep 1

        echo "Installing heif-pixbuf-loader..."
        sudo dnf install -y gnome-photos
        sleep 1

        echo "Installing libheif-tools..."
        sudo dnf install -y libheif-tools
        sleep 1

        echo "Swapping ffmpeg-free with ffmpeg..."
        sudo dnf swap -y ffmpeg-libs ffmpeg
        sleep 1

        echo "Installing ffmepgthumbnailer..."
        sudo dnf install -y ffmpegthumbnailer
        sleep 1

        echo "Done! HEVC videos will now play through Celluloid or VLC."
    else
        echo "Skipping H.265 codec installation. You can manually install it later if needed."
    fi
else
    echo "You are not running Fedora, so we cannot proceed to install the H.265 codec. Please seek help to see if your distro supports H.265, either natively or with a manual codec installation."
fi

