# @Author: IWANABETHATGUY
# @Date: Apr 10, 2023

set -g __fish_pnpm_cmdline
set -g __fish_pnpm_remove_cmdline

set -l deps_commands remove rm why update upgrade up
set -l up_commands update upgrade up
set -l install_commands install i

complete -c pnpm -f
complete -c pnpm -n __pnpm_should_complete_files -F
complete -c pnpm -n __pnpm_should_complete_scripts -a "(__get_scripts)"
complete -c pnpm -f -l filter -s F -r -a "(FEATURE=filter pnpm-shell-completion)" -d 'Select specified packages'
complete -c pnpm -n __pnpm_should_complete_builtins -f -a "add remove install update publish" # just a little, add what needs here


# add relative options
complete -c pnpm -n "__fish_seen_subcommand_from add" -l global -s g -d 'Install a global package'
complete -c pnpm -n "__fish_seen_subcommand_from add" -l save-dev -s D -d 'Save package to your `devDependencies`'
complete -c pnpm -n "__fish_seen_subcommand_from add" -l save-peer -d 'Save package to your `peerDependencies` and `devDependencies`'

complete -c pnpm -n "__fish_seen_subcommand_from $deps_commands" -f -a "(__get_deps)"

complete -c pnpm -n "__fish_seen_subcommand_from $install_commands" -l dev -s D -d 'Only `devDependencies` are installed regardless of the `NODE_ENV`'
complete -c pnpm -n "__fish_seen_subcommand_from $install_commands" -l fix-lockfile -d 'Fix broken lockfile entries automatically'
complete -c pnpm -n "__fish_seen_subcommand_from $install_commands" -l force -d 'Force reinstall dependencies'
complete -c pnpm -n "__fish_seen_subcommand_from $install_commands" -l ignore-scripts -d "Don't run lifecycle scripts"
complete -c pnpm -n "__fish_seen_subcommand_from $install_commands" -l lockfile-only -d 'Dependencies are not downloaded. Only `pnpm-lock.yaml` is updated'
complete -c pnpm -n "__fish_seen_subcommand_from $install_commands" -l no-optional -d '`optionalDependencies` are not installed'
complete -c pnpm -n "__fish_seen_subcommand_from $install_commands" -l offline -d 'Trigger an error if any required dependencies are not available in local store'
complete -c pnpm -n "__fish_seen_subcommand_from $install_commands" -l prefer-offline -d 'Skip staleness checks for cached data, but request missing data from the server'
complete -c pnpm -n "__fish_seen_subcommand_from $install_commands" -l prod -s D -d "Packages in `devDependencies` won't be installed"

complete -c pnpm -n "__fish_seen_subcommand_from $up_commands" -l save-dev -s D -d 'Update packages only in "devDependencies"'
complete -c pnpm -n "__fish_seen_subcommand_from $up_commands" -l interactive -s i -d 'Show outdated dependencies and select which ones to update'
complete -c pnpm -n "__fish_seen_subcommand_from $up_commands" -l latest -s L -d 'Ignore version ranges in package.json'
complete -c pnpm -n "__fish_seen_subcommand_from $up_commands" -l no-optional -d "Don't update packages in `optionalDependencies`"
complete -c pnpm -n "__fish_seen_subcommand_from $up_commands" -l prod -s P -d 'Update packages only in "dependencies" and "optionalDependencies"'
complete -c pnpm -n "__fish_seen_subcommand_from $up_commands" -l recursive -s r -d 'Update in every package found in subdirectories or every workspace package'

complete -c pnpm -n "__fish_seen_subcommand_from publish" -l access -x -a 'public restricted' -d 'Tells the registry whether this package should be published as public or restricted'
complete -c pnpm -n "__fish_seen_subcommand_from publish" -l dry-run -d 'Does everything a publish would do except actually publishing to the registry'
complete -c pnpm -n "__fish_seen_subcommand_from publish" -l force -d 'Packages are proceeded to be published even if their current version is already in the registry'
complete -c pnpm -n "__fish_seen_subcommand_from publish" -l ignore-scripts -d 'Ignores any publish related lifecycle scripts (prepublishOnly, postpublish, and the like)'
complete -c pnpm -n "__fish_seen_subcommand_from publish" -l no-git-checks -d "Don't check if current branch is your publish branch, clean, and up to date"
complete -c pnpm -n "__fish_seen_subcommand_from publish" -l otp -d 'Specify a one-time password'
complete -c pnpm -n "__fish_seen_subcommand_from publish" -l publish-branch -d 'Sets branch name to publish'
complete -c pnpm -n "__fish_seen_subcommand_from publish" -l recursive -s r -d 'Publish all packages from the workspace'
complete -c pnpm -n "__fish_seen_subcommand_from publish" -l tag -x -d 'Registers the published package with the given tag'

# Return positional args (i.e. non-flag tokens) before the token currently
# being completed, with `--filter/-F <pkg>` removed.
function __pnpm__positionals_before_current
    set -l tokens (commandline -pxc)
    set -l cur (commandline -ct)

    # Drop the current token.
    # - If the cursor is in the middle of a token, `-ct` is non-empty.
    # - If the commandline ends with a space, fish still includes an empty token
    #   in `-pxc`; treat that as the current token as well.
    if test -n "$cur"; and test (count $tokens) -ge 2; and test "$tokens[-1]" = "$cur"
        set -e tokens[-1]
    else if test -z "$cur"; and test (count $tokens) -ge 2; and test -z "$tokens[-1]"
        set -e tokens[-1]
    end

    set -e tokens[1]

    # Strip the known option(s) that take an argument so their values don't look
    # like a positional command.
    argparse 'F/filter=' -- $tokens 2>/dev/null

    # Keep only non-flag tokens (positional args)
    set -l pos
    for t in $argv
        if string match -q -- '-*' $t
            continue
        end
        set -a pos $t
    end

    if test (count $pos) -gt 0
        printf '%s\n' $pos
    end
end

# don't have any positionals or just a single `run`
function __pnpm_should_complete_scripts
    set -l pos (__pnpm__positionals_before_current)
    if test (count $pos) -eq 0
        return 0
    end
    if test (count $pos) -eq 1; and test "$pos[1]" = run
        return 0
    end
    return 1
end

# there is no positionals
function __pnpm_should_complete_builtins
    set -l pos (__pnpm__positionals_before_current)
    test (count $pos) -eq 0
end

# - disable for: `pnpm <TAB>` / `pnpm [flags] <TAB>`
# - disable for: `pnpm run <TAB>` / `pnpm [flags] run <TAB>`
# - enable for:  everything after a command/script is present
function __pnpm_should_complete_files
    set -l pos (__pnpm__positionals_before_current)
    if test (count $pos) -eq 0
        return 1
    end
    if test (count $pos) -eq 1; and test "$pos[1]" = run
        return 1
    end
    return 0
end

# get scripts for a package
function __get_scripts
    set -l cmdline (commandline -c)
    if set -q __fish_pnpm_cmdline; and test "$cmdline" = "$__fish_pnpm_cmdline"
        return 0
    end

    set -g __fish_pnpm_cmdline $cmdline

    set -l tokens (commandline -opc)
    set -e tokens[1] # assume the first token is `pnpm`
    argparse 'F/filter=' -- $tokens 2>/dev/null

    set -l scripts (TARGET_PKG=$_flag_filter FEATURE=scripts pnpm-shell-completion)
    for script in $scripts
        test -n "$script"; or continue
        echo -e "$script\tscript"
    end
end

# get deps for a package
function __get_deps
    set -l cmdline (commandline -c)
    if set -q __fish_pnpm_remove_cmdline; and test "$cmdline" = "$__fish_pnpm_remove_cmdline"
        return 0
    end

    set -g __fish_pnpm_remove_cmdline $cmdline

    set -l tokens (commandline -opc)
    set -e tokens[1] # assume the first token is `pnpm`
    argparse 'F/filter=' -- $tokens 2>/dev/null
    TARGET_PKG=$_flag_filter FEATURE=deps pnpm-shell-completion
end

