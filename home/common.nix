{config, pkgs, pkgs-unstable, inputs, ...}:
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
        # ./programs/television.nix
        ./programs/ncspot.nix
        ./programs/fzf.nix
        ./programs/presenterm.nix
        ./programs/termstat.nix
        ./programs/yazi.nix
        ./programs/nh.nix
        inputs.termstat.homeManagerModules.default
    ];

    home.packages = with pkgs; [ 
        lazygit
        lazydocker
        lazysql
        nitch
        neofetch
        tree
        fd
        unzip
        jq
        tdf # tui pdf viewer

        signal-desktop
        zapzap
        pkgs-unstable.obsidian
        bitwarden-desktop
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
        cr = "cargo r";
        cb = "cargo b";
        gs = "git status";
        gl = "git log --oneline";
        gll = "git log";
        gd = "git diff";
        gc = "git commit";
        nd = "nix develop";
        nos = "nh os switch";
    };
}
