{ config, pkgs, ... }: {
    home.packages = with pkgs; [ 
      firefox
      spotify
      vscode
      kitty
      starship
      wofi

    ];


    home.username = "marc";
    home.homeDirectory = "/home/marc";

    programs.home-manager.enable = true;

    #manual.manpages.enable = false;

    programs.bash.enable = true;
    home.stateVersion = "24.05";
    programs.git = {
    	enable = true;
	userEmail = "marc.schoenig@gmail.com";
	userName = "marc55s";
	extraConfig = {
		push.autoSetupRemote = true;
	};
    };

    programs.neovim =  {
    	defaultEditor = true;
    };

    home.file.".config/nvim" = {
    	source = ./neovim-config;
	recursive = true;
    };




    imports = [

    ];

    # flakes
    #nix = {
    #  package = pkgs.nix;
    #  settings.experimental-features = [ "nix-command" "flakes" ];
    #};
  }
