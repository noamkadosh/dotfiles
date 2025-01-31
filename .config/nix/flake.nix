{
  description = "Noam's darwin system";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixpkgs-24.11-darwin";
    nixpkgs-unstable.url = "github:NixOS/nixpkgs/nixpkgs-unstable";

    darwin = {
      url = "github:lnl7/nix-darwin/nix-darwin-24.11";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    home-manager = {
      url = "github:nix-community/home-manager/release-24.11";
      inputs.nixpkgs.follows = "nixpkgs";
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
    darwinConfigurations = {
      Noam = darwinSystem {
        system = "aarch64-darwin";
        modules =
          attrValues self.darwinModules
          ++ [
            ./configuration.nix
            home-manager.darwinModules.home-manager
            {
              nixpkgs = nixpkgsConfig;
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

    overlays = {
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

    darwinModules = {};
  };
}
