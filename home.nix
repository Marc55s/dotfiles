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
        hyprpanel
	    kitty
        obsidian
        libgtop
        dart-sass
        ags
        gnome-bluetooth
        bluez
        bluez-tools
        btop
        upower
        acpi
    ];

    home.shellAliases = {
        nrs = "sudo nixos-rebuild switch --flake /home/marc/dotfiles#";
        nrt = "sudo nixos-rebuild test --flake /home/marc/dotfiles#";
        aoc = "cd ~/dev/adventofcode/Python/2024 && nix develop";
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


    # home.file.".config/nvim" = {
    #     source = ./neovim-config;
    #     recursive = true;
    #};
    gtk = {
        enable = true;
        theme = {
            package = pkgs.gnome-themes-extra;
            name = "Adwaita-dark";
        };
        iconTheme = {
            package = pkgs.adwaita-icon-theme;
            name = "Adwaita";
        };
        gtk4.extraConfig = {
            gtk-application-prefer-dark-theme = 1;
        };
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
