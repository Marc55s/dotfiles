{config, pkgs, pkgs-unstable, inputs,  ... }: {

    home.packages = with pkgs; [ 
        btop
        sops
        age
    ];

    imports = [
        ./programs/kubernetes.nix
        ./programs/git.nix
    ];

    programs.zsh = {
        enable = true;
        enableCompletion = true;
    };

    home.username = "monolith";
    home.homeDirectory = "/home/monolith";

    programs.home-manager.enable = true;

    home.stateVersion = "24.11";
}
