{config, pkgs, pkgs-unstable, inputs,  ... }: {

    home.packages = with pkgs; [ 
        # vscode
        ncspot
        libva
        libvdpau
        easyeffects
        obs-studio
        gcc
        pkgs-unstable.presenterm
        # inputs.todo-shell.defaultPackage.x86_64-linux
        firefox
        # libresprite
        pkgs-unstable.jetbrains.clion
        pinta
        pkgs-unstable.chatterino7
        libreoffice
    ];

    imports = [
        ./common.nix
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

    programs.zsh = {
        enable = true;
        enableCompletion = true;
        initContent = ''
            export PATH="$HOME/.cargo/bin:$PATH"
            if command -v tmux &> /dev/null && [ -z "$TMUX" ]; then
                tmux new
                    fi
                    set bell-style none
        '';
    };

}
