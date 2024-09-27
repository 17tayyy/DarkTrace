#!/bin/bash

RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
NC='\033[0m'

if ! command -v jq &> /dev/null
then
    echo -e "${YELLOW}[+] The jq tool is not installed. Installing it now...${NC}"
    sudo apt-get install -y jq || sudo yum install -y jq || brew install jq
fi

while true; do
    echo -e "${BLUE}[?]${NC} ${GREEN}Enter the IP you want to look up (or type 'exit' to quit):${NC}"
    read -p "$(echo -e "${YELLOW}>>> ${NC}")" ipbas

    if [ "$ipbas" == "exit" ]; then
        echo -e "${BLUE}[!] Exiting program...${NC}"
        break
    fi

    if [ -z "$ipbas" ]; then
        echo -e "${RED}[!] No IP entered. Please enter a valid IP.${NC}"
        continue
    fi

    response=$(curl -s "http://ipinfo.io/$ipbas")

    if echo "$response" | jq -e .error > /dev/null; then
        echo -e "${RED}[!] The entered IP is invalid or cannot be located. Try another.${NC}"
        continue
    fi

    echo -e "${BLUE}================ Information for IP: $ipbas ==================${NC}"
    echo -e "${GREEN}[+]${NC} IP:             ${YELLOW}$(echo "$response" | jq -r '.ip')${NC}"
    echo -e "${GREEN}[+]${NC} Hostname:       ${YELLOW}$(echo "$response" | jq -r '.hostname')${NC}"
    echo -e "${GREEN}[+]${NC} Organization:   ${YELLOW}$(echo "$response" | jq -r '.org')${NC}"
    echo -e "${GREEN}[+]${NC} City:           ${YELLOW}$(echo "$response" | jq -r '.city')${NC}"
    echo -e "${GREEN}[+]${NC} Region:         ${YELLOW}$(echo "$response" | jq -r '.region')${NC}"
    echo -e "${GREEN}[+]${NC} Country:        ${YELLOW}$(echo "$response" | jq -r '.country')${NC}"
    echo -e "${GREEN}[+]${NC} Postal Code:    ${YELLOW}$(echo "$response" | jq -r '.postal')${NC}"
    echo -e "${GREEN}[+]${NC} Coordinates:    ${YELLOW}$(echo "$response" | jq -r '.loc')${NC}"
    echo -e "${GREEN}[+]${NC} Timezone:       ${YELLOW}$(echo "$response" | jq -r '.timezone')${NC}"
    echo -e "${BLUE}===========================================================${NC}"
done
