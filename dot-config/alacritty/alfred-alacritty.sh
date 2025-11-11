set -x
zsh -c "${1:-echo "No command passed"}; zsh"
{ set +x; } 2>/dev/null
