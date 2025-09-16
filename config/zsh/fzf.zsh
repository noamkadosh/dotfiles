export FZF_DEFAULT_OPTS=$FZF_DEFAULT_OPTS' 
	--color=fg:#C0CAF5,bg:-1,hl:#bb9af7
	--color=fg+:#FFFFFF,bg+:-1,hl+:#7DCFFF
	--color=info:#7AA2F7,prompt:#7DCFFF,pointer:#7DCFFF 
	--color=marker:#9ECE6A,spinner:#9ECE6A,header:#9ECE6A'

export FZF_CTRL_T_OPTS="
    --preview 'bat -n --color=always {}'
    --bind 'ctrl-/:change-preview-window(down|hidden|)'"

export FZF_CTRL_R_OPTS="
    --preview 'echo {}' --preview-window up:3:hidden:wrap
    --bind 'ctrl-/:toggle-preview'
    --bind 'ctrl-y:execute-silent(echo -n {2..} | xclip xclip -selection clipboard)+abort'
    --color header:italic
    --header 'Press CTRL-Y to copy command into clipboard'"

export FZF_ALT_C_OPTS="--preview 'tree -C {}'"

_fzf_compgen_path() {
    fd --hidden --follow --exclude ".git" . "$1"
}

_fzf_compgen_dir() {
    fd --type d --hidden --follow --exclude ".git" . "$1"
}
