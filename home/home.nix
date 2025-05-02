{config, pkgs, pkgs-unstable, inputs,  ... }: {

    home.packages = with pkgs; [ 
        # rustc
        # cargo
        # rustfmt
        # clippy        
        # spotify
        # vscode
        # hyprpaper
        # hypridle
        # hyprshot
        # hyprpicker
        # hyprsunset
        # pkgs-unstable.obsidian
        # libgtop
        # libnotify
        # dart-sass
        # ags
        # gnome-bluetooth
        # bluez
        # bluez-tools
        btop
        # upower
        # acpi
        # lazygit
        # lazydocker
        nitch
        # neofetch
        # remnote
        # bitwarden
        vesktop
        (discord.override {
            # withOpenASAR = true; # can do this here too
            withVencord = true;
        })
        nnn # File explorer
        # nautilus
        # texliveFull
        # imagemagick
        # ghostscript
        # whatsapp-for-linux
        # pkgs-unstable.presenterm
        # inputs.todo-shell.defaultPackage.x86_64-linux
        # eog
        # nemo
        # firefox
        # libresprite
    ];

    imports = [
        ./rofi/rofi.nix
        ./kitty/kitty.nix
        ./starship/starship.nix
        ./tmux.nix
        ./hypr/default.nix
        ./ctf.nix
        ./zathura.nix
        ./nvim.nix
    ];

    home.shellAliases = {
        nrs = "sudo nixos-rebuild switch --flake /home/mc/dotfiles#";
        nrt = "sudo nixos-rebuild test --flake /home/mc/dotfiles#";
        aoc = "cd ~/dev/adventofcode/Python/2024 && nix develop";
        gs = "git status";
    };


    home.username = "mc";
    home.homeDirectory = "/home/mc";

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
}
