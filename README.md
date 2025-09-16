# Prerequisites

- `git`
- `stow`

# Installation

```shell
git clone git@github.com:noamkadosh/dotfiles.git # clone this repository

cd dotfiles # cd into the repository

git checkout main # checkout main

git submodule update --init --force --checkout # pull, update and checkout main on submodules

$(command -v zsh) "$HOME/config/install.zsh" # run the install script
```
