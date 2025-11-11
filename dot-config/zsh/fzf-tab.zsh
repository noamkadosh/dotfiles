zstyle ':completion:*:descriptions' format '[%d]' # set descriptions format to enable group support
zstyle ':fzf-tab:*' switch-group '[' ']' # switch group using `[` and `]`
zstyle ':fzf-tab:*' continuous-trigger 'tab' # continuous trigger using tab key
zstyle ':fzf-tab:complete:*:*' fzf-preview 'less ${(Q)realpath}'

