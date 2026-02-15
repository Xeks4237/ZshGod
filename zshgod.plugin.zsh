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

# Add directory with prompt files to fpath
fpath+=( ${0:A:h}/functions )

# zstyle options to enable or disable some vcs systems which you don't use
# zstyle ':vcs_info:*' disable git svn
zstyle ':vcs_info:*' enable bzr cdv cvs darcs fossil git hg mtn p4 svk svn tla

# Autoload prompt files with its lib files to make usage of builtin zsh lazy loading for functions
# NOTE: always use '-Uz' to supress alias expansion and to use zsh styly autoloading
# Every file contains one function with same name as file name

# [ Autoload technical functions ]
autoload -Uz \
	prompt_zshgod_setup \
	prompt_zshgod_configure \
	prompt_zshgod_preexec \
	prompt_zshgod_precmd \
	prompt_zshgod_exectime
# [ Autoload rectangle/square styled functions ]
autoload -Uz \
	prompt_zshgod_rectangular_git_dirty \
	prompt_zshgod_rectangular_git_info \
	prompt_zshgod_rectangular_time \
	prompt_zshgod_rectangular_exectime_seconds-only \
	prompt_zshgod_rectangular_exectime_human-readable \
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
	prompt_zshgod_left-to-right_exectime_seconds-only \
	prompt_zshgod_left-to-right_exectime_human-readable \
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
	prompt_zshgod_right-to-left_exectime_seconds-only \
	prompt_zshgod_right-to-left_exectime_human-readable \
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
