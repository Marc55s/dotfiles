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
        theme = "gruvbox";

        layout = {
            "bar.layouts" = {
                "0" = {
                    left = ["dashboard" "workspaces" "windowtitle"];
                    middle = ["media"];
                    right = [
                        "network"
                        "volume"
                        "bluetooth"
                        "hyprsunset"
                        "battery"
                        "clock"
                        "notifications"
                    ];
                };
            };
        };

        settings = {

            bar = {
                launcher.autoDetectIcon = true;
                workspaces.show_icons = false;
                workspaces.show_numbered = true;
                clock.format = "%a %b %d  %H:%M";
                customModules.hyprsunset.temperature= "4000k";
            };

            menus.dashboard.powermenu.avatar.image = "~/dotfiles/wallpaper/nixos-wallpaper-catppuccin-mocha.png";
            menus = {
                clock = {
                    time = {
                        military = false;
                        hideSeconds= true;
                    };
                    weather = {
                        unit = "metric";
                    };
                };

                dashboard = {
                    directories.enabled = false;
                    shortcuts.enabled = true;
                };
            };

            wallpaper.enable = false;
            theme.bar.transparent = true;
            theme.font = {
                name = "CaskaydiaCove NF";
                size = "16px";
            };
        };
        override = {
            # "theme.bar.buttons.dashboard.icon" = "#89B4FB"; cattpuccing nix icon
            "theme.bar.buttons.dashboard.icon" = "#FABD2F";
            "theme.bar.background"= "#000203";
        };

    };
}
