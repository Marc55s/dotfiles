{config, pkgs, pkgs-unstable, inputs,  ... }: {

    home.packages = with pkgs; [ 
        # LSPs
        texlab
        lua-language-server
        nil
        pylyzer
        pyright

        spotify
        vscode
        hyprpaper
        hypridle
        hyprshot
        hyprpicker
        hyprsunset
        pkgs-unstable.obsidian
        libgtop
        libnotify
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
        neofetch
        remnote
        bitwarden
        vesktop
        (discord.override {
            # withOpenASAR = true; # can do this here too
            withVencord = true;
        })
        nnn # File explorer
        nautilus
        texliveFull
        imagemagick
        tree-sitter-grammars.tree-sitter-latex
        tree-sitter
        ghostscript
        whatsapp-for-linux
        pkgs-unstable.presenterm
        inputs.todo-shell.defaultPackage.x86_64-linux
        eog
        firefox
    ];

    imports = [
        ./rofi/rofi.nix
        ./kitty/kitty.nix
        ./starship/starship.nix
        ./tmux.nix
        ./hypr/default.nix
        ./ctf.nix
        ./zathura.nix
    ];

    home.shellAliases = {
        nrs = "sudo nixos-rebuild switch --flake /home/marc/dotfiles#";
        nrt = "sudo nixos-rebuild test --flake /home/marc/dotfiles#";
        aoc = "cd ~/dev/adventofcode/Python/2024 && nix develop";
        gs = "git status";
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
        enable = true;
        defaultEditor = true;
        vimAlias = true;
        viAlias = true;
        package = pkgs-unstable.neovim.unwrapped;
        plugins = with pkgs.vimPlugins; [
            # ... your other plugins
            (nvim-treesitter.withPlugins (_: nvim-treesitter.allGrammars ++ [
                (pkgs.tree-sitter.buildGrammar {
                    language = "just";
                    version = "8af0aab";
                    src = pkgs.fetchFromGitHub {
                        owner = "IndianBoy42";
                        repo = "tree-sitter-just";
                        rev = "8af0aab79854aaf25b620a52c39485849922f766";
                        sha256 = "sha256-hYKFidN3LHJg2NLM1EiJFki+0nqi1URnoLLPknUbFJY=";
                    };
                })
            ]))
        ];
    };

    programs.gh.enable = true;

    programs.zsh = {
        enable = true;
        enableCompletion = true;
        initExtra = ''
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
        gtk4.extraConfig = {
            gtk-application-prefer-dark-theme = 1;
        };
    };
}
