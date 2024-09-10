{ config, pkgs, ... }:

{
  # Add kitty to your programs
  home.packages = [
    pkgs.kitty  # This installs Kitty
  ];

  # Optionally, specify terminal settings
  programs.kitty = {
    enable = true;
    # Set the terminal font
    font = {
      name = "JetBrains Mono";  # Specify your preferred font family
      size = 20;            # Font size
    };

    extraConfig = ''
      # Set the terminal theme
      include ./current-theme.conf
    '';

    shellIntegration.enableZshIntegration = true;
    # You can add more customization options
  };

  # Other configurations if needed...
}

