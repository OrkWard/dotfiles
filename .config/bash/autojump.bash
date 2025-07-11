# the login $SHELL isn't always the one used
# NOTE: problems might occur if /bin/sh is symlinked to /bin/bash
if [ -n "${BASH}" ]; then
    shell="bash"
elif [ -n "${ZSH_NAME}" ]; then
    shell="zsh"
elif [ -n "${__fish_datadir}" ]; then
    shell="fish"
elif [ -n "${version}" ]; then
    shell="tcsh"
else
    shell=$(echo ${SHELL} | awk -F/ '{ print $NF }')
fi

# prevent circular loop for sh shells
if [ "${shell}" = "sh" ]; then
    return 0

# arch
elif [ -s /etc/profile.d/autojump.bash.${shell} ]; then
    source /etc/profile.d/autojump.bash.${shell}

elif [ -s /usr/share/autojump/autojump.${shell} ]; then
    source /usr/share/autojump/autojump.${shell}

# osx
elif [ -s /opt/homebrew/share/autojump/autojump.${shell} ]; then
    source /opt/homebrew/share/autojump/autojump.${shell}
fi
