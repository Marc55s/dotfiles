{ pkgs, inputs, ... }:
{

    home.packages = with pkgs;[
        wireplumber
        gvfs
    ];
    imports = [ inputs.hyprpanel.homeManagerModules.hyprpanel ];
    programs.hyprpanel = {
        enable = true;
        overlay.enable = true;
        overwrite.enable = true;
        theme = "catppuccin_mocha";
        settings = {
            bar.launcher.autoDetectIcon = true;
            bar.workspaces.show_icons = false;
            bar.workspaces.show_numbered = true;

            menus.clock = {

                time = {
                    military = false;
                    hideSeconds = true;
                };
                weather = {
                    unit = "metric";
                };
            };

            menus.dashboard.directories.enabled = false;
            wallpaper.enable = false;
            theme.bar.transparent = true;

            theme.font = {
                name = "CaskaydiaCove NF";
                size = "18px";
            };
        };
    };
}
