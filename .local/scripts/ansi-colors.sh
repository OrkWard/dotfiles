#!/usr/bin/env bash

# ANSI color codes
colors=(30 31 32 33 34 35 36 37 90 91 92 93 94 95 96 97)
bg_colors=(40 41 42 43 44 45 46 47 100 101 102 103 104 105 106 107)

# Header
printf "    "
for fg in "${colors[@]}"; do
    printf "%-4s" "$fg"
done
printf "\n"

# Table
for bg in "${bg_colors[@]}"; do
    printf "%-4s" "$bg"
    for fg in "${colors[@]}"; do
        printf "\e[%s;%sm A \e[0m " "$fg" "$bg"
    done
    printf "\n"
done
