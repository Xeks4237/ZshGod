# [ Title with useful information ]
# Zsh-God Prompt
# Made by Xeks4237: https://gitlab.com/Xeks4237
# Licensed under: MIT License

# Zsh substitutions (To get more info check mandocs of zsh):
#  %F{} => Changes foreground color of text after itself
#  %K{} => Changes background color of text after itself
#  %f   => Resets foreground coloring after itself
#  %k   => Resets background coloring after itself
#  %B   => Makes text after itself to bold
#  %b   => Resets 'boldness' effect of text caused by %B
#  %S   => Inverts foreground and background colors between each other
#  %s   => Resets invertion of foreground and background colors between each other
#  %D{} => Shows customly formatted time, like soo '%H:%M:%S.%.'
#  %~   => Current path relative to $HOME directory
#  %n   => Shows $USERNAME of the surrent user
#  %m   => Shows hostname up to the first `.' symbols
#  %#   => Shows '#' if shell is privileged, if not '%', its same as %(!,#,%%)
# %(?,,) => prompt condition for doing some logic, %(condition,true,false)

# [ Autoload used/needed functions ]
# Autoload functions which are used in prompt, availible functions are mentioned in help page ( prompt -h zshgod )
# NOTE: Autoloaded functions are practically lazy loaded functions
# Always use '-Uz' to supress alias expansion and to use zsh styly autoloading
autoload -Uz \
	prompt_zshgod_setup \
	prompt_zshgod_configure \
	prompt_zshgod_preexec \
	prompt_zshgod_precmd \
	prompt_zshgod_exectime \
	prompt_zshgod_vcs_branch \
	prompt_zshgod_vcs_system \
	prompt_zshgod_zsh-async-lib \
	prompt_zshgod_async-callback
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

# [ Configuration ]
# zstyle options to enable or disable some vcs systems which you don't use
# zstyle ':vcs_info:*' disable git svn
zstyle ':vcs_info:*' enable bzr cdv cvs darcs fossil git hg mtn p4 svk svn tla

# Array with items of prompt left side
ZSHGOD_LEFT_PROMPT=(
	'prompt_zshgod_left-to-right_current-pwd "#89B4FA" "#11111B"'
	'prompt_zshgod_left-to-right_jobs "#CBA6F7" "#11111B"'
	'prompt_zshgod_left-to-right_vcs_system "#B4BEFE" "#11111B"'
	'prompt_zshgod_left-to-right_vcs_branch "#A6E3A1" "#11111B"'
	"prompt_zshgod_left-to-right_git_info '#6C7086' '#A6E3A1' '#F9E2AF' '#F38BA8' '#89DCEB' '#B4BEFE'"
	'prompt_zshgod_left-to-right_exectime_human-readable "#F9E2AF" "#11111B"'
	$'\n'
	'prompt_zshgod_left-to-right_time "#F9E2AF" "#11111B"'
	'prompt_zshgod_left-to-right_root-indicator "#A6E3A1" "#11111B" "#F38BA8" "#11111B"'
	' '
)

# Array with items of prompt right side
ZSHGOD_RIGHT_PROMPT=(
	'prompt_zshgod_right-to-left_sshonly_userandhostname "#A6E3A1" "#11111B" "#F38BA8" "#11111B" "#F9E2AF" "#11111B" "#89B4FA" "#11111B"'
)

# Run promptinit in end to update list of themes
promptinit
