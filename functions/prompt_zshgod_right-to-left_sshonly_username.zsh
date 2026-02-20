# Same function as prompt_zshgod_right-to-left_username but shown only through ssh
function prompt_zshgod_right-to-left_sshonly_username() {
	# Allow passing args to function for changing foreground and background colors
	local user_bg_color=$1
	local user_fg_color=$2
	local root_bg_color=$3
	local root_fg_color=$4

	[[ -n $SSH_CONNECTION ]] && prompt_zshgod_right-to-left_username $user_bg_color $user_fg_color $root_bg_color $root_fg_color
}
