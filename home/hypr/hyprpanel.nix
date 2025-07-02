{ pkgs, ... }:
    let 
        theme = builtins.fromJSON (builtins.readFile ./gruvbox.json);
    in {
    programs.hyprpanel = {
        enable = true;
        settings = {
            bar.layouts = {
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

            bar.launcher.autoDetectIcon = true;
            bar.workspaces.show_icons = false;
            bar.workspaces.show_numbered = true;
            bar.clock.format = "%a %b %d  %H:%M";
            bar.customModules.hyprsunset.temperature= "4000k";

            menus.clock.time.military = false;
            menus.clock.time.hideSeconds = true;
            menus.clock.weather.unit = "metric";
            menus.dashboard.directories.enabled = false;
            menus.dashboard.shortcuts.enabled = true;
            menus.dashboard.powermenu.avatar.image = "~/dotfiles/wallpaper/nixos-wallpaper-catppuccin-mocha.png";

            wallpaper.enable = false;
            theme = theme;
        };
        systemd.enable = true;
    };
}
