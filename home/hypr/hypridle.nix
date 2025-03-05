{
    services.hypridle = {
        enable = true;
        settings = {
            # General configuration
            general = {
                lock_cmd = "pidof hyprlock || hyprlock"; # Avoid starting multiple hyprlock instances.
                before_sleep_cmd = "loginctl lock-session"; # Lock before suspend.
                after_sleep_cmd = "hyprctl dispatch dpms on"; # Avoid having to press a key twice to turn on the display.
            };

            # Listener 1: Notify before locking
            listener = [
                {
                    timeout = 270; # 9.5 minutes
                    on-timeout = "notify-send 'locking in 30s...'";
                }

                # Listener 2: Lock screen after timeout
                {
                    timeout = 600; # 10 minutes
                    on-timeout = "loginctl lock-session"; # Lock screen when timeout has passed
                }

                # Listener 3: Turn off screen after timeout
                {
                    timeout = 300; # 5 minutes
                    on-timeout = "hyprctl dispatch dpms off"; # Screen off when timeout has passed
                    on-resume = "hyprctl dispatch dpms on"; # Screen on when activity is detected after timeout has fired.
                }
            ];
        };
    };
}
