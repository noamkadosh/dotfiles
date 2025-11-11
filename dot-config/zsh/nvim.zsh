# get last working directory from nvim and cd to it, other part of the solution is in nvim config.
nvim() {
    export NVIM_NEW_DIR_FILE="$HOME/.temp/nvim/cwd"
    
    command nvim "$@"

    if [[ -f "$NVIM_NEW_DIR_FILE" ]]; then
        rc=$?
        new_dir="$(cat "$NVIM_NEW_DIR_FILE")"
        while [[ "$new_dir" != "$HOME" ]]; do
            if [[ -d "$new_dir/.git" ]]; then
                cd "$new_dir"
                rm "$NVIM_NEW_DIR_FILE"
                return $rc
            fi
            new_dir="$(dirname "$new_dir")"
        done
        rm "$NVIM_NEW_DIR_FILE"
    fi
}
