{ ... }:

{
  imports = [];

  programs.zsh = {
    enable = true;
    autosuggestion.enable = true;
    syntaxHighlighting.enable = true;

    shellAliases = {
      ls = "eza";
      la = "eza -la";
      ld = "eza -lD";
      lf = "eza -lf --color=always | grep -v /";
      lh = "eza -dl .* --group-directories-first";
      ll = "eza -al --group-directories-first";
      lt = "eza -al --sort=modified";
      llf = "eza -alf --color=always --sort=size | grep -v /";
      switch = "darwin-rebuild switch --flake ~/.config/nix-darwin";
    };

    initExtra = ''
      eval "$(zoxide init zsh)"
    '';
  };
}
