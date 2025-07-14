{config, pkgs, pkgs-unstable, ...}:
{
    imports = [
        ./zoxide.nix
        ./kitty/kitty.nix
        ./starship/starship.nix
        ./rofi/rofi.nix
        ./tmux.nix
        ./zathura.nix
        ./nvim.nix
        ./git.nix
        ./direnv.nix
        ./zsh.nix
        ./bat.nix
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

        whatsapp-for-linux
        pkgs-unstable.obsidian
        bitwarden
        vesktop
        discord
        element-desktop

        texliveFull
        imagemagick
        ghostscript
        nerd-fonts.jetbrains-mono
        ripgrep
        pkgs-unstable.jetbrains.clion
    ];
}
