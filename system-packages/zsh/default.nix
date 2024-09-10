{ pkgs, ... }:

{
  imports = [];
  programs.zsh = {
    enable = true;
    autosuggestion.enable = true;
    syntaxHighlighting.enable = true;

    shellAliases = {
      ll = "ls -l";
      switch = "darwin-rebuild switch --flake ~/.config/nix-darwin";
    };

    initExtra = ''
      eval "$(zoxide init zsh)"
    '';
  };
}
