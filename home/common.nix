{config, pkgs, pkgs-unstable, ...}:
{
    imports = [
        ./ctf.nix
        ./programs/zoxide.nix
        ./programs/kitty/kitty.nix
        ./programs/starship/starship.nix
        ./programs/rofi/rofi.nix
        ./programs/tmux.nix
        ./programs/zathura.nix
        ./programs/nvim.nix
        ./programs/git.nix
        ./programs/direnv.nix
        ./programs/zsh.nix
        ./programs/bat.nix
        ./programs/television.nix
        ./programs/ncspot.nix
    ];

    home.packages = with pkgs; [ 
        lazygit
        lazydocker
        nitch
        neofetch
        btop
        nnn # File explorer
        fzf
        tree
        fd
        unzip

        zapzap
        pkgs-unstable.obsidian
        bitwarden
        vesktop
        discord
        element-desktop
        vlc
        edu-sync-cli
        libreoffice

        texliveFull
        imagemagick
        ghostscript
        nerd-fonts.jetbrains-mono
        ripgrep
        jetbrains.clion
    ];
}
