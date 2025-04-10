{config, pkgs, ...}:
{
    programs.starship = {
        enable = true;
        settings = pkgs.lib.importTOML ./gruvbox-rainbow.toml;
        enableZshIntegration = true;
    };
}
