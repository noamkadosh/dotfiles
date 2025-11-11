{
  config,
  pkgs,
  inputs,
  ...
}: let
  unstable = import inputs.nixpkgs-unstable {
    inherit (pkgs) system;
  };
in {
  home.packages = with pkgs; [
    (
      unstable.python311.withPackages (
        ps:
          with ps; [
            prompt-toolkit
            pynvim
            python-dotenv
            requests
            tiktoken
          ]
      )
    )
  ];
}
