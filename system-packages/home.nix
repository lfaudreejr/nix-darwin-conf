{ ... }:

{
  imports = [
    ./kitty
    ./zsh
    ./starship
  ];

  programs.neovim = {
    enable = true;
  };

  programs.direnv = {
    enable = true;
    enableZshIntegration = true;
    nix-direnv = {
      enable = true;
    };
  };

  programs.zellij = {
    enable = true;
    enableZshIntegration = true;
  };
}
