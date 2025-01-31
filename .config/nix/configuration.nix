{
  pkgs,
  lib,
  inputs,
  ...
}: let
  unstable = import inputs.nixpkgs-unstable {
    inherit (pkgs) system;
    config = {
      allowUnfree = true;
      allowUnsupportedSystem = true;
    };
  };
in {
  system = {
    stateVersion = 5;
    keyboard = {
      enableKeyMapping = true;
      remapCapsLockToEscape = true;
    };
  };

  # This is needed since stateVersion is set to 5 (the GID for v5 is 350)
  # see https://github.com/LnL7/nix-darwin/blob/7840909b00fbd5a183008a6eb251ea307fe4a76e/CHANGELOG#L1
  ids.gids.nixbld = 30000;

  nix = {
    settings = {
      experimental-features = "nix-command flakes";
      substituters = [
        "https://cache.nixos.org/"
      ];
      trusted-public-keys = [
        "cache.nixos.org-1:6NCHdD59X431o0gWypbMrAURkbJ16ZPMQFGspcDShjY="
      ];
      trusted-users = [
        "@admin"
      ];
    };
    configureBuildUsers = true;

    package = pkgs.nixVersions.stable;

    extraOptions =
      ''
        auto-optimise-store = true
        experimental-features = nix-command flakes
      ''
      + lib.optionalString (pkgs.system == "aarch64-darwin") ''
        extra-platforms = x86_64-darwin aarch64-darwin
      '';
  };

  users.users = {
    noam = {
      home = "/Users/noam";
    };
  };

  programs = {
    zsh.enable = true;
    nix-index.enable = true;
  };

  services = {
    nix-daemon.enable = true;
    skhd = {
      enable = true;
      package = unstable.skhd;
    };
    yabai = { # migrate to aerospace
      enable = true;
      package = unstable.yabai;
      enableScriptingAddition = true;
    };
  };

  security.pam.enableSudoTouchIdAuth = true;
}
