{ pkgs, ... }:

{
  imports = [
    ./kitty
    ./zsh
    ./starship
  ];

  programs.direnv = {
    enable = true;
    enableZshIntegration = true;
    nix-direnv = {
      enable = true;
    };
  };
}
