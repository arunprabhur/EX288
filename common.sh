#!/bin/bash

PATH=/bin:/usr/bin:/home/student/.local/bin:/home/student/bin:/sbin:/bin:/usr/sbin:/usr/bin:/usr/local/sbin:/usr/local/bin:/home/student/.venv/labs/bin:/opt/apache-maven/bin


NONE='\033[00m'
RED='\033[01;31m'
GREEN='\033[01;32m'
YELLOW='\033[01;33m'
PURPLE='\033[01;35m'
CYAN='\033[01;36m'
WHITE='\033[01;37m'
BOLD='\033[1m'
UNDERLINE='\033[4m'


prompt(){
    echo
    read -p "Press Enter Key to continue"
    echo
}

endofscript(){
    tput sgr0
}

promptcommand(){
    COMMAND=$1
    echo -e "Executing Command \n\n ${GREEN}${BOLD}${UNDERLINE}${COMMAND}${NONE}\n\n"
}

execute(){
    echo "${1}"
    promptcommand "${2}"
    ${2}
    prompt
}

