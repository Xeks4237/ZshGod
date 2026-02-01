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

# TODO: make '--help' or 'prompt_zshgod_help' function for help

# [ Sourcing and Loading extra stuff ]
# Standarized way of handling plugin directory,
# regardless of functionargzero and posixargzero,
# and with an option for a plugin manager to alter
# the plugin directory (i.e. set ZERO parameter)
# Allows using ${0:A:h} to get path of plugin
# https://zdharma-continuum.github.io/Zsh-100-Commits-Club/Zsh-Plugin-Standard.html
0="${${ZERO:-${0:#$ZSH_ARGZERO}}:-${(%):-%N}}"
0="${${(M)0:#/*}:-$PWD/$0}"

# Set variable to absolute path to the directory containing this file
ZSHGOD_HOME="${0:A:h}"

# Source files with functions to use in prompt
source $ZSHGOD_HOME/lib/functions_rectangular.zsh
source $ZSHGOD_HOME/lib/functions_right-to-left_arrowed.zsh
source $ZSHGOD_HOME/lib/functions_left-to-right_arrowed.zsh
source $ZSHGOD_HOME/lib/functions_novisual.zsh

# Add prompt files to fpath variable
fpath+=( $ZSHGOD_HOME/lib )

# [ Configuration Variables ]
# Variable which sets amount of exectime after exectime is not hided
export ZSHGOD_EXECTIME_MIN=5

# Builtin variable which sets indentation for prompts right side
export ZLE_RPROMPT_INDENT=0

# Disable multilined prompt by default
export ZSHGOD_MULTILINED=false

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

# zstyle options to enable or disable some vcs systems which you don't use
# zstyle ':vcs_info:*' disable git svn
zstyle ':vcs_info:*' enable bzr cdv cvs darcs fossil git hg mtn p4 svk svn tla

# zstyle options to customize look of vcs_info
zstyle ':vcs_info:*' actionformats '%b|%a'
zstyle ':vcs_info:*' formats '%b'
zstyle ':vcs_info:(sv[nk]|bzr):*' branchformat '%b:%r'

# [ Main Functions ]
# Function which is used mainly for making multiline prompt
# It works by printing prompt segments on line before drawing actuall prompt
prompt_zshgod_multiline() {
    if [[ $ZSHGOD_MULTILINED == true ]]; then
        # Prints same segments as in actuall prompt
        print -P '%B$(prompt_zshgod_right-to-left_exectime)$(prompt_zshgod_right-to-left_git_info)$(prompt_zshgod_right-to-left_vcs-info)$(prompt_zshgod_right-to-left_current-pwd)$(prompt_zshgod_right-to-left_sshonly_userandhostname)%b'
    fi
}

# Function where all other functions are used to make prompt
prompt_zshgod_setup() {
    # [ Prompt specific opts and Hooks for Functions ]
    # Sets prompt specific zsh opts like prompt substitution
    prompt_opts=( bang cr percent sp subst )

    # Load Zsh module related to zsh hooks
    autoload -Uz add-zsh-hook

    # Builtin zsh module for getting basic info from vcs systems
    autoload -Uz vcs_info

    # preexec hook for recording time when any command was runned, needed for exectime functions
    add-zsh-hook preexec prompt_zshgod_exectime_preexec

    # precmd hook for recording time when any command was finished, needed for exectime functions
    add-zsh-hook precmd prompt_zshgod_exectime_precmd

    # vcs_info function for gettings info about current vcs
    add-zsh-hook precmd vcs_info

    # precmd hook for multilined prompt
    add-zsh-hook precmd prompt_zshgod_multiline

    # Checks passed flags/args to function to make easy fast configuration
    for arg in "$@"; do
        case "$arg" in
                # Makes '--multilined' flag to enable multilined prompt
            --multilined|-M) export ZSHGOD_MULTILINED=true ;;

                # [ Flags used to overwrite existing colors ]
            --color-rosewater=*) export ZSH_THM_ROSEWATER="${arg#--color-rosewater=}" ;;

            --color-flamingo=*) export ZSH_THM_FLAMINGO="${arg#--color-flamingo=}" ;;

            --color-pink=*) export ZSH_THM_PINK="${arg#--color-pink=}" ;;

            --color-mauve=*) export ZSH_THM_MAUVE="${arg#--color-mauve=}" ;;

            --color-red=*) export ZSH_THM_RED="${arg#--color-red=}" ;;

            --color-maroon=*) export ZSH_THM_MAROON="${arg#--color-maroon=}" ;;

            --color-peach=*) export ZSH_THM_PEACH="${arg#--color-peach=}" ;;

            --color-yellow=*) export ZSH_THM_YELLOW="${arg#--color-yellow=}" ;;

            --color-green=*) export ZSH_THM_GREEN="${arg#--color-green=}" ;;

            --color-teal=*) export ZSH_THM_TEAL="${arg#--color-teal=}" ;;

            --color-sky=*) export ZSH_THM_SKY="${arg#--color-sky=}" ;;

            --color-sapphire=*) export ZSH_THM_SAPPHIRE="${arg#--color-sapphire=}" ;;

            --color-blue=*) export ZSH_THM_BLUE="${arg#--color-blue=}" ;;

            --color-lavender=*) export ZSH_THM_LAVENDER="${arg#--color-lavender=}" ;;

            --*)
                print -u2 "Unknown option(s): $arg" >&2
                return 1
                ;;

            *)
                print -u2 "Unknown option(s): $arg" >&2
                return 1
                ;;

        esac
    done

    # [ Prompt Scructure ]
    # Variable which sets left side of prompt
    PS1='%B$(prompt_zshgod_left-to-right_time)$(prompt_zshgod_left-to-right_root-indicator)%b '

    # Variable which sets right side of prompt
    RPS1='%B$(prompt_zshgod_right-to-left_exectime)$(prompt_zshgod_right-to-left_git_info)$(prompt_zshgod_right-to-left_vcs-info)$(prompt_zshgod_right-to-left_current-pwd)$(prompt_zshgod_right-to-left_sshonly_userandhostname)%b'
}

# Run promptinit to refresh themes list
promptinit

