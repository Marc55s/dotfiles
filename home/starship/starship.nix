{config, pkgs, ...}:
{
    programs.starship = {
        enable = true;
        settings = pkgs.lib.importTOML ./pure-preset.toml;
        enableZshIntegration = true;
    };
}
