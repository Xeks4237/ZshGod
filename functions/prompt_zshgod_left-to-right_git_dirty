# Function for checking git repos if they are dirty
function prompt_zshgod_left-to-right_git_dirty() {
	# Allow passing args to function for changing foreground and background colors
	local bg_color=$1
	local fg_color=$2

	# Check if we're in a git repo
	[[ $(prompt_zshgod_vcs_system) == 'git' ]] || return

	# Checks if it's dirty
	local umode="-uno"
	command test -n "$(git status --porcelain --ignore-submodules ${umode} 2>/dev/null | head -100)"

	# Prints "*" if repo is dirty
	(($? == 0)) && print "%F{$bg_color}%S %K{$fg_color}*%k %s%f"
}
