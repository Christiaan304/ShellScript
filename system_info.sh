#!/bin/bash
clear
user="$(users)"
hostname="$(hostname)"
os="$(hostnamectl | grep System | awk '{print $3}')"
kernel="$(uname -r)"
cpu="$(cat /proc/cpuinfo | head -5 | grep name | awk '{print $5}')"
mem="$(cat /proc/meminfo | grep MemTotal | awk '{print $2}')"
uptime="$(uptime -p | sed 's/up //')"
sh="$(basename ${SHELL})"
res="$(xdpyinfo | grep 'dimensions:'| awk '{print $2}')"
pkg="$(
	PACK=$(type apt xbps-query emerge pacman nix-env rpm apk cave gaze 2>/dev/null | grep '\/')
	PACK="${PACK##*/}"
	if [ "$PACK" = 'apt' ]; then
		dpkg -l | wc -l
	elif [ "$PACK" = 'xbps-query' ];then
		xbps-query -l | wc -l
	elif [ "$PACK" = 'emerge' ];then
		ls -d /var/db/pkg/*/* | wc -l
	elif [ "$PACK" = 'pacman' ];then
		pacman -Q | wc -l
	elif [ "$PACK" = 'nix-env' ];then
		ls -d -1 /nix/store/ | wc -l
	elif [ "$PACK" = 'rpm' ];then
		rpm -qa | wc -l
	elif [ "$PACK" = 'apk' ];then
		apk info | wc -l
	elif [ "$PACK" = 'cave' ];then
		xpkgs=$(ls -d -1 /var/db/paludis/repositories/cross-installed/*/data/* | wc -l)
		pkgs=$(ls -d -1 /var/db/paludis/repositories/installed/data/* | wc -l)
		printf $((pkgs + xpkgs))
	elif [ "$PACK" = 'gaze' ];then
		gaze installed | wc -l
	fi
	)"
	hd="$(df -h | grep sda1 | awk '{print $3}')"

if [ -z "${WM}" ]; then
	if [ "${XDG_CURRENT_DESKTOP}" ]; then
		envtype='DE'
		WM="${XDG_CURRENT_DESKTOP}"
	elif [ "${DESKTOP_SESSION}" ]; then
		envtype='DE'
		WM="${DESKTOP_SESSION}"
	else
		envtype='WM'
		WM="$(tail -n 1 "${HOME}/.xinitrc" | cut -d ' ' -f 2)"
	fi
else
	envtype='WM'
fi

echo "OS: $os"
echo "Kernel: $kernel"
echo "CPU: $cpu"
echo "Mem: $mem kB"
echo "UP: $uptime"
echo "PKG: $pkg"
echo "Disk: $hd"
echo "WM: $WM"
echo "SH: $sh"
echo "Res: $res"
echo " "
