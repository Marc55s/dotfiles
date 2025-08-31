{ config, hostName, pkgs, ... }:

let
  # Detect if on laptop or PC by system or hostname
  isLaptop = hostName == "laptop";
  fontSize = if isLaptop then 12 else 10;  # smaller font on PC
in {
  programs.kitty = {
    enable = true;

    settings = {
      font_family = "JetBrainsMono Nerd Font";
      font_size = fontSize;

      bold_font = "auto";
      italic_font = "auto";
      bold_italic_font = "auto";

      # background_blur = 10;
      confirm_os_window_close =  0;
      background_opacity = 1;
      enable_audio_bell = "no";
    };

    extraConfig = if  isLaptop then ''include themes/gruvbox.conf'' else ''include themes/Kanagawa.conf'';
  };

  home.file.".config/kitty/themes" = {
    source = ./themes;
    recursive = true;
  };

  home.packages = with pkgs; [
    jetbrains-mono
  ];
}
