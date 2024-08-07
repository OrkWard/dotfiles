#!/usr/bin/env bash
colors256() {
    local c i j

    printf "Standard 16 colors\n"
    for ((c = 0; c < 17; c++)); do
        printf "|%s%3d%s" "$(tput setaf "$c")" "$c" "$(tput sgr0)"
    done
    printf "|\n\n"

    printf "Colors 16 to 231 for 256 colors\n"
    for ((c = 16, i = j = 0; c < 232; c++, i++)); do
        printf "|"
        ((i > 5 && (i = 0, ++j))) && printf " |"
        ((j > 5 && (j = 0, 1)))   && printf "\b \n|"
        printf "%s%3d%s" "$(tput setaf "$c")" "$c" "$(tput sgr0)"
    done
    printf "|\n\n"

    printf "Greyscale 232 to 255 for 256 colors\n"
    for ((; c < 256; c++)); do
        printf "|%s%3d%s" "$(tput setaf "$c")" "$c" "$(tput sgr0)"
    done
    printf "|\n"
}
colors256
