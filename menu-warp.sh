#!/bin/bash
#
#  |=================================================================================|
#  • Autoscript AIO By FN Project                                                    |
#  • FN Project Developer @Rerechan02 | @PR_Aiman | @farell_aditya_ardian            |
#  • Copyright 2024 18 Marc Indonesia [ Kebumen ] | [ Johor ] | [ 上海，中国 ]        |
#  |=================================================================================|
#

# Color
Green_font_prefix="\033[32m" && Red_font_prefix="\033[31m" && Green_background_prefix="\033[42;37m" && Red_background_prefix="\033[41;37m" && Font_color_suffix="\033[0m"
Info="${Red_font_prefix}[information]${Font_color_suffix}"

clear

install() {
clear
# Check OS version
if [[ -e /etc/debian_version ]]; then
	source /etc/os-release
	OS=$ID # debian or ubuntu
elif [[ -e /etc/centos-release ]]; then
	source /etc/os-release
	OS=centos
fi
# Check OS version
if [[ -e /etc/debian_version ]]; then
	source /etc/os-release
	OS=$ID # debian or ubuntu
elif [[ -e /etc/centos-release ]]; then
	source /etc/os-release
	OS=centos
fi

Green_font_prefix="\033[32m" && Red_font_prefix="\033[31m" && Green_background_prefix="\033[42;37m" && Red_background_prefix="\033[41;37m" && Font_color_suffix="\033[0m"
Info="${Green_font_prefix}[information]${Font_color_suffix}"

if [[ -e /etc/wireguard/params ]]; then
	echo -e "${Info} WireGuard sudah diinstal."
	exit 1
fi

# Install WireGuard tools and module
	if [[ $OS == 'ubuntu' ]]; then
	apt install -y wireguard
elif [[ $OS == 'debian' ]]; then
	echo "deb http://deb.debian.org/debian/ unstable main" >/etc/apt/sources.list.d/unstable.list
	printf 'Package: *\nPin: release a=unstable\nPin-Priority: 90\n' >/etc/apt/preferences.d/limit-unstable
	apt update
	apt install -y wireguard-tools iptables iptables-persistent
	apt install -y linux-headers-$(uname -r)
elif [[ ${OS} == 'centos' ]]; then
	curl -Lo /etc/yum.repos.d/wireguard.repo https://copr.fedorainfracloud.org/coprs/jdoss/wireguard/repo/epel-7/jdoss-wireguard-epel-7.repo
	yum -y update
	yum -y install wireguard-dkms wireguard-tools
	fi
apt install iptables iptables-persistent -y
# Make sure the directory exists (this does not seem the be the case on fedora)
mkdir -p /etc/wireguard >/dev/null 2>&1

# Install Warp
if [[ -e /usr/bin/warp.sh ]]; then
 echo -e "${Info} Warp already Install,."
else
cd /usr/bin
wget git.io/warp.sh
bash warp.sh install
bash warp.sh wgd
fi
chmod /usr/bin/warp.sh
chmod +x /usr/bin/*
Clear
}

status() {
    clear
    warp.sh status
    curl -s https://www.cloudflare.com/cdn-cgi/trace
}

enable() {
    warp-cli connect
    clear
    echo -e "Done Enable Warp"
}

disable() {
    warp-cli disconnect
    clear
    echo -e "success disable warp"
}

restart() {
    warp.sh restart
    systemctl daemon-reload
    systemctl restart wg-quick@wgcf
    clear
    echo -e "Done Restart Service Warp Wireguard"
}

akun4() {
    warp -4 > /root/wgcf.conf
    clear
    echo -e "
    <= Your WARP IPv4 Wireguard Account =>
    ======================================
         Wireguard Configuration

    $(cat /root/wgcf.conf)
    ======================================
    "
    rm -fr /root/wgcf.conf
}

akun6() {
        warp -6 > /root/wgcf.conf
    clear
    echo -e "
    <= Your WARP IPv6 Wireguard Account =>
    ======================================
         Wireguard Configuration

    $(cat /root/wgcf.conf)
    ======================================
    "
    rm -fr /root/wgcf.conf
}

token() {
    clear
    read -p "Input Your Token Teams WARP+: " token
    clear
    warp -T $token
}

add() {
    clear
    echo -e "
    Create Account Warp Wireguard
    =============================

    1. Create Account with IPv4
    2. Create Account with IPv6
    =============================
    Press CTRL + C To exit menu"
    read -p "Input Option: " aws
    case $aws in
    1) akun4 ;;
    2) akun6 ;;
    *) add ;;
    esac
}

menuwg() {
    clear
    echo -e "
      Menu Warp Wireguard FN
    ==========================

    1. Install Warp Wireguard
    2. Status Warp Wireguard
    3. Restart Warp Wireguard
    4. Enable Warp Wireguard
    5. Disable Warp Wireguard
    6. Input Token Warp Teams
    ==========================
    
    7. Create Account Wireguard
    8. Enter to default menu
    9. Exit this menu
    ==========================
    Press CTRL + C To Exit Menu"
    read -p "Input Option: " opt
    case $opt in
    1) install ;;
    2) status ;;
    3) restart ;;
    4) enable ;;
    5) disable ;;
    6) token ;;
    7) add ;;
    8) menu ;;
    9) exit ;;
    *) menuwg ;;
    esac
}
menuwg