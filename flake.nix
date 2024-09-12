{
  description = "Example Darwin system flake";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixpkgs-unstable";
    nix-darwin = {
      url = "github:LnL7/nix-darwin";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    nix-nvim = {
      url = "github:lfaudreejr/nvim-nix";
    };
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = { self, nix-darwin, home-manager, nix-nvim, ... }:
  let
    configuration = { pkgs, lib, ... }: {
      nix.settings.trusted-users = [ "root" "larryfaudree" ];
      nixpkgs.config.allowUnfreePredicate = pkg: builtins.elem (lib.getName pkg) [
        "ngrok"
      ];
      # List packages installed in system profile. To search by name, run:
      # $ nix-env -qaP | grep wget
      environment.systemPackages =
        [ pkgs.vim
          pkgs.zoxide
          pkgs.jq
          pkgs.bat
          pkgs.ripgrep
          pkgs.fd
          pkgs.eza
          pkgs.fzf
          pkgs.curl
          pkgs.duf
          pkgs.glances
          pkgs.gnused
          pkgs.tldr
          pkgs.scc
          pkgs.dua
          pkgs.lazygit
          pkgs.ngrok
          pkgs.devenv
        ];

      # Auto upgrade nix package and the daemon service.
      services.nix-daemon.enable = true;
      # nix.package = pkgs.nix;

      # Necessary for using flakes on this system.
      nix.settings.experimental-features = "nix-command flakes";

      # Create /etc/zshrc that loads the nix-darwin environment.
      programs.zsh.enable = true;  # default shell on catalina
      # programs.fish.enable = true;

      # Set Git commit hash for darwin-version.
      system.configurationRevision = self.rev or self.dirtyRev or null;

      # Used for backwards compatibility, please read the changelog before changing.
      # $ darwin-rebuild changelog
      system.stateVersion = 4;

      # The platform the configuration will be used on.
      nixpkgs.hostPlatform = "x86_64-darwin";

      security.pam.enableSudoTouchIdAuth = true;

      homebrew.enable = true;
      homebrew.casks = [];
      homebrew.brews = [];

      users.users."larryfaudree".home = "/Users/larryfaudree";
    };
    homeconfig = { ... }: {
      # this is for internale home-manager configurability
      # don't touch
      home.stateVersion = "23.05";
      # let's home-manager configure itself
      programs.home-manager.enable = true;

      home.packages = [
        nix-nvim.packages."x86_64-darwin".nvim
      ];

      home.sessionVariables = {
        EDITOR = "vim";
      };

      imports = [
        ./home-packages/home.nix
      ];
    };
  in
  {
    # Build darwin flake using:
    # $ darwin-rebuild build --flake .#Larrys-MacBook-Pro
    darwinConfigurations."Larrys-MacBook-Pro" = nix-darwin.lib.darwinSystem {
      modules = [ 
        configuration
        home-manager.darwinModules.home-manager {
          home-manager.useGlobalPkgs = true;
          home-manager.useUserPackages = true;
          home-manager.verbose = true;
          home-manager.users."larryfaudree" = homeconfig;
          home-manager.backupFileExtension = "bak";
        }
      ];
    };

    # Expose the package set, including overlays, for convenience.
    darwinPackages = self.darwinConfigurations."Larrys-MacBook-Pro".pkgs; 
  };
}
