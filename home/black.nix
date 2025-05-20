{config, pkgs, pkgs-unstable, inputs,  ... }: {

    home.packages = with pkgs; [ 
        spotify
        hyprpaper
        hypridle
        hyprshot
        hyprpicker
        hyprsunset
        libgtop
        libnotify
        dart-sass
        ags
        gnome-bluetooth
        bluez
        bluez-tools
        upower
        acpi
        remnote
        nautilus
        pkgs-unstable.presenterm
        inputs.todo-shell.defaultPackage.x86_64-linux
        eog
        nemo
        firefox
        libresprite
    ];

    imports = [
        ./common.nix
        ./hypr/default.nix
        ./ctf.nix
    ];

    home.shellAliases = {
        nrs = "sudo nixos-rebuild switch --flake /home/marc/dotfiles#black";
        nrt = "sudo nixos-rebuild test --flake /home/marc/dotfiles#black";
        aoc = "cd ~/dev/adventofcode/Python/2024 && nix develop";
        gs = "git status";
    };


    home.username = "marc";
    home.homeDirectory = "/home/marc";

    programs.home-manager.enable = true;

    programs.bash.enable = true;
    home.stateVersion = "24.05";

    programs.gh.enable = true;

    programs.zsh = {
        enable = true;
        enableCompletion = true;
        initExtra = ''
            export PATH="$HOME/.cargo/bin:$PATH"
            if command -v tmux &> /dev/null && [ -z "$TMUX" ]; then
                tmux new
                    fi
                    set bell-style none
        '';
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
