#!/bin/zsh

# Symilink VSCode settings
[ -e "$HOME/.config/vscode/settings.json" -a ! -L "$HOME/Library/Application\ Support/Code/User/settings.json" ] && ln -s $HOME/.config/vscode/settings.json $HOME/Library/Application\ Support/Code/User/settings.json
[ -e "$HOME/.config/vscode/keybindings.json" -a ! -L "$HOME/Library/Application\ Support/Code/User/keybindings.json" ] && ln -s $HOME/.config/vscode/keybindings.json $HOME/Library/Application\ Support/Code/User/keybindings.json
[ -e "$HOME/.config/vscode/snippets/" -a ! -L "$HOME/Library/Application\ Support/Code/User/snippets/" ] && ln -s $HOME/.config/vscode/snippets/ $HOME/Library/Application\ Support/Code/User/snippets/

# Install VSCode extensions
extensions=(
    aaron-bond.better-comments
    adpyke.codesnap
    alefragnani.numbered-bookmarks
    amatiasq.sort-imports
    anseki.vscode-color
    arcanis.vscode-zipfs
    astro-build.astro-vscode
    bbenoist.Nix
    ChakrounAnas.turbo-console-log
    christian-kohler.npm-intellisense
    christian-kohler.path-intellisense
    chrmarti.regex
    ckolkman.vscode-postgres
    cschleiden.vscode-github-actions
    csstools.postcss
    DavidAnson.vscode-markdownlint
    dbaeumer.vscode-eslint
    eamodio.gitlens
    ecmel.vscode-html-css
    EditorConfig.EditorConfig
    enkia.tokyo-night
    esbenp.prettier-vscode
    evald24.vscode-extension-profiles
    firsttris.vscode-jest-runner
    formulahendry.auto-close-tag
    formulahendry.auto-rename-tag
    formulahendry.code-runner
    GitHub.copilot
    GitHub.remotehub
    GitHub.vscode-pull-request-github
    glenn2223.live-sass
    golang.go
    GraphQL.vscode-graphql
    GraphQL.vscode-graphql-execution
    GraphQL.vscode-graphql-syntax
    humao.rest-client
    jasonnutter.search-node-modules
    jgclark.vscode-todo-highlight
    kaiwood.center-editor-window
    kdl-org.kdl
    leizongmin.node-module-intellisense
    mhutchie.git-graph
    miguelsolorio.fluent-icons
    mikestead.dotenv
    mongodb.mongodb-vscode
    mrmlnc.vscode-json5
    mrmlnc.vscode-scss
    ms-azuretools.vscode-docker
    ms-playwright.playwright
    ms-vscode-remote.remote-containers
    ms-vscode-remote.remote-ssh
    ms-vscode-remote.remote-ssh-edit
    ms-vscode-remote.remote-wsl
    ms-vscode-remote.vscode-remote-extensionpack
    ms-vscode.remote-explorer
    ms-vscode.remote-repositories
    ms-vsliveshare.vsliveshare
    ms-vsliveshare.vsliveshare-audio
    ms-vsliveshare.vsliveshare-pack
    mtxr.sqltools
    mtxr.sqltools-driver-pg
    naumovs.color-highlight
    oderwat.indent-rainbow
    oouo-diogo-perdigao.docthis
    pflannery.vscode-versionlens
    PKief.material-icon-theme
    pranaygp.vscode-css-peek
    Prisma.prisma
    quicktype.quicktype
    rangav.vscode-thunder-client
    redhat.vscode-yaml
    richie5um2.vscode-sort-json
    ritwickdey.LiveServer
    rust-lang.rust-analyzer
    standard.vscode-standard
    statelyai.stately-vscode
    stevencl.addDocComments
    streetsidesoftware.code-spell-checker
    stylelint.vscode-stylelint
    syler.sass-indented
    tamasfe.even-better-toml
    Tobermory.es6-string-html
    Tyriar.sort-lines
    usernamehw.errorlens
    vincaslt.highlight-matching-tag
    VisualStudioExptTeam.intellicode-api-usage-examples
    VisualStudioExptTeam.vscodeintellicode
    vscodevim.vim
    WallabyJs.quokka-vscode
    wix.vscode-import-cost
    xabikos.JavaScriptSnippets
    yinfei.luahelper
    Zignd.html-css-class-completion
    ZixuanChen.vitest-explorer
)

for i in ${extensions[@]}; do
    code --log error --install-extension $i --force || echo "Failed to install extension $i"
done

