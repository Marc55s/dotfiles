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
        pkgs-unstable.jetbrains.clion
        pinta
        pkgs-unstable.chatterino7
        libreoffice
    ];

    imports = [
        ./common.nix
        ./spicetify.nix
        inputs.spicetify-nix.homeManagerModules.spicetify
    ];

    home.shellAliases = {
        nrs = "sudo nixos-rebuild switch --flake /home/marc/dotfiles#white";
        nrt = "sudo nixos-rebuild test --flake /home/marc/dotfiles#white";
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
