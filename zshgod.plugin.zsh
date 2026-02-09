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
# ${0} Gives path to this file
# :A in ${0} makes it to be absolute without path through symlinks
ZSHGOD_HOME="${0:A:h}"

# Add directory with prompt files to fpath
fpath+=( $ZSHGOD_HOME/functions )

# [ Configuration Variables ]
# Variable which sets amount of exectime after exectime is not hided
export ZSHGOD_EXECTIME_MIN=5

# Builtin variable which sets indentation for prompts right side
export ZLE_RPROMPT_INDENT=0

# Disable multilined prompt by default
export ZSHGOD_MULTILINED=false

# INFO: I used Catppuccin Mocha Colors from: https://github.com/catppuccin
# Main colors
export ZSHGOD_THM_CATPPUCCIN_ROSEWATER='#F5E0DC'
export ZSHGOD_THM_CATPPUCCIN_FLAMINGO='#F2CDCD'
export ZSHGOD_THM_CATPPUCCIN_PINK='#F5C2E7'
export ZSHGOD_THM_CATPPUCCIN_MAUVE='#CBA6F7'
export ZSHGOD_THM_CATPPUCCIN_RED='#F38BA8'
export ZSHGOD_THM_CATPPUCCIN_MAROON='#EBA0AC'
export ZSHGOD_THM_CATPPUCCIN_PEACH='#FAB387'
export ZSHGOD_THM_CATPPUCCIN_YELLOW='#F9E2AF'
export ZSHGOD_THM_CATPPUCCIN_GREEN='#A6E3A1'
export ZSHGOD_THM_CATPPUCCIN_TEAL='#94E2D5'
export ZSHGOD_THM_CATPPUCCIN_SKY='#89DCEB'
export ZSHGOD_THM_CATPPUCCIN_SAPPHIRE='#74C7EC'
export ZSHGOD_THM_CATPPUCCIN_BLUE='#89B4FA'
export ZSHGOD_THM_CATPPUCCIN_LAVENDER='#B4BEFE'

# Main surface and overlay colors
export ZSHGOD_THM_CATPPUCCIN_SUBTEXT_1='#A6ADC8'
export ZSHGOD_THM_CATPPUCCIN_SUBTEXT_0='#BAC2DE'
export ZSHGOD_THM_CATPPUCCIN_FOREGROUND='#CDD6F4'
export ZSHGOD_THM_CATPPUCCIN_OVERLAY_2='#9399B2'
export ZSHGOD_THM_CATPPUCCIN_OVERLAY_1='#7F849C'
export ZSHGOD_THM_CATPPUCCIN_OVERLAY_0='#6C7086'
export ZSHGOD_THM_CATPPUCCIN_SURFACE_2='#585B70'
export ZSHGOD_THM_CATPPUCCIN_SURFACE_1='#45475A'
export ZSHGOD_THM_CATPPUCCIN_SURFACE_0='#313244'
export ZSHGOD_THM_CATPPUCCIN_MANTLE='#181825'
export ZSHGOD_THM_CATPPUCCIN_CRUST='#11111B'
export ZSHGOD_THM_CATPPUCCIN_BACKGROUND='#1E1E2E'

# zstyle options to enable or disable some vcs systems which you don't use
# zstyle ':vcs_info:*' disable git svn
zstyle ':vcs_info:*' enable bzr cdv cvs darcs fossil git hg mtn p4 svk svn tla

# Autoload prompt files with its lib files to make usage of builtin zsh lazy loading for functions
# Every file contains one function with same name as file name
# NOTE: always use '-Uz' to supress alias expansion and to use zsh styly autoloading
# [ Autoload setup function ]
autoload -Uz prompt_zshgod_setup

# [ Autoload functions with no styling ]
autoload -Uz \
	prompt_zshgod_preexec \
	prompt_zshgod_precmd \
	prompt_zshgod_sparse-prompt
# [ Autoload rectangle/square styled functions ]
autoload -Uz \
	prompt_zshgod_rectangular_git_dirty \
	prompt_zshgod_rectangular_git_info \
	prompt_zshgod_rectangular_time \
	prompt_zshgod_rectangular_exectime \
	prompt_zshgod_rectangular_current-pwd \
	prompt_zshgod_rectangular_userandhostname \
	prompt_zshgod_rectangular_sshonly_userandhostname \
	prompt_zshgod_rectangular_root-indicator \
	prompt_zshgod_rectangular_username \
	prompt_zshgod_rectangular_sshonly_username \
	prompt_zshgod_rectangular_hostname \
	prompt_zshgod_rectangular_sshonly_hostname \
	prompt_zshgod_rectangular_vcs_branch \
	prompt_zshgod_rectangular_vcs_system \
	prompt_zshgod_rectangular_jobs
# [ Autoload left to right pointing arrow styled functions ]
autoload -Uz \
	prompt_zshgod_left-to-right_git_dirty \
	prompt_zshgod_left-to-right_git_info \
	prompt_zshgod_left-to-right_time \
	prompt_zshgod_left-to-right_exectime \
	prompt_zshgod_left-to-right_current-pwd \
	prompt_zshgod_left-to-right_userandhostname \
	prompt_zshgod_left-to-right_sshonly_userandhostname \
	prompt_zshgod_left-to-right_root-indicator \
	prompt_zshgod_left-to-right_username \
	prompt_zshgod_left-to-right_sshonly_username \
	prompt_zshgod_left-to-right_hostname \
	prompt_zshgod_left-to-right_sshonly_hostname \
	prompt_zshgod_left-to-right_vcs_branch \
	prompt_zshgod_left-to-right_vcs_system \
	prompt_zshgod_left-to-right_jobs
# [ Autoload right to left pointing arrow styled functions ]
autoload -Uz \
	prompt_zshgod_right-to-left_git_dirty \
	prompt_zshgod_right-to-left_git_info \
	prompt_zshgod_right-to-left_time \
	prompt_zshgod_right-to-left_exectime \
	prompt_zshgod_right-to-left_current-pwd \
	prompt_zshgod_right-to-left_userandhostname \
	prompt_zshgod_right-to-left_sshonly_userandhostname \
	prompt_zshgod_right-to-left_root-indicator \
	prompt_zshgod_right-to-left_username \
	prompt_zshgod_right-to-left_sshonly_username \
	prompt_zshgod_right-to-left_hostname \
	prompt_zshgod_right-to-left_sshonly_hostname \
	prompt_zshgod_right-to-left_vcs_branch \
	prompt_zshgod_right-to-left_vcs_system \
	prompt_zshgod_right-to-left_jobs

# Run promptinit in end to update list of themes
promptinit
