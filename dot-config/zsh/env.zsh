. "/etc/profiles/per-user/$USER/etc/profile.d/hm-session-vars.sh"
export XDG_CACHE_HOME="$HOME/.cache"
export XDG_CONFIG_HOME="$HOME/.config"
export XDG_DATA_HOME="$HOME/.local/share"

export PATH="/Applications/Ghostty.app/Contents/MacOS:/etc/profiles/per-user/noam/bin/aws_completer:$HOME/.local/bin:$BOB_NVIM_HOME:$CARGO_HOME/bin:$VOLTA_HOME/bin:$GOPATH/bin:$PATH"
export FPATH="$XDG_CONFIG_HOME/zsh/completions:$HOME/.local/share/sheldon:$FPATH"
export CARGO_HOME="$HOME/.cargo"
export BOB_NVIM_HOME="$XDG_DATA_HOME/bob/nvim-bin"
export VOLTA_HOME="$HOME/.volta"
export GOPATH="$HOME/Developer/go"
export GOROOT=
export EDITOR="nvim"
export DISPLAY=:0
export STARSHIP_CONFIG="$XDG_CONFIG_HOME/starship/starship.toml"
export LESSOPEN='|~/.lessfilter %s'
