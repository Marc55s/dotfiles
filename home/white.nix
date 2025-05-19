{config, pkgs, pkgs-unstable, inputs,  ... }: {

    home.packages = with pkgs; [ 
        # rustc
        # cargo
        # rustfmt
        # clippy        
        # vscode
        pkgs-unstable.obsidian
        ncspot
        libva
        libvdpau
        btop
        lazygit
        nitch
        bitwarden
        vesktop
        discord
        nnn # File explorer
        fzf
        easyeffects
        obs-studio
        gcc
        texliveFull
        imagemagick
        ghostscript
        whatsapp-for-linux
        pkgs-unstable.presenterm
        # inputs.todo-shell.defaultPackage.x86_64-linux
        firefox
        tree
        # libresprite
        pkgs-unstable.jetbrains.clion
        pinta
        pkgs-unstable.chatterino7
    ];

    imports = [
        ./common.nix
        ./rofi/rofi.nix
        ./kitty/kitty.nix
        ./starship/starship.nix
        ./tmux.nix
        # ./ctf.nix
        ./zathura.nix
        ./nvim.nix
    ];


    home.shellAliases = {
        nrs = "sudo nixos-rebuild switch --flake /home/marc/dotfiles#white";
        nrt = "sudo nixos-rebuild test --flake /home/marc/dotfiles#white";
        aoc = "cd ~/dev/adventofcode/Python/2024 && nix develop";
        gs = "git status";
    };

    home.username = "marc";
    home.homeDirectory = "/home/marc";

    programs.home-manager.enable = true;

    programs.bash.enable = true;
    home.stateVersion = "24.11";

    programs.git = {
        enable = true;
        userEmail = "marc.schoenig@gmail.com";
        userName = "marc55s";
        extraConfig = {
            push.autoSetupRemote = true;
        };
    };

    programs.ripgrep.enable = true;

    # programs.gh.enable = true;

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
