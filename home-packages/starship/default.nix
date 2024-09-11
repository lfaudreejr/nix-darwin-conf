{ pkgs, ... }:

{
  imports = [];
  
  programs.starship = {
    enable = true;
    enableZshIntegration = true;
  };

  home.file = {
    starship = {
      target = ".config/starship.toml";
      source = ./starship.toml;
    };
  };
}
