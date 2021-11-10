#!/bin/sh
# Postinstall i3wm en ArchLinux
# Autor:
# Hector Ivan Vega Zamudio
# mxhectorvega@gmail.com
# https://github.com/mxhectorvega
# Version:
# v1.5: 21/09/2021 - Configuracion para una instalacion limpia con archinstall ejecutado desde el LiveUSB.

# Pacman configuraciones
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

# Todo el SO en español
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
sudo timedatectl set-timezone America/Mexico_City
sudo timedatectl set-ntp yes

# Creando archivo SWAP
clear 
printf '\n \nreando archivo SWAP...\n'
sleep 1
sudo btrfs su cr /swap
sudo chmod 700 /swap
sudo truncate -s 0 /swap/swapfile
sudo chattr +C /swap/swapfile
sudo btrfs property set /swap/swapfile compression none
sudo fallocate -l 4G /swap/swapfile
sudo chmod 600 /swap/swapfile
sudo mkswap /swap/swapfile
sudo swapon /swap/swapfile
sudo tee -a /etc/fstab <<EOF

# SWAP device
/swap/swapfile none swap defaults 0 0
EOF

# Creando archivo SWAP
clear 
printf '\n \nCreando Zram...\n'
sleep 1
sudo tee /etc/modules-load.d/zram.conf <<EOF
zram
EOF

# Fill ATTR{disksize} with about 150% of physically available RAM for doubling RAM or 75% for i.e. file servers
sudo tee /etc/udev/rules.d/99-zram.rules <<'EOF'
KERNEL=="zram0", ATTR{initstate}=="0", ATTR{comp_algorithm}="lz4", ATTR{disksize}="3G", RUN="/sbin/mkswap $env{DEVNAME}", TAG+="systemd"
EOF

sudo tee -a /etc/fstab <<EOF
# ZRAM Swap device
/dev/zram0 none swap defaults 0 0
EOF

sudo tee -a /etc/sysctl.d/99-sysctl.conf <<EOF
# 128 MB of data before starting asynchronous writes
vm.dirty_background_bytes = 134217728
# use a maximum of 50% of RAM for caching before starting synchronous writes
vm.dirty_ratio = 50
# expire after 15 seconds
vm.dirty_expire_centisecs = 1500
# check expiration every 15 seconds
vm.dirty_writeback_centisecs = 1500
# disable nmi wactchdog (not really fs related)
kernel.nmi_watchdog = 0
EOF

# Creando directorios de usuario
xdg-user-dirs-update --force

# Otorgando permisos para cambiar brillo de pantalla
sudo chmod +s /usr/bin/light

