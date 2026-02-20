# Function which returns branch/subversion info about current vcs
function prompt_zshgod_left-to-right_vcs_branch() {
	# Allow passing args to function for changing foreground and background colors
	local bg_color=$1
	local fg_color=$2

	[[ -n $(prompt_zshgod_vcs_branch) ]] || return
	print "%F{$bg_color}%S %K{$fg_color}$(prompt_zshgod_vcs_branch)%k %s%f"
}
