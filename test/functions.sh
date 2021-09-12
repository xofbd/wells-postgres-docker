#!/bin/bash

RED="\033[1;31m"
GREEN="\033[1;32m"
NO_COLOR="\033[0m"

# echo with green font and a check prefix
echo_success() {
    echo -e "$GREEN\xE2\x9C\x93 $1 $NO_COLOR"
}

# echo with red font and an ex prefix
echo_failure() {
    echo -e "$RED\xE2\x9C\x95 $1 $NO_COLOR"
}
