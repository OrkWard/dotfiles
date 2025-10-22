function colors256
  printf "Standard 16 colors\n"
  for c in (seq 0 15)
    printf "|%s %d %s" (tput setaf $c) $c (tput sgr0)
  end
  printf "\n\n"

  printf "Colors 16 to 231 for 256 colors"
  for c in (seq 16 231)
    if test (math "$c % 6") = "4"
      printf "\n"
    end
    printf "|%s%3d%s" (tput setaf $c) $c (tput sgr0)
  end
  printf "\n\n"

  printf "Greyscale 232 to 255 for 256 colors\n"
  for c in (seq 232 255)
    if test (math "$c % 12") = "4"
      printf "\n"
    end
    printf "|%s%3d%s" (tput setaf $c) $c (tput sgr0)
  end
  printf "\n"
end
