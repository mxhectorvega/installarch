#!/usr/bin/env bash

# Titulo: Post-install para i3 en Archlinux
# Autor: Hector Ivan Vega Zamudio
# Correo: mxhectorvega@gmail.com
# Link: https://github.com/mxhectorvega
# Version:v3.0
# fecha de actualización 12/06/2022
# Nota: El sistema de preferencia tuvo que haber sido instalado con la herramienta archinstall del liveUSB,
# Seleccionando el perfil i3 con todos los controladores de código abierto.

# Pacman configuraciones
clear 
printf '\n \nConfigurando gestor de paquetes Pacman...\n'
sleep 1
sudo sed -i "s/#Color/Color/g" /etc/pacman.conf 
sudo sed -i "s/#ParallelDownloads/ParallelDownloads/g" /etc/pacman.conf
sudo sed -i "38i ILoveCandy" /etc/pacman.conf

# Paquetes adicionales
clear
printf '\n \nInstalando paquetes adicionales...\n'
sleep 1
sudo pacman -S light maim xclip iw alsa-utils upower sxiv mupdf zathura feh file-roller git mpv picom neofetch firefox telegram-desktop mousepad htop bpytop ranger nano gcc make xdg-user-dirs gvfs thunar thunar-volman lxappearance tumbler ffmpegthumbnailer --noconfirm --needed
sudo pacman -S ttf-{dejavu,hack,roboto,liberation} wqy-microhei bdf-unifont unicode-character-database --noconfirm

# Paru AUR helper
clear 
printf '\n \nnstalando el gestor de paquetes Paru...\n'
sleep 1
cd ; git clone https://aur.archlinux.org/paru-bin.git ; cd paru-bin ; makepkg -si --noconfirm ; cd ; rm -rf paru-bin

# Dotfiles Fedora en Arch
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

# Creando directorios de usuario
xdg-user-dirs-update --force

# Otorgando permisos para cambiar brillo de pantalla
sudo chmod +s /usr/bin/light

