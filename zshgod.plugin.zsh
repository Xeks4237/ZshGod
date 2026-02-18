# [ Title with useful information ]
# Zsh-God Prompt
# Made by Xeks4237: https://gitlab.com/Xeks4237
# Licensed under: MIT License

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

# Autoload promptinit system in case it's not loaded
autoload -Uz promptinit

# Initialize/Update prompts list
promptinit
