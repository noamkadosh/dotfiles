# display error message when a command fails
# usage: <COMMAND> || die "<ERROR>"
function die() {
    echo "Error: $1" >&2
    exit 1
}

#
function batOrMdcat() {
    # Get the file extension
    extension="${1##*.}"

    # Check the extension and run the appropriate command
    if [[ "$extension" == "md" ]]; then
        mdcat "$@"
    else
        bat "$@"
    fi
}

# gitWorktreeAdd <new/existing> <branch>
function gitWorktreeAdd() {
    # move to root if requested
    if [[ "$1" == "root" ]]; then
        local root_path=""

        if [[ $PWD = *.git-worktrees ]]; then
            root_path=".."
        elif [[ $PWD = *.git-worktrees* ]]; then
            root_path="../.."
        fi

        pushd "${root_path}" > /dev/null
    elif [[ -n "$2" ]]; then
        local folder_name=$(echo "$2" | tr '/' '-')
        local folder_path=".git-worktrees/${folder_name}"

        if [[ $PWD = *.git-worktrees ]]; then
            folder_path="${folder_name}"
        elif [[ $PWD = *.git-worktrees* ]]; then
            folder_path="../${folder_name}"
        fi

        # new branch, new worktree
        if [[ "$1" == "new" ]]; then
            git worktree add --track -b "$2" "${folder_path}"
        # worktree doesn't exist - create it
        elif [ ! -d "$folder_path" ]; then 
            git worktree add "${folder_path}" "$2"
        fi

        # move to the new worktre
        pushd "${folder_path}" > /dev/null
    else
        echo 'Error: please provide path and a branch.'
    fi
}

# gRemoveFileChangesTillCommit <commit> <filename>
function gRemoveFileChangesTillCommit() {
    if [[ -n "$1" || -n "$2" ]]; then
        git checkout "$1" -- "$2"
    else
        echo 'Error: please provide a commit and a filename.'
    fi
}

# killPort <port>
function killPort() {
    if [[ -n "$1" ]]
    then
        lsof -t -i tcp:"$1" | xargs kill -15
    else
        echo 'Error: please provide a port number.'
    fi
}

