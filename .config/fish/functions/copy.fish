# pipe stdin content to system clipboard
function copy
    read -zl input
    printf "\033]52;c;%s\007" (echo -n $input | base64 -w0)
end
