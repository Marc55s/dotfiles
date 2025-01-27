{config, pkgs, textfox, ... }: {

    home.packages = with pkgs; [ 
        lua-language-server
        spotify
        vscode
        wofi
        hyprlock
        hyprpaper
        hypridle
        hyprshot
        hyprpanel
        hyprpicker
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
        lazygit
        lazydocker
        nitch
        remnote
        bitwarden
        zathura
        vesktop
        (discord.override {
            # withOpenASAR = true; # can do this here too
            withVencord = true;
        })
    ];

    imports = [
        textfox.homeManagerModules.default
        ./rofi.nix
        ./kitty/kitty.nix
        ./tmux.nix
    ];


    home.shellAliases = {
        nrs = "sudo nixos-rebuild switch --flake /home/marc/dotfiles#";
        nrt = "sudo nixos-rebuild test --flake /home/marc/dotfiles#";
        aoc = "cd ~/dev/adventofcode/Python/2024 && nix develop";
        gs = "git status";
    };


    textfox = {
        enable = true;
        profile = "default";
        config = {
            displayHorizontalTabs = true;
        };
    };

    home.username = "marc";
    home.homeDirectory = "/home/marc";

    programs.home-manager.enable = true;

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




}
