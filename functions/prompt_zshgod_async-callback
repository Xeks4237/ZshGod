# Function which is registered as callback function for async workers
# of zshgod prompt, when async worker finishes running it outputs results
# to this function as arguments where:
# First argument is th name of the function which was runned
# Second argument is the return code of the function which was runned
# Third argument is the output(stdout) of the function which was runned
# Fourt argument is the execution time of the function which was runned
# Fifth argument is the error output(stderr) of the function which was runned
# Sixth argument has next result in buffer (0 = buffer empty, 1 = yes)
function prompt_zshgod_async-callback() {
	# Local variables for each argument
	local job_name=$1 exit_code=$2 output=$3 exec_time=$4 stderr=$5 next=$6

	# Dynamically create new variable based on the function name in $job_name
	# and then put value in $output to the newly created variable
	# For example $job_name with zsh_git-info will create variable ZSH_GIT_INFO
	local varname="${${job_name//-/_}:u}"
	typeset -g "${varname}"="${output}"

	# Redisplay/Update prompt
	zle && zle redisplay && zle reset-prompt
}
