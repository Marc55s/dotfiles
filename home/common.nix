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
        ./programs/fzf.nix
        ./programs/nnn.nix
    ];

    home.packages = with pkgs; [ 
        lazygit
        lazydocker
        lazysql
        nitch
        neofetch
        btop
        tree
        fd
        unzip
        mermaid-cli
        gh

        zapzap
        pkgs-unstable.obsidian
        bitwarden
        vesktop
        element-desktop
        vlc
        edu-sync-cli
        libreoffice
        gimp
        postman

        texliveFull
        imagemagick
        ghostscript
        nerd-fonts.jetbrains-mono
        ripgrep
        openconnect-sso
        timr-tui
    ];

    home.shellAliases = {
        dps = ''docker ps --format "{{.Names}} -> {{.Ports}}"''; 
        dhbw-vpn = "openconnect-sso --server vpn.dhbw-heidenheim.de --authgroup Studenten+Externe-MFA";
    };
}
