#!/bin/bash

# check if the script is run as root
[ "$EUID" -ne 0 ] && { echo "please run as root" >&2; exit 1;  }

USER_CDIR=cd /home/anon98
USER_DIR=/home/anon98
upgrade=pacman -Syu
install=pacman -S
package_installed=pacman -Qi

st_url=http://git.suckless.org/st
myi3files_git_url=https://github.com/Christiaan304/myi3files.git
myi3files_dir_name=myi3files
mybashrc_git_url=https://github.com/christiaan304/ShellScript.git

PROGRAMS=(
    "git"
)

$USER_CDIR
$upgrade

for prog in "${PROGRAMS[@]}"; do
    if ! command -v "$prog" &> /dev/null; then
        $install $prog
    fi
done

# check if base-devel is installed
if ! $package_installed base_devel &> /dev/null; then
    $install base_devel
fi

clear

#--------------------------------------#

# install st terminal emulator
git clone $st_url
cd st
mv config.def.h config.h
make
make clean install
$USER_CDIR

# download my i3 configuration files
git clone $myi3files_git_url
cd $myi3files_dir_name
mv config $USER_DIR/.config/i3
mv .i3status.conf $USER_DIR
$USER_CDIR
rm -rf $myi3files_dir_name

git clone 

echo
echo "OK"
