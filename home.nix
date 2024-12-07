{ config, pkgs, ... }: {
    home.packages = with pkgs; [ 
        firefox
        spotify
        vscode
        wofi
        hyprlock
        hyprpaper
        hypridle
        hyprshot
	    kitty
    ];

    home.shellAliases = {
        nrs = "sudo nixos-rebuild switch --flake /home/marc/dotfiles#";
        nrt = "sudo nixos-rebuild test --flake /home/marc/dotfiles#";
    };

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

    programs.ripgrep.enable = true;

    programs.neovim =  {
        defaultEditor = true;
    };

    programs.gh.enable = true;

    programs.zsh = {
        enable = true;
        enableCompletion = true;
        sessionVariables = {
            PYTHONPATH = "/home/marc/dev/adventofcode/Python/lib:$PYTHONPATH";
        };
    };

    programs.starship = {
        enable = true;
        settings = pkgs.lib.importTOML ./starship/starship.toml;
        enableZshIntegration = true;
    };


    home.file.".config/nvim" = {
        source = ./neovim-config;
        recursive = true;
    };



    imports = [
        ./rofi.nix
    ];

    # flakes
    #nix = {
    #  package = pkgs.nix;
    #  settings.experimental-features = [ "nix-command" "flakes" ];
    #};
}
