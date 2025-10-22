function colorsANSI
    set -l colors
    for i in 30 90
        for j in (seq 0 7)
            set -a colors (math $i + $j)
        end
    end
    
    set -l bg_colors
    for i in 40 100
        for j in (seq 0 7)
            set -a bg_colors (math $i + $j)
        end
    end
    
    printf "    "
    for fg in $colors
        printf "%-4s" $fg
    end
    printf "\n"
    
    for bg in $bg_colors
        printf "%-4s" $bg
        for fg in $colors
            printf "\e[%s;%sm A \e[0m " $fg $bg
        end
        printf "\n"
    end
end
