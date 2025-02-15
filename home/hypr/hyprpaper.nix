{
    services.hyprpaper = {
        enable = true;
        settings = {
            # Variables
            "$wallpaper" = "~/dotfiles/wallpaper/greenbus.jpg";

            # Preload the wallpaper
            preload = "$wallpaper";

            # Set wallpapers for each monitor
            wallpaper = [
                "eDP-1, $wallpaper"
                "DVI-I-1, $wallpaper"
                "DVI-I-2, $wallpaper"
            ];
        };
    };
}
