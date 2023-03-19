#!/usr/bin/env bash

# Titulo: Post-install para i3 en Archlinux
# Autor: Héctor Iván Vega Zamudio
# Correo: mxhectorvega@gmail.com
# Link: https://github.com/mxhectorvega/installarch
# Version: 3.2
# Fecha de actualización 19/03/2023
# Nota: El sistema de preferencia debe haber sido instalado con la
# herramienta archinstall del liveUSB, seleccionando el perfil i3.

# Actualización
sudo pacman -Syyu --noconfirm

# Internos para el SO
sudo pacman -S usbutils ntfs-3g flatpak pacman-contrib xdg-user-dirs --noconfirm --needed
# Para ejecutar desde la terminal
sudo pacman -S git make gcc curl wget htop vim fuse less man --noconfirm --needed 

# Repo chaotic
sudo pacman -Syyu --noconfirm
sudo pacman-key --recv-key FBA220DFC880C036 --keyserver keyserver.ubuntu.com
sudo pacman-key --lsign-key FBA220DFC880C036
sudo pacman -U 'https://cdn-mirror.chaotic.cx/chaotic-aur/chaotic-keyring.pkg.tar.zst' 'https://cdn-mirror.chaotic.cx/chaotic-aur/chaotic-mirrorlist.pkg.tar.zst' --noconfirm
sudo tee -a /etc/pacman.conf <<EOF
[chaotic-aur]
Include = /etc/pacman.d/chaotic-mirrorlist
EOF

# Paru
cd ; git clone https://aur.archlinux.org/paru-bin.git ; cd paru-bin ; makepkg -si --noconfirm ; cd ; rm -rf paru-bin
sudo sed -i "s/#BottomUp/BottomUp/g" /etc/paru.conf

# Actualización
sudo pacman -Syyu --noconfirm

# Paquetes adicionales
clear
sudo pacman -S light maim xclip iw alsa-utils upower sxiv mupdf zathura feh file-roller git mpv picom neofetch firefox telegram-desktop mousepad htop bpytop ranger nano gcc make xdg-user-dirs gvfs thunar thunar-volman lxappearance tumbler ffmpegthumbnailer --noconfirm --needed

# Dotfiles Fedora en Arch
clear
mkdir "$HOME"/.local/bin
mkdir "$HOME"/.local/share
mkdir "$HOME"/.local/share/fonts
sudo rm -rf "$HOME"/.bashrc

clear
git clone https://github.com/mxhectorvega/i3-fedora /tmp/i3-fedora
git clone https://github.com/mxhectorvega/tipografias  /tmp/tipografias
cp -rp /tmp/i3-fedora/.* "$HOME"
cp -rp /tmp/tipografias/.* "$HOME"/.local/share/fonts

# Creando directorios de usuario
xdg-user-dirs-update --force

# Otorgando permisos para cambiar brillo de pantalla
sudo chmod +s /usr/bin/light

# Mensaje final
sleep 1
printf '\n\n\tContribuye:\n\tmxhectorvega.ml\n\n\n'
