## INSTALLARCH

_Este repositorio contiene scripts en bash que instalan mis configuraciones personales de entornos de escritorio como gnome o kde, gestores de ventanas para wayland o xorg, enfocados en mejorar el rendimiento, sin sacrificar un buen diseño o compatibilidad con software del usuario doméstico._

**Recomendación:**

El script se debe ejecutarse, despues de una **instalación* limpia, echa por el método oficial **archinstall**, seleccionado el perfil **desktop** de su eleccion.

**Gestores de ventanas:**
- Hyprland
- Sway
- BWPWM
- i3

**Entornos de escritorios:**
- Gnome 
- Kde Plasma
- Budgie

**Método UNO de instalación:**

La instalación se efectuara en la tty o terminal según el caso, cambiando `gnome` por el entorno o gestor de ventanas deseado, ejemplo:
```sh
bash <(curl -L is.gd/mxgnome)
```

**Método DOS de instalación:**

Puede descargar el script para editar al gusto ejemplo:
`wget is.gd/mxgnome`

Para después editar el archivo
`vim mxgnome`

**Creditos:**
@mxhectorvega @darch7 @cristoalv @bourne_again @tenashito y muchos otros de la comunidad Linux.
