{config, pkgs, ...}:
{
    programs.starship = {
        enable = true;
        settings = pkgs.lib.importTOML ./nerd-font-symbols.toml;
        enableZshIntegration = true;
    };
}
