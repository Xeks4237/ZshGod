# [ Title with useful information ]
# Zsh-God Prompt
# Made by Xeks4237: https://gitlab.com/Xeks4237
# Licensed under: MIT License

# Zsh substitutions (To get more info check mandoc of zsh):
# %F{} => Changes foreground color of text after itself, excepts HEX values for color
# %K{} => Changes background color of text after itself, excepts HEX values for color
# %f => Resets foreground coloring after itself
# %k => Resets background coloring after itself
# %B => Makes text after itself to bold
# %b => Resets 'boldness' effect of text caused by %B
# %D{} => Shows customly formatted time, like soo '%H:%M:%S.%.'
# %~ => Current path relative to $HOME directory
# %n => Shows $USERNAME of the surrent user
# %m => Shows hostname up to the first `.' symbols
# %# => Shows '#' if shell is privileged, if not '%', its same as %(!,#,%%)
# %(?,,) => prompt condition for doing some logic, %(condition,true,false)

# [ List of custom functions ]
# These are functions which are after being called or evaluated
# will return one of the customly made pieces of prompt
# They are used in 'prompt_zshgod_setup' function in end of this file
# Each of functions are written inside of $() to evaluate its functionality
# instead of just printing its name
# TODO: make '--help' or 'prompt_zshgod_help' function for help

# [ Sourcing and Loading extra stuff ]
# Standarized way of handling finding plugin dir,
# regardless of functionargzero and posixargzero,
# and with an option for a plugin manager to alter
# the plugin directory (i.e. set ZERO parameter)
# Allows using ${0:h} to get path of plugin
# https://zdharma-continuum.github.io/Zsh-100-Commits-Club/Zsh-Plugin-Standard.html
0="${${ZERO:-${0:#$ZSH_ARGZERO}}:-${(%):-%N}}"
0="${${(M)0:#/*}:-$PWD/$0}"

# Set variable to be equal to directory with prompt files using argzero
ZSHGOD_HOME="${0:A:h}"

# Adds directory with extra files needed for funxtions to fpath
# fpath=($fpath $ZSHGOD_HOME/prompt_zshgod_setup)

# [ Global Usage Variables ]
# Variable which sets amount of exectime after exectime is not hided
export ZSHGOD_EXECTIME_MIN=5

# Builtin variable which sets indentation for prompts right side
export ZLE_RPROMPT_INDENT=0

# zstyle options to enable or disable some vcs systems which you don't use
zstyle ':vcs_info:*' enable bzr cdv cvs darcs fossil git hg mtn p4 svk svn tla
# zstyle ':vcs_info:*' disable git svn

# zstyle options to customize look of vcs_info
zstyle ':vcs_info:*' actionformats '%b|%a'
zstyle ':vcs_info:*' formats '%b'
zstyle ':vcs_info:(sv[nk]|bzr):*' branchformat '%b:%r'

# INFO: I used Catppuccin Mocha Colors from: https://github.com/catppuccin
# Main colors
export ZSH_THM_ROSEWATER='#F5E0DC'
export ZSH_THM_FLAMINGO='#F2CDCD'
export ZSH_THM_PINK='#F5C2E7'
export ZSH_THM_MAUVE='#CBA6F7'
export ZSH_THM_RED='#F38BA8'
export ZSH_THM_MAROON='#EBA0AC'
export ZSH_THM_PEACH='#FAB387'
export ZSH_THM_YELLOW='#F9E2AF'
export ZSH_THM_GREEN='#A6E3A1'
export ZSH_THM_TEAL='#94E2D5'
export ZSH_THM_SKY='#89DCEB'
export ZSH_THM_SAPPHIRE='#74C7EC'
export ZSH_THM_BLUE='#89B4FA'
export ZSH_THM_LAVENDER='#B4BEFE'

# Main surface and overlay colors
export ZSH_THM_SUBTEXT_1='#A6ADC8'
export ZSH_THM_SUBTEXT_0='#BAC2DE'
export ZSH_THM_FOREGROUND='#CDD6F4'
export ZSH_THM_OVERLAY_2='#9399B2'
export ZSH_THM_OVERLAY_1='#7F849C'
export ZSH_THM_OVERLAY_0='#6C7086'
export ZSH_THM_SURFACE_2='#585B70'
export ZSH_THM_SURFACE_1='#45475A'
export ZSH_THM_SURFACE_0='#313244'
export ZSH_THM_MANTLE='#181825'
export ZSH_THM_CRUST='#11111B'
export ZSH_THM_BACKGROUND='#1E1E2E'

# [ Functions needed for other functions which don't have visual look ]
# Function which captures exectime before executing every command
prompt_zshgod_exectime_preexec() {
    # Saves value of $EPOCHSECONDS before executing command to variable
    # Its for prompt_zshgod_exectime function
    ZSHGOD_EXECTIME_START=$EPOCHSECONDS
}

# Function which calculates exectime before drowing prompt
prompt_zshgod_exectime_precmd() {
    # Piece of code which calculated exectime before displaying prompt
    # Its for prompt_zshgod_exectime function
    if (( ${+ZSHGOD_EXECTIME_START} )); then
        ZSHGOD_EXECTIME_DURATION=$(( EPOCHSECONDS - ZSHGOD_EXECTIME_START ))
        unset ZSHGOD_EXECTIME_START
    else
        unset ZSHGOD_EXECTIME_DURATION
    fi
}

# [ Functions styled as right to left arrows ]
# Function for checking git repos if they are dirty
prompt_zshgod_left-to-right_git_dirty() {
    # Checks if we're in a git repo
    command git rev-parse --is-inside-work-tree &>/dev/null || return

    # Checks if it's dirty
    local umode="-uno"
    command test -n "$(git status --porcelain --ignore-submodules ${umode} 2>/dev/null | head -100)"

    # Prints "*" if repo is dirty
    (($? == 0)) && print "%F{$ZSH_THM_PEACH}%S %K{$ZSH_THM_CRUST}*%k %s%f"
}

prompt_zshgod_left-to-right_git_info() {
    # Silently exit if not inside a git repository
    command git rev-parse --is-inside-work-tree &>/dev/null || return

    # Fetch machine-readable git status with branch info (includes ahead/behind)
    local git_info="$(command git status --porcelain --branch 2>/dev/null)"

    # If nothing to report (repo clean), output nothing
    [[ -z "$git_info" ]] && return

    # Extract the branch line (starts with "##")
    local branch_line=$(echo "$git_info" | grep "^##")

    # Count how many commits are ahead of upstream (not pushed)
    local ahead_count=0
    if [[ $branch_line =~ "ahead ([0-9]+)" ]]; then
        ahead_count=${match[1]}
    fi

    # Remove branch line to leave only file status lines
    local status_lines=$(echo "$git_info" | grep -v "^##")

    # Count staged changes (new files added, modifications staged, deletes staged, etc.)
    local staged_count=$(echo "$status_lines" | grep -c "^[MADRC] ")

    # Count unstaged modifications to tracked files
    local modified_count=$(echo "$status_lines" | grep -c "^ [MAD] ")

    # Count deleted files (staged + unstaged deletes)
    local deleted_count=$(( $(echo "$status_lines" | grep -c "^[D] ") + $(echo "$status_lines" | grep -c "^ [D] ") ))

    # Count untracked/new files
    local untracked_count=$(echo "$status_lines" | grep -c "^?? ")

    # Build the output parts only if the count is greater than 0
    local parts=()

    # Check if staged count is zero or not and add it to the parts[] array
    (( staged_count > 0 )) && parts+=("%K{$ZSH_THM_GREEN}${staged_count}+%k")

    # Check if modified count is zero or not and add it to the parts[] array
    (( modified_count > 0 )) && parts+=("%K{$ZSH_THM_YELLOW}${modified_count}*%k")

    # Check if deleted count is zero or not and add it to the parts[] array
    (( deleted_count > 0 )) && parts+=("%K{$ZSH_THM_RED}${deleted_count}-%k")

    # Check if untracked count is zero or not and add it to the parts[] array
    (( untracked_count > 0 )) && parts+=("%K{$ZSH_THM_SKY}${untracked_count}?%k")

    # Check if ahead count is zero or not and add it to the parts[] array
    (( ahead_count > 0 )) && parts+=("%K{$ZSH_THM_LAVENDER}${ahead_count}↑%k")

    # If there's anything to show, join the parts and do some customization
    if (( ${#parts[@]} > 0 )); then
        print "%F{$ZSH_THM_OVERLAY_0}%S ${parts[*]} %s%f"
    fi
}

# Function for showing arrow with customly formatted current time
prompt_zshgod_left-to-right_time() {
    print "%F{$ZSH_THM_YELLOW}%S %K{$ZSH_THM_CRUST}%D{%H:%M:%S}%k %s%f"
}

# Function which returns exectime for last executed command
# This function uses environment variables from two other functions to work correctly
prompt_zshgod_left-to-right_exectime() {
    if (( ${+ZSHGOD_EXECTIME_DURATION} && ZSHGOD_EXECTIME_DURATION >= ZSHGOD_EXECTIME_MIN )); then
        print "%F{$ZSH_THM_YELLOW}%S %K{$ZSH_THM_CRUST}${ZSHGOD_EXECTIME_DURATION}s%k %s%f"
    fi
}

# Function for showing arrow with current working directory
prompt_zshgod_left-to-right_current-pwd() {
    print "%F{$ZSH_THM_BLUE}%S %K{$ZSH_THM_CRUST}%~%k %s%f"
}

# Function which shows arrow with current username@hostname
prompt_zshgod_left-to-right_userandhostname() {
    print "%(!,%F{$ZSH_THM_RED}%S %K{$ZSH_THM_CRUST}%n%k %s%f,%F{$ZSH_THM_GREEN}%S %K{$ZSH_THM_CRUST}%n%k %s%f)%F{$ZSH_THM_YELLOW}%S %K{$ZSH_THM_CRUST}@%k %s%f%F{$ZSH_THM_SKY}%S %K%m%k %s%f"

}

# Function which returns prompt_zshgod_left-to-right_userandhostname only when connected to ssh
prompt_zshgod_left-to-right_sshonly_userandhostname() {
    if [[ -n $SSH_CONNECTION ]]; then
        prompt_zshgod_left-to-right_userandhostname
    fi
}

# Function which shows colored arrow with different color if current user is root
prompt_zshgod_left-to-right_root-indicator () {
    print "%(!,%F{$ZSH_THM_RED}%S %K{$ZSH_THM_CRUST}#%k %s%f,%F{$ZSH_THM_GREEN}%S %K{$ZSH_THM_CRUST}\$%k %s%f)"
}

# Function which returns colored arrow with current username with different color if current user is root
prompt_zshgod_left-to-right_username() {
    print "%(!,%F{$ZSH_THM_RED}%S %K{$ZSH_THM_CRUST}%n%k %s%f,%F{$ZSH_THM_GREEN}%S %K{$ZSH_THM_CRUST}%n%k %s%f)"
}

# Same function as prompt_zshgod_left-to-right_username but shown only through ssh
prompt_zshgod_left-to-right_sshonly_username() {
    if [[ -n $SSH_CONNECTION ]]; then
        prompt_zshgod_left-to-right_username
    fi
}

# Function which returns colored arrow with current hostname
prompt_zshgod_left-to-right_hostname() {
    print "%F{$ZSH_THM_SKY}%S %K{$ZSH_THM_CRUST}%m%k %s%f"
}

# Same function as prompt_zshgod_left-to-right_hostname but shown only through ssh
prompt_zshgod_left-to-right_sshonly_hostname() {
    if [[ -n $SSH_CONNECTION ]]; then
        prompt_zshgod_left-to-right_hostname
    fi
}

# Function which returns basic info about current vcs
prompt_zshgod_left-to-right_vcs-info() {
    if [[ -n $vcs_info_msg_0_ ]]; then
        print "%F{$ZSH_THM_GREEN}%S %K{$ZSH_THM_CRUST}$vcs_info_msg_0_%k %s%f"
    fi
}

# [ Functions styled as left to right arrows ]
# Function for checking git repos if they are dirty
prompt_zshgod_right-to-left_git_dirty() {
    # Checks if we're in a git repo
    command git rev-parse --is-inside-work-tree &>/dev/null || return

    # Checks if it's dirty
    local umode="-uno"
    command test -n "$(git status --porcelain --ignore-submodules ${umode} 2>/dev/null | head -100)"

    # Prints "*" if repo is dirty
    (($? == 0)) && print "%F{$ZSH_THM_PEACH}%S %K{$ZSH_THM_CRUST}*%k %s%f"
}

prompt_zshgod_right-to-left_git_info() {
    # Silently exit if not inside a git repository
    command git rev-parse --is-inside-work-tree &>/dev/null || return

    # Fetch machine-readable git status with branch info (includes ahead/behind)
    local git_info="$(command git status --porcelain --branch 2>/dev/null)"

    # If nothing to report (repo clean), output nothing
    [[ -z "$git_info" ]] && return

    # Extract the branch line (starts with "##")
    local branch_line=$(echo "$git_info" | grep "^##")

    # Count how many commits are ahead of upstream (not pushed)
    local ahead_count=0
    if [[ $branch_line =~ "ahead ([0-9]+)" ]]; then
        ahead_count=${match[1]}
    fi

    # Remove branch line to leave only file status lines
    local status_lines=$(echo "$git_info" | grep -v "^##")

    # Count staged changes (new files added, modifications staged, deletes staged, etc.)
    local staged_count=$(echo "$status_lines" | grep -c "^[MADRC] ")

    # Count unstaged modifications to tracked files
    local modified_count=$(echo "$status_lines" | grep -c "^ [MAD] ")

    # Count deleted files (staged + unstaged deletes)
    local deleted_count=$(( $(echo "$status_lines" | grep -c "^[D] ") + $(echo "$status_lines" | grep -c "^ [D] ") ))

    # Count untracked/new files
    local untracked_count=$(echo "$status_lines" | grep -c "^?? ")

    # Build the output parts only if the count is greater than 0
    local parts=()

    # Check if staged count is zero or not and add it to the parts[] array
    (( staged_count > 0 )) && parts+=("%K{$ZSH_THM_GREEN}${staged_count}+%k")

    # Check if modified count is zero or not and add it to the parts[] array
    (( modified_count > 0 )) && parts+=("%K{$ZSH_THM_YELLOW}${modified_count}*%k")

    # Check if deleted count is zero or not and add it to the parts[] array
    (( deleted_count > 0 )) && parts+=("%K{$ZSH_THM_RED}${deleted_count}-%k")

    # Check if untracked count is zero or not and add it to the parts[] array
    (( untracked_count > 0 )) && parts+=("%K{$ZSH_THM_SKY}${untracked_count}?%k")

    # Check if ahead count is zero or not and add it to the parts[] array
    (( ahead_count > 0 )) && parts+=("%K{$ZSH_THM_LAVENDER}${ahead_count}↑%k")

    # If there's anything to show, join the parts and do some customization
    if (( ${#parts[@]} > 0 )); then
        print "%F{$ZSH_THM_OVERLAY_0}%S ${parts[*]} %s%f"
    fi
}

# Function for showing arrow with customly formatted current time
prompt_zshgod_right-to-left_time() {
    print "%F{$ZSH_THM_YELLOW}%S %K{$ZSH_THM_CRUST}%D{%H:%M:%S}%k %s%f"
}

# Function which returns exectime for last executed command
# This function uses environment variables from two other functions to work correctly
prompt_zshgod_right-to-left_exectime() {
    if (( ${+ZSHGOD_EXECTIME_DURATION} && ZSHGOD_EXECTIME_DURATION >= ZSHGOD_EXECTIME_MIN )); then
        print "%F{$ZSH_THM_YELLOW}%S %K{$ZSH_THM_CRUST}${ZSHGOD_EXECTIME_DURATION}s%k %s%f"
    fi
}

# Function for showing arrow with current working directory
prompt_zshgod_right-to-left_current-pwd() {
    print "%F{$ZSH_THM_BLUE}%S %K{$ZSH_THM_CRUST}%~%k %s%f"
}

# Function which shows arrow with current username@hostname
prompt_zshgod_right-to-left_userandhostname() {
    print "%(!,%F{$ZSH_THM_RED}%S %K{$ZSH_THM_CRUST}%n%k %s%f,%F{$ZSH_THM_GREEN}%S %K{$ZSH_THM_CRUST}%n%k %s%f)%F{$ZSH_THM_YELLOW}%S %K{$ZSH_THM_CRUST}@%k %s%f%F{$ZSH_THM_SKY}%S %K%m%k %s%f"

}

# Function which returns prompt_zshgod_right-to-left_userandhostname only when connected to ssh
prompt_zshgod_right-to-left_sshonly_userandhostname() {
    if [[ -n $SSH_CONNECTION ]]; then
        prompt_zshgod_right-to-left_userandhostname
    fi
}

# Function which shows colored arrow with different color if current user is root
prompt_zshgod_right-to-left_root-indicator () {
    print "%(!,%F{$ZSH_THM_RED}%S %K{$ZSH_THM_CRUST}#%k %s%f,%F{$ZSH_THM_GREEN}%S %K{$ZSH_THM_CRUST}\$%k %s%f)"
}

# Function which returns colored arrow with current username with different color if current user is root
prompt_zshgod_right-to-left_username() {
    print "%(!,%F{$ZSH_THM_RED}%S %K{$ZSH_THM_CRUST}%n%k %s%f,%F{$ZSH_THM_GREEN}%S %K{$ZSH_THM_CRUST}%n%k %s%f)"
}

# Same function as prompt_zshgod_right-to-left_username but shown only through ssh
prompt_zshgod_right-to-left_sshonly_username() {
    if [[ -n $SSH_CONNECTION ]]; then
        prompt_zshgod_right-to-left_username
    fi
}

# Function which returns colored arrow with current hostname
prompt_zshgod_right-to-left_hostname() {
    print "%F{$ZSH_THM_SKY}%S %K{$ZSH_THM_CRUST}%m%k %s%f"
}

# Same function as prompt_zshgod_right-to-left_hostname but shown only through ssh
prompt_zshgod_right-to-left_sshonly_hostname() {
    if [[ -n $SSH_CONNECTION ]]; then
        prompt_zshgod_right-to-left_hostname
    fi
}

# Function which returns basic info about current vcs
prompt_zshgod_right-to-left_vcs-info() {
    if [[ -n $vcs_info_msg_0_ ]]; then
        print "%F{$ZSH_THM_GREEN}%S %K{$ZSH_THM_CRUST}$vcs_info_msg_0_%k %s%f"
    fi
}

# Function where all other functions are used to make prompt
prompt_zshgod_setup() {
    # Allows using command substitutions in prompt
    prompt_opts=(subst)

    # Zsh module related to zsh hooks
    autoload -Uz add-zsh-hook

    # Builtin zsh module for getting basic info from vcs systems
    autoload -Uz vcs_info

    # Files with functions to use in prompt
    source $ZSHGOD_HOME/lib/functions_rectangular.zsh
    source $ZSHGOD_HOME/lib/functions_right-to-left_arrowed.zsh
    source $ZSHGOD_HOME/lib/functions_left-to-right_arrowed.zsh

    # [ Prompt specific opts and Hooks for Functions ]
    # preexec hook for recording time when any command was runned, needed for exectime functions
    add-zsh-hook preexec prompt_zshgod_exectime_preexec

    # precmd hook for recording time when any command was finished, needed for exectime functions
    add-zsh-hook precmd prompt_zshgod_exectime_precmd

    # vcs_info function for gettings info about current vcs
    add-zsh-hook precmd vcs_info

    # [ Prompt Scructure ]
    # Echo nothing before setting up prompt to make it sparce
    echo ''

    # Variable which sets left side of prompt
    PS1='%B$(prompt_zshgod_left-to-right_time)$(prompt_zshgod_left-to-right_root-indicator)%b '

    # Variable which sets right side of prompt
    RPS1='%B$(prompt_zshgod_right-to-left_exectime)$(prompt_zshgod_right-to-left_git_info)$(prompt_zshgod_right-to-left_vcs-info)$(prompt_zshgod_right-to-left_current-pwd)$(prompt_zshgod_right-to-left_sshonly_userandhostname)%b'
}

# Actually run setup function
prompt_zshgod_setup "$@"

