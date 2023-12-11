{
  description = "Noam's darwin system";

  inputs = {
    # Package sets
    nixpkgs.url = "github:nixos/nixpkgs/nixpkgs-23.11-darwin";
    nixpkgs-unstable.url = "github:NixOS/nixpkgs/nixpkgs-unstable";

    # Environment/system management
    darwin.url = "github:lnl7/nix-darwin/master";
    darwin.inputs.nixpkgs.follows = "nixpkgs";
    home-manager.url = "github:nix-community/home-manager/release-23.11";
    home-manager.inputs.nixpkgs.follows = "nixpkgs";

    # Other sources
    comma = {
      url = "github:nix-community/comma";
      flake = false;
    };
  };

  outputs = {
    self,
    darwin,
    nixpkgs,
    nixpkgs-unstable,
    home-manager,
    ...
  } @ inputs: let
    inherit (darwin.lib) darwinSystem;
    inherit (nixpkgs-unstable.lib) attrValues optionalAttrs singleton;

    # Configuration for `nixpkgs`
    nixpkgsConfig = {
      config = {
        allowUnfree = true;
        allowUnsupportedSystem = true;
      };
      overlays =
        attrValues self.overlays
        ++ singleton (
          # Sub in x86 version of packages that don't build on Apple Silicon yet
          final: prev: (optionalAttrs (prev.stdenv.system == "aarch64-darwin") {
            inherit
              (final.pkgs-x86)
              nix-index
              ;
          })
        );
    };
  in {
    # My `nix-darwin` configs
    darwinConfigurations = {
      Noam = darwinSystem {
        system = "aarch64-darwin";
        modules =
          attrValues self.darwinModules
          ++ [
            # Main `nix-darwin` config
            ./configuration.nix
            # `home-manager` module
            home-manager.darwinModules.home-manager
            {
              nixpkgs = nixpkgsConfig;
              # `home-manager` config
              home-manager = {
                useGlobalPkgs = true;
                useUserPackages = true;
                users.noam = import ./home.nix;
                extraSpecialArgs = {inherit inputs;};
              };
            }
          ];
        specialArgs = {inherit inputs;};
      };
    };

    services.skhd = {
      enable = true;
      package = nixpkgs.skhd;
    };

    services.yabai = {
      enable = true;
      package = nixpkgs.yabai;
      enableScriptingAddition = true;
    };

    # Overlays --------------------------------------------------------------- {{{

    overlays = {
      # Overlays to add various packages into package set
      comma = final: prev: {
        comma = import inputs.comma {inherit (prev) pkgs;};
      };

      # Overlay useful on Macs with Apple Silicon
      apple-silicon = final: prev:
        optionalAttrs (prev.stdenv.system == "aarch64-darwin") {
          # Add access to x86 packages system is running Apple Silicon
          pkgs-x86 = import inputs.nixpkgs-unstable {
            system = "x86_64-darwin";
            inherit (nixpkgsConfig) config;
          };
        };
    };

    # My `nix-darwin` modules that are pending upstream, or patched versions waiting on upstream
    # fixes.
    darwinModules = {};
  };
}
