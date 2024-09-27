#!/bin/bash

negro="\e[30m"
verde="\e[32m"
rojo="\e[31m"
amarillo="\e[33m"
blanco="\e[97m"
morado="\e[35m"
azul="\e[34m"
cian="\e[36m"
reset="\e[0m"

echo -e "\n"
echo -e "${morado}______           _  _____                  ${reset}"
echo -e "${morado}|  _  \\         | ||_   _|                 ${reset}"
echo -e "${morado}| | | |__ _ _ __| | _| |_ __ __ _  ___ ___ ${reset}"
echo -e "${morado}| | | / _\` | '__| |/ / | '__/ _\` |/ __/ _ \\ ${reset}"
echo -e "${morado}| |/ / (_| | |  |   <| | | | (_| | (_|  __/ ${reset}"
echo -e "${morado}|___/ \\__,_|_|  |_|\_\\_/_|  \\__,_|\\___\\___|${reset}"
echo -e "${morado}                                          ${reset}"
echo -e "${morado}                                          ${reset}"
echo -e "${amarillo}by: tay${reset}"
echo -e "${cian}\n----------------------------------------------${reset}"

while true; do
    echo -ne "\n$(echo -e ${rojo}[+] ${blanco}Enter IP or Domain: ${reset})" 
    read target

    if [[ -z "$target" ]]; then
        echo -e "\n${rojo}[ERROR] No IP or Domain provided. Operation aborted.${reset}"
        continue
    fi

    response=$(curl -s "http://ip-api.com/json/$target")

    status=$(echo "$response" | grep -o '"status":"[^"]*' | grep -o '[^"]*$')

    if [[ "$status" != "success" ]]; then
        echo -e "\n${rojo}[ERROR] Invalid IP or Domain or API request failed.${reset}"
        continue
    fi

    echo -e "\n${verde}[INFO] TARGET: ${blanco}$target${reset}"
    echo -e "${cian}-----------------------------------------------${reset}"
    echo -e "${amarillo}[*] COUNTRY: ${blanco}$(echo "$response" | grep -o '"country":"[^"]*' | grep -o '[^"]*$')${reset}"
    echo -e "${amarillo}[*] REGION: ${blanco}$(echo "$response" | grep -o '"regionName":"[^"]*' | grep -o '[^"]*$')${reset}"
    echo -e "${amarillo}[*] CITY: ${blanco}$(echo "$response" | grep -o '"city":"[^"]*' | grep -o '[^"]*$')${reset}"
    echo -e "${amarillo}[*] ZIP CODE: ${blanco}$(echo "$response" | grep -o '"zip":"[^"]*' | grep -o '[^"]*$')${reset}"
    echo -e "${amarillo}[*] LATITUDE: ${blanco}$(echo "$response" | grep -o '"lat":[^,]*' | grep -o '[^:]*$')${reset}"
    echo -e "${amarillo}[*] LONGITUDE: ${blanco}$(echo "$response" | grep -o '"lon":[^,]*' | grep -o '[^:]*$')${reset}"
    echo -e "${amarillo}[*] TIMEZONE: ${blanco}$(echo "$response" | grep -o '"timezone":"[^"]*' | grep -o '[^"]*$')${reset}"
    echo -e "${amarillo}[*] ISP: ${blanco}$(echo "$response" | grep -o '"isp":"[^"]*' | grep -o '[^"]*$')${reset}"
    echo -e "${amarillo}[*] ORGANIZATION: ${blanco}$(echo "$response" | grep -o '"org":"[^"]*' | grep -o '[^"]*$')${reset}"
    echo -e "${amarillo}[*] AS: ${blanco}$(echo "$response" | grep -o '"as":"[^"]*' | grep -o '[^"]*$')${reset}"
    echo -e "${cian}------------------------------------------------${reset}"

done


