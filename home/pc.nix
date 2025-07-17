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
        libresprite
        pinta
        chatterino7
        libreoffice
        spotify
    ];

    imports = [
        ./common.nix
    ];

    home.shellAliases = {
        nrs = "sudo nixos-rebuild switch --flake /home/marc/dotfiles#pc";
        nrt = "sudo nixos-rebuild test --flake /home/marc/dotfiles#pc";
        aoc = "cd ~/dev/adventofcode/Python/2024 && nix develop";
        gs = "git status";
        gl = "git log --oneline";
    };

    home.username = "marc";
    home.homeDirectory = "/home/marc";

    programs.home-manager.enable = true;

    programs.bash.enable = true;
    home.stateVersion = "24.11";
}
