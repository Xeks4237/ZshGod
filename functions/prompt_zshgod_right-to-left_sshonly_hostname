# Same function as prompt_zshgod_right-to-left_hostname but shown only through ssh
function prompt_zshgod_right-to-left_sshonly_hostname() {
	# Allow passing args to function for changing foreground and background colors
	local bg_color=$1
	local fg_color=$2

	[[ -n $SSH_CONNECTION ]] && prompt_zshgod_right-to-left_hostname $bg_color $fg_color
}
