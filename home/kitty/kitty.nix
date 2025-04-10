{ config, pkgs, ... }:

{
    programs.kitty = {
        enable = true;

        settings = {
            font_family = "JetBrainsMono Nerd Font";
            bold_font = "auto";
            italic_font = "auto";
            bold_italic_font = "auto";

            font_size = 14;
            #cursor_trail = 1;

            
            #background_opacity = "0.5";
            background_blur = 10;
            enable_audio_bell = "no";
        };
        
        extraConfig = ''include themes/gruvbox_dark.conf'';

    };

    home.file.".config/kitty/themes" = {
        source = ./themes;
        recursive = true;
    };

    home.packages = with pkgs; [
        jetbrains-mono # Ensure the font is installed
    ];

}
