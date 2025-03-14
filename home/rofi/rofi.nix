{ pkgs, config, ... }:

let
    # Define mkLiteral outside of the theme block
    inherit (config.lib.formats.rasi) mkLiteral;
in {
    imports = [
        ./powermenu/power.nix
    ];
    programs.rofi = {
        enable = true;
        extraConfig = {
            modi = "drun,run";
            show-icons = true;
            font = "CaskaydiaCove Nerd Font 18";
            display-drun = "Apps";
            display-run = "Run";
        };

        theme = {
            "*" = {
                # Define color variables for easy customization
                bg-col = mkLiteral "#000000";
                bg-col-light = mkLiteral "#303446";
                border-col = mkLiteral "#303446";
                selected-col = mkLiteral "#303446";
                blue = mkLiteral "#8caaee";
                fg-col = mkLiteral "#c6d0f5";
                fg-col2 = mkLiteral "#e78284";
                grey = mkLiteral "#737994";

                width = mkLiteral "600";
                font = "JetBrainsMono Nerd Font 14"; # Custom font
            };

            "element-text, element-icon , mode-switcher" = {
                background-color = mkLiteral "inherit";
                text-color = mkLiteral "inherit";

            };

            "window" =  {
                height = mkLiteral "360px";
                border = mkLiteral "3px";
                border-color = mkLiteral "@border-col";
                background-color = mkLiteral "@bg-col";
            };

            "mainbox" = {
                background-color= mkLiteral "@bg-col";
            };

            "inputbar" = {
                children = mkLiteral "[prompt,entry]";
                background-color = mkLiteral "@bg-col";
                border-radius = mkLiteral "5px";
                padding = mkLiteral "2px";
            };

            "prompt" = {
                background-color = mkLiteral "@blue";
                padding = mkLiteral "6px";
                text-color = mkLiteral "@bg-col";
                border-radius = mkLiteral "3px";
                margin = mkLiteral "20px 0px 0px 20px";
            };

            "textbox-prompt-colon" = {
                expand = mkLiteral "false";
                str = ":";
            };

            "entry" = {
                padding = mkLiteral "6px";
                margin = mkLiteral "20px 0px 0px 10px";
                text-color = mkLiteral "@fg-col";
                background-color = mkLiteral "@bg-col";
            };

            "listview" = {
                border = mkLiteral "0px 0px 0px";
                padding = mkLiteral "6px 0px 0px";
                margin = mkLiteral "10px 0px 0px 20px";
                columns = "mkLiteral 2";
                lines = "mkLiteral 5";
                background-color = mkLiteral "@bg-col";
            };

            "element" = {
                padding = mkLiteral "5px";
                background-color = mkLiteral "@bg-col";
                text-color = mkLiteral "@fg-col  ";
            };

            "element-icon" = {
                size = mkLiteral "25px";
            };

            "element selected" = {
                background-color = mkLiteral  "@selected-col ";
                text-color = mkLiteral "@fg-col2  ";
            };

            "mode-switcher" = {
                spacing = mkLiteral "0";
            };

            "button" = {
                padding = mkLiteral "10px";
                background-color = mkLiteral "@bg-col-light";
                text-color = mkLiteral "@grey";
                vertical-align = mkLiteral "0.5"; 
                horizontal-align = mkLiteral "0.5";
            };

            "button selected" = {
                background-color = mkLiteral "@bg-col";
                text-color = mkLiteral "@blue";
            };

            "message" = {
                background-color = mkLiteral "@bg-col-light";
                margin = mkLiteral "2px";
                padding = mkLiteral "2px";
                border-radius = mkLiteral "5px";
            };

            "textbox" = {
                padding = mkLiteral "6px";
                margin = mkLiteral "20px 0px 0px 20px";
                text-color = mkLiteral "@blue";
                background-color = mkLiteral "@bg-col-light";
            };
        };
    };
}
