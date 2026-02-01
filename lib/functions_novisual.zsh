# [ Functions only needed to be used in other functions ]
# Function which captures exectime before executing every command
prompt_zshgod_preexec() {
    # Saves value of $EPOCHSECONDS before executing command to variable
    # Its for prompt_zshgod_exectime function
    ZSHGOD_EXECTIME_START=$EPOCHSECONDS
}

# Function which calculates exectime before drowing prompt
prompt_zshgod_precmd() {
    # Piece of code which calculated exectime before displaying prompt
    # Its for prompt_zshgod_exectime function
    if (( ${+ZSHGOD_EXECTIME_START} )); then
        ZSHGOD_EXECTIME_DURATION=$(( EPOCHSECONDS - ZSHGOD_EXECTIME_START ))
        unset ZSHGOD_EXECTIME_START
    else
        unset ZSHGOD_EXECTIME_DURATION
    fi
}

# Function which echos empty line for making prompt sparse
prompt_zshgod_sparse-prompt() {
    if [[ ZSHGOD_SPARSE == true ]]; then
        echo ''
    fi
}

