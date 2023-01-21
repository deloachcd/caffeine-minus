#!/bin/bash

install() {
    if [[ "$XDG_SESSION_TYPE" == "x11" ]]; then
        PKGNAME="xdotool"
    elif [[ "$XDG_SESSION_TYPE" == "wayland" ]]; then
        PKGNAME="wtype"
    else
        echo "Could not detect X11 or Wayland session! (Are you not running a GUI?)"
        exit -1
    fi
    echo "Installing dependencies for $XDG_SESSION_TYPE..."
    echo "(you will likely need to escalate privileges)"

    if cat /etc/os-release | grep -i 'debian' 1>/dev/null; then
        PKGCMD="apt install"
    elif cat /etc/os-release | grep -i 'fedora' 1>/dev/null; then
        PKGCMD="dnf install"
    elif cat /etc/os-release | grep -i 'opensuse' 1>/dev/null; then
        PKGCMD="zypper in"
    elif cat /etc/os-release | grep -i 'arch linux' 1>/dev/null; then
        PKGCMD="pacman -S"
    elif cat /etc/os-release | grep -i 'gentoo' 1>/dev/null; then
        PKGCMD="emerge"
    else
        cat << EOF
Your distro is too obscure for me to autodetect, which means
you probably know enough to modify this script to do what you
need it to. Jump to line 32 and get rid of the 'exit -1', make
your modifications, and run the script again.
EOF
        exit -1
    fi

    if [[ "$USER" != "root" ]]; then
        ESCALATION="sudo"
    else
        ESCALATION=
    fi

    # Install dependencies
    $ESCALATION $PKGCMD $PKGNAME

    echo "Dependencies installed!"
    printf "Installing icons..."
    if [[ ! -e ~/.local/share/icons/caffeine_active.svg ]]; then
        cp assets/caffeine_active.svg  ~/.local/share/icons/
    fi
    if [[ ! -e ~/.local/share/icons/caffeine_inactive.svg ]]; then
        cp assets/caffeine_inactive.svg  ~/.local/share/icons/
    fi
    echo "done!"
    echo "Installing plasmoid..."
    plasmapkg2 --install com.github.caffeine-minus
}

uninstall() {
    printf "Removing icons..."
    if [[ -e ~/.local/share/icons/caffeine_active.svg ]]; then
        rm  ~/.local/share/icons/caffeine_active.svg
    fi
    if [[ ! -e ~/.local/share/icons/caffeine_inactive.svg ]]; then
        rm  ~/.local/share/icons/caffeine_inactive.svg
    fi
    echo "done!"
    printf "Removing plasmoid..."
    if [[ -e ~/.local/share/plasma/plasmoids/com.github.deloachcd.caffeine-minus/ ]]; then
        rm -r ~/.local/share/plasma/plasmoids/com.github.deloachcd.caffeine-minus/
    fi
}

USER_ACTION="$1"
if [[ ! "$USER_ACTION" == "install" && ! "$USER_ACTION" == "uninstall" ]]; then
    echo "Usage: ./$(basename $0) <install|uninstall>"
    exit -1
fi

if [[ "$USER_ACTION" == "install" ]]; then
    install
elif [[ "$USER_ACTION" == "uninstall" ]]; then
    uninstall
fi
