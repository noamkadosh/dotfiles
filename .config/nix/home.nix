{ config, pkgs, lib, ... }:

{
  home.stateVersion = "22.05";

  # https://github.com/malob/nixpkgs/blob/master/home/default.nix

  # Direnv, load and unload environment variables depending on the current directory.
  # https://direnv.net
  # https://rycee.gitlab.io/home-manager/options.html#opt-programs.direnv.enable
  programs.direnv.enable = true;
  programs.direnv.nix-direnv.enable = true;

  # Htop
  # https://rycee.gitlab.io/home-manager/options.html#opt-programs.htop.enable
  programs.htop.enable = true;
  programs.htop.settings.show_program_path = true;

  home.packages = with pkgs; [
      act
      avrdude
      bandwhich
      bat
      bottom
      cachix # adding/managing alternative binary caches hosted by Cachix
      coreutils
      curl
      # docker
      # docker-compose
      du-dust
      exa
      fd
      flyctl
      fzf
      gh
      go
      grex
      hyperfine
      kubectl
      linode-cli
      lua
      # mongodb
      neovim
      nodejs-18_x
      nodePackages.pnpm
      nodePackages.snyk
      nodePackages.vercel
      # postgresql
      procs
      python3
      # redis
      ripgrep
      rustup
      sd
      # phantom "unsupported platform" issue 
      # export NIXPKGS_ALLOW_UNSUPPORTED_SYSTEM=1
      sheldon
      starship
      tealdeer
      tokei
      yarn
      zellij
      zoxide
      zsh
  ] ++ lib.optionals stdenv.isDarwin [
    cocoapods
    m-cli # useful macOS CLI commands
  ];

  # Misc configuration files --------------------------------------------------------------------{{{

  # https://docs.haskellstack.org/en/stable/yaml_configuration/#non-project-specific-config
  home.file.".stack/config.yaml".text = lib.generators.toYAML {} {
    templates = {
      scm-init = "git";
      params = {
        author-name = "Noam Kadosh"; # config.programs.git.userName;
        author-email = "noamkadosh91@gmail.com"; # config.programs.git.userEmail;
        github-username = "noamkadosh";
      };
    };
    nix.enable = true;
  };

}