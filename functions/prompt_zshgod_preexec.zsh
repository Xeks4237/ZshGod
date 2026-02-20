# Function which gets called before running commands, like when you press enter to run command
function prompt_zshgod_preexec() {
	# Saves value of $EPOCHSECONDS before executing command, to variable
	# Its for prompt_zshgod_exectime function
	ZSHGOD_EXECTIME_START=$EPOCHSECONDS
}
