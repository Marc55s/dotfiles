{config, pkgs, pkgs-unstable, inputs,  ... }: {

    home.packages = with pkgs; [ 
        lua-language-server
        spotify
        vscode
        hyprpaper
        hypridle
        hyprshot
        hyprpicker
        hyprsunset
        pkgs-unstable.obsidian
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
        superfile
        neofetch
        nautilus
        texliveFull
        imagemagick
        tree-sitter-grammars.tree-sitter-latex
        tree-sitter
        ghostscript
        whatsapp-for-linux
        nil
        pylyzer
        pyright
        pkgs-unstable.presenterm
    ];

    imports = [
        inputs.textfox.homeManagerModules.default
        ./rofi/rofi.nix
        ./kitty/kitty.nix
        ./starship/starship.nix
        ./tmux.nix
        ./hypr/default.nix
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
