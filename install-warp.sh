#!/bin/bash
#
#  |=================================================================================|
#  • Autoscript AIO By FN Project                                                    |
#  • FN Project Developer @Rerechan02 | @PR_Aiman | @farell_aditya_ardian            |
#  • Copyright 2024 18 Marc Indonesia [ Kebumen ] | [ Johor ] | [ 上海，中国 ]        |
#  |=================================================================================|
#

# // Mengambil File Yang diperlukan
clear
cd /usr/bin
wget -O menu-warp "https://raw.githubusercontent.com/DindaPutriFN/warp/main/menu-warp.sh"
wget -O warp "https://raw.githubusercontent.com/rany2/warp.sh/master/warp.sh"
chmod +x warp
chmod +x menu-warp
cd

# // Sukses Menginstall
clear
echo -e "
Succes Install Menu Warp
cmd to open menu warp: menu-warp
"
rm -fr /root/*