#!/bin/bash

if [ "$EUID" -ne 0 ]; then
    echo "This script should be run as root."
    exit 1
fi

## Functions
function os_version() {
    if [ -f /etc/os-release ]; then
        # freedesktop.org and systemd
        . /etc/os-release
        OS=$ID
        VER=$VERSION_ID
    elif type lsb_release >/dev/null 2>&1; then
        # linuxbase.org
        OS=$(lsb_release -si)
        VER=$(lsb_release -sr)
    elif [ -f /etc/lsb-release ]; then
        # For some versions of Debian/Ubuntu without lsb_release command
        . /etc/lsb-release
        OS=$DISTRIB_ID
        VER=$DISTRIB_RELEASE
    elif [ -f /etc/debian_version ]; then
        # Older Debian/Ubuntu/etc.
        OS=Debian
        VER=$(cat /etc/debian_version)
    elif [ -f /etc/SuSe-release ]; then
        # Older SuSE/etc.
        ...
    elif [ -f /etc/redhat-release ]; then
        # Older Red Hat, CentOS, etc.
        ...
    else
        # Fall back to uname, e.g. "Linux <version>", also works for BSD, etc.
        OS=$(uname -s)
        VER=$(uname -r)
    fi

    echo "$OS"
}

## Functions copied from LARBS.
## (https://larbs.xyz | https://github.com/Lukesmithxyz)

error() { clear; printf "ERROR:\\n%s\\n" "$1"; exit;}

getuserandpass() {
	name=$(dialog --inputbox "Enter a name for the user account." 10 60 3>&1 1>&2 2>&3 3>&1) || exit
	while ! echo "$name" | grep "^[a-z_][a-z0-9_-]*$" >/dev/null 2>&1; do
		name=$(dialog --no-cancel --inputbox "Username not valid. Give a username beginning with a letter, with only lowercase letters, - or _." 10 60 3>&1 1>&2 2>&3 3>&1)
	done
	pass1=$(dialog --no-cancel --passwordbox "Enter a password for that user." 10 60 3>&1 1>&2 2>&3 3>&1)
	pass2=$(dialog --no-cancel --passwordbox "Retype password." 10 60 3>&1 1>&2 2>&3 3>&1)
	while ! [ "$pass1" = "$pass2" ]; do
		unset pass2
		pass1=$(dialog --no-cancel --passwordbox "Passwords do not match.\\n\\nEnter password again." 10 60 3>&1 1>&2 2>&3 3>&1)
		pass2=$(dialog --no-cancel --passwordbox "Retype password." 10 60 3>&1 1>&2 2>&3 3>&1)
	done ;
}

usercheck() { 
	! (id -u "$name" >/dev/null) 2>&1 ||
	dialog --colors --title "WARNING!" --yes-label "CONTINUE" --no-label "No" --yesno "The user \`$name\` already exists on this system. EAST can continue installing for $name but will change it's password." 14 70
}

putfiles() { 
	dialog --infobox "Installing config files..." 4 60
	[ ! -d "$2" ] && mkdir -p "$2" && chown -R "$name:wheel" "$2"
	sudo -u "$name" cp -rfT "$1" "$2"
}

preinstallmsg() { 
	dialog --title "Install?" --yes-label "Yes" --no-label "Nope" --yesno "Continue with installation?.\\n\\nIt will take some time, but when done, you can relax even more with your complete system.\\n\\nNow just press <Yes> and the system will begin installation!" 13 60 || { clear; exit; }
}

adduserandpass() { 
	dialog --infobox "Adding user \"$name\"..." 4 50
	useradd -m -g wheel -s /bin/bash "$name" >/dev/null 2>&1 ||
	usermod -a -G wheel "$name" && mkdir -p /home/"$name" && chown "$name":wheel /home/"$name"
	echo "$name:$pass1" | chpasswd
	unset pass1 pass2 ;
}

## Used by archlinux.
function install_packages_pacman() {
    pacman --noconfirm -S $@
}

function install_packages_xbps() {
    xbps-install -Syf $@
}

export OS=$(os_version)
export PACKAGECTL=""
case $OS in
    "arch" | "manjaro") 
        PACKAGECTL="pacman" 
        pacman -S --noconfirm --needed dialog ;;
    "void") 
        PACKAGECTL="xbps" 
        xbps-install -Syf dialog ;;
    *)
        echo "Only Arch and Voidlinux are supported"
        echo "Visit https://eivor.xyz/east to request support" ;;
esac

export EAST_DIR=$( cd "$(dirname "$0")" ; pwd -P )

dialog --title "EAST Installation Script" --msgbox "Installing for OS ${OS}\\n\\nBase directory: ${EAST_DIR}" 10 60

getuserandpass || error "Cannot get username and password."

usercheck || error "Cannot check for $name's validatity"

preinstallmsg || error "User exited."

adduserandpass || error "Error adding username and/or password."

export EAST_USER="$name"
export home="/home/$EAST_USER"
export deu="sudo -u $EAST_USER"

declare -a packages=(
                        "wget"
                        "neovim"
                        "xorg-server"
                        "xorg-server-common"
                        "xorg-xinit"
                        "xcompmgr"
                        "python-pip"
                        "lightdm"
                        "lightdm-gtk-greeter"
                        "lightdm-gtk-greeter-settings"
                        "pulseaudio"
                        "pulsemixer"
                        "i3-gaps"
                        "i3blocks"
                        "openssh"
                        "cronie"
                        "bash-completion"
                        "neomutt"
                        "nitrogen"
                        "linux-headers"
                        "xfce4-terminal"
                        "firefox"
                        "scrot"
                        "dunst"
                    )

echo "Performing a system udpate."
system_update_${PACKAGECTL}


echo "Executing 2 pre-sync scripts..."
cd $EAST_DIR/._presync
(
    for f in *.sh; do
        echo ">>> $f"
        bash "$f" -H || exit $?
    done
)

if [[ "$?" -ne 0 ]]; then
    echo "A pre-install script has failed."
    exit 27
fi


echo "Installing packages..."
install_packages_${PACKAGECTL} ${packages[@]}


echo "Executing 1 post-sync scripts..."
cd $EAST_DIR/._postsync
(
    for f in *.sh; do
        echo ">>> $f"
        bash "$f" -H || exit $?
    done
)

if [[ "$?" -ne 0 ]]; then
    echo "A post-install script has failed."
    exit 27
fi


putfiles "$EAST_DIR/._home" "/home/$name"