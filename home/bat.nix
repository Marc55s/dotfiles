{pkgs, ...}:
{

    programs.bat = {
        enable = true;
    };

    home.shellAliases = {
        cat = "bat --theme=gruvbox-dark";
    };
}
