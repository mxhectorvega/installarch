#!/bin/bash

# -*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-* 
# Pacman configuraciones
# -*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-* 
clear 
printf '\n \nConfigurando gestor de paquetes Pacman...\n'
sleep 1
sudo sed -i "s/#Color/Color/g" /etc/pacman.conf 
sudo sed -i "s/#TotalDownload/TotalDownload/g" /etc/pacman.conf 
sudo sed -i "s/#VerbosePkgLists/VerbosePkgLists/g" /etc/pacman.conf 
sudo sed -i "s/#ParallelDownloads/ParallelDownloads/g" /etc/pacman.conf
sudo sed -i "38i ILoveCandy" /etc/pacman.conf 
sudo sed -i "s/#[multilib]/[multilib]/g" /etc/pacman.conf 
sudo sed -i "s/#Include = /etc/pacman.d/mirrorlist /Include = /etc/pacman.d/mirrorlist/g" /etc/pacman.conf

# -*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-* 
# Paquetes adicionales
# -*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-* 
clear
printf '\n \nInstalando paquetes adicionales...\n'
sleep 1
sudo pacman -S sxiv mupdf zathura feh i3blocks file-roller git mpv neofetch firefox telegram-desktop mousepad htop bpytop ranger nano gcc make xdg-user-dirs gvfs thunar thunar-volman lxappearance nmtui tumbler ffmpegthumbnailer --noconfirm --needed
sudo pacman -S ttf-{dejavu,hack,roboto,liberation} wqy-microhei bdf-unifont unicode-character-database noto-fonts-emoji --noconfirm

# -*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-* 
# Paru AUR helper
# -*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-* 
clear 
printf '\n \nnstalando el gestor de paquetes Paru...\n'
sleep 1
cd ; git clone https://aur.archlinux.org/paru-bin.git ; cd paru-bin ; makepkg -si --noconfirm ; cd ; rm -rf paru-bin

# -*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-* 
# Dotfiles Fedora en Arch
# -*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-* 
clear
printf '\n \nEscribe la contraseña para reemplazar archivo .bashrc...\n'
mkdir "$HOME"/.local/bin
mkdir "$HOME"/.local/share
mkdir "$HOME"/.local/share/fonts
sudo rm -rf "$HOME"/.bashrc

clear
printf '\n \nClonando repositorios mxhectorvega...\n'
sleep 1
git clone https://github.com/mxhectorvega/i3-fedora /tmp/i3-fedora
git clone https://github.com/mxhectorvega/tipografias  /tmp/tipografias
cp -rp /tmp/i3-fedora/.* "$HOME"
cp -rp /tmp/tipografias/.* "$HOME"/.local/share/fonts

# -*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-* 
# Todo el SO en español
# -*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-* 
clear 
printf '\n \nEstableciendo español como idioma predeterminado...\n'
sleep 1
sudo tee /etc/locale.conf <<EOF
LANG="es_MX.UTF-8"
LC_CTYPE="es_MX.UTF-8"
LC_NUMERIC="es_MX.UTF-8"
LC_TIME="es_MX.UTF-8"
LC_COLLATE="es_MX.UTF-8"
LC_MONETARY="es_MX.UTF-8"
LC_MESSAGES="es_MX.UTF-8"
LC_PAPER="es_MX.UTF-8"
LC_NAME="es_MX.UTF-8"
LC_ADDRESS="es_MX.UTF-8"
LC_TELEPHONE="es_MX.UTF-8"
LC_MEASUREMENT="es_MX.UTF-8"
LC_IDENTIFICATION="es_MX.UTF-8"
LC_ALL=
EOF
sudo tee /etc/locale.gen <<EOF
es_MX.UTF-8 UTF-8
EOF
sudo localectl set-locale LANG=es_MX.UTF-8
sudo locale-gen
xdg-user-dirs-update --force
sudo timedatectl set-timezone America/Mexico_City
sudo timedatectl set-ntp yes

# -*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-* 
# Creando archivo SWAP
# -*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-* 
clear 
printf '\n \nreando archivo SWAP...\n'
sleep 1
sudo btrfs su cr /swap
sudo chmod 700 /swap
sudo truncate -s 0 /swap/swapfile
sudo chattr +C /swap/swapfile
sudo btrfs property set /swap/swapfile compression none
sudo fallocate -l 3G /swap/swapfile
sudo chmod 600 /swap/swapfile
sudo mkswap /swap/swapfile
sudo swapon /swap/swapfile
sudo tee -a /etc/fstab <<EOF

# SWAP device
/swap/swapfile none swap defaults 0 0
EOF
