{config, pkgs, pkgs-unstable, inputs,  ... }: {

    home.packages = with pkgs; [ 
        hypridle
        hyprshot
        hyprpicker
        hyprsunset
        gnome-bluetooth
        bluez
        bluez-tools
        upower
        remnote
        eog
        nemo
        firefox
        libresprite
        thunderbird
        mqttx
        systemctl-tui
        redisinsight
        wakafetch

        fluxcd
        kubectl
        helm
        k9s
    ];

    imports = [
        ./common.nix
        ./hypr/default.nix
    ];


    home.shellAliases = {
        nrs = "sudo nixos-rebuild switch --flake /home/marc/dotfiles#laptop";
        nrt = "sudo nixos-rebuild test --flake /home/marc/dotfiles#laptop";
        aoc = "cd ~/dev/adventofcode/Python/2024 && nix develop";
        gs = "git status";
        gl = "git log --oneline";
        nd = "nix develop";
    };


    home.username = "marc";
    home.homeDirectory = "/home/marc";

    programs.home-manager.enable = true;

    programs.bash.enable = true;
    home.stateVersion = "24.05";

    programs.gh.enable = true;

    home.pointerCursor = {
        package = pkgs.bibata-cursors;
        name = "Bibata-Modern-Classic";
        size = 24;
        gtk.enable = true;
        x11.enable = true;
    };

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

        gtk3.extraConfig = {
            gtk-application-prefer-dark-theme = 1;
        };
        gtk4.extraConfig = {
            gtk-application-prefer-dark-theme = 1;
        };
    };
}
