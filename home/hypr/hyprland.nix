{
    wayland.windowManager.hyprland = {
        xwayland.enable = true;
        enable = true;
        settings = {
            source = "~/.config/hypr/monitors.conf";
            "$mainMod" = "SUPER";
            "$terminal" = "kitty";
            "$fileManager" = "nemo";
            "$menu" = "rofi -show drun";
            "$lock" = "hyprlock";
            "$powermenu" = "~/.config/rofi/power.sh";

            monitor = [
                "eDP-1, highres, auto, 1"
            ];

            exec-once = [
                "nm-applet"
                "hypridle"
                "swaync"
            ];

            general =  { 
                gaps_in = 5;
                gaps_out = 10;
                border_size = 3;

                "col.active_border" = "rgba(fefefeaa)"; # rgba(8aadf4cc) 45deg";
                # "col.inactive_border"= "rgba(591959aa)";
                resize_on_border = false;
                allow_tearing = false;
                layout = "dwindle";
            };
            decoration = {
                rounding = 0;
                active_opacity = 1.0;
                inactive_opacity = 1.0;
                blur = {
                    enabled = false;
                    size = 3;
                    passes = 1;
                    vibrancy = 0.1696;
                };
            };
            animations = {
                enabled = true;
                bezier = "myBezier, 0.05, 0.9, 0.1, 1.05";
                animation = [
                    "windows, 1, 7, myBezier"
                    "windowsOut, 1, 7, default, popin 80%"
                    "border, 1, 10, default"
                    "borderangle, 1, 8, default"
                    "fade, 1, 7, default"
                    "workspaces, 1, 6, default"
                ];
            };

            input = {
                kb_layout = "de";
                kb_options ="ctrl:nocaps"; 
                follow_mouse = 1;

                sensitivity = 0.4; # -1.0 - 1.0, 0 means no modification.

                touchpad ={
                    natural_scroll = true ;
                };
                repeat_delay = 400;
            };

            dwindle= {
                pseudotile = true; # Master switch for pseudotiling. Enabling is bound to mainMod + P in the keybinds section below
                preserve_split = true; # You probably want this
            };

            # See https://wiki.hyprland.org/Configuring/Master-Layout/ for more
            master =  {
                new_status = "master";
            };

            # https://wiki.hyprland.org/Configuring/Variables/#misc
            misc = { 
                force_default_wallpaper =  0; # Set to 0 or 1 to disable the anime mascot wallpapers
                disable_hyprland_logo = true; # If true disables the random hyprland logo / anime girl background. :(
            };
            cursor =  {
                persistent_warps = false;
                hide_on_key_press = true;
            };

            gestures =  {
                gesture = "3, horizontal, workspace";
            };
            device = {
                name = "epic-mouse-v1";
                #sensitivity = -0.5
            };

            bind = [
                "$mainMod, Q, exec, $terminal"
                "$mainMod, B, exec, $powermenu"
                "$mainMod, C, killactive,"
                "$mainMod, M, exit,"
                "$mainMod, E, exec, $fileManager"
                "$mainMod, V, togglefloating,"
                "$mainMod, space, exec, $menu"
                "$mainMod, P, pseudo, # dwindle"
                "$mainMod, T, togglesplit, # dwindle"
                "$SUPER_SHIFT, space, togglefloating"
                "$mainMod, F, fullscreen,"
                "$SUPER_SHIFT, l, exec, $lock"

                ", F12, exec, hyprshot -m window"
                "$mainMod , F12, exec, hyprshot -m region"

                "$mainMod, h, movefocus, l"
                "$mainMod, j, movefocus, d"
                "$mainMod, k, movefocus, u"
                "$mainMod, l, movefocus, r"

                "$mainMod, 1, workspace, 1"
                "$mainMod, 2, workspace, 2"
                "$mainMod, 3, workspace, 3"
                "$mainMod, 4, workspace, 4"
                "$mainMod, 5, workspace, 5"
                "$mainMod, 6, workspace, 6"
                "$mainMod, 7, workspace, 7"
                "$mainMod, 8, workspace, 8"
                "$mainMod, 9, workspace, 9"
                "$mainMod, 0, workspace, 10"

                "$mainMod SHIFT, 1, movetoworkspace, 1"
                "$mainMod SHIFT, 2, movetoworkspace, 2"
                "$mainMod SHIFT, 3, movetoworkspace, 3"
                "$mainMod SHIFT, 4, movetoworkspace, 4"
                "$mainMod SHIFT, 5, movetoworkspace, 5"
                "$mainMod SHIFT, 6, movetoworkspace, 6"
                "$mainMod SHIFT, 7, movetoworkspace, 7"
                "$mainMod SHIFT, 8, movetoworkspace, 8"
                "$mainMod SHIFT, 9, movetoworkspace, 9"
                "$mainMod SHIFT, 0, movetoworkspace, 10"

                "$mainMod, S, togglespecialworkspace, magic"
                "$mainMod SHIFT, S, movetoworkspace, special:magic"
                "$mainMod, mouse_down, workspace, e+1"
                "$mainMod, mouse_up, workspace, e-1"

            ];

            bindm = [
                "$mainMod, mouse:272, movewindow"
                "$mainMod, mouse:273, resizewindow"
            ];

            bindel = [
                ",XF86AudioRaiseVolume, exec, wpctl set-volume @DEFAULT_AUDIO_SINK@ 5%+"
                ",XF86AudioLowerVolume, exec, wpctl set-volume @DEFAULT_AUDIO_SINK@ 5%-"
                ",XF86AudioMute, exec, wpctl set-mute @DEFAULT_AUDIO_SINK@ toggle"
                ",XF86AudioMicMute, exec, wpctl set-mute @DEFAULT_AUDIO_SOURCE@ toggle"
                ",XF86MonBrightnessUp, exec, brightnessctl s 10%+"
                ",XF86MonBrightnessDown, exec, brightnessctl s 10%-"
            ];

            windowrulev2 = "suppressevent maximize, class:.*";
        };
    };
}
