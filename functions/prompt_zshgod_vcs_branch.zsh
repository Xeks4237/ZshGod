# Function which returns branch/subversion info about current vcs
function prompt_zshgod_vcs_branch() {
	# zstyle options to customize look of vcs_info
	zstyle ':vcs_info:*' actionformats '%b|%a'
	zstyle ':vcs_info:*' formats '%b'
	zstyle ':vcs_info:(sv[nk]|bzr):*' branchformat '%b:%r'

	# Run vcs_info to get/update vcs info
	vcs_info

	# Check if $vcs_info_msg_0_ is empty and if not prints vcs branch info
	local vcs_msg=$vcs_info_msg_0_
	[[ -n $vcs_msg ]] && print "$vcs_msg"
}
