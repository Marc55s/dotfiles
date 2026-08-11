{ config, hostName, pkgs, ... }:

let
  # Detect if on laptop or PC by system or hostname
  isLaptop = hostName == "laptop";
  fontSize = if isLaptop then 14 else 13;  # smaller font on PC
in {
  programs.kitty = {
    enable = true;

    settings = {
      font_family = "Jetbrains Mono Nerd Font";
      font_size = fontSize;

      bold_font = "auto";
      italic_font = "auto";
      bold_italic_font = "auto";

      # background_blur = 10;
      confirm_os_window_close =  0;
      background_opacity = 1;
      enable_audio_bell = "no";
    };

    extraConfig = ''
      modify_font cell_height 95%
      # modify_font baseline 2
      modify_font cell_width 100%

      include themes/${if isLaptop then "gruvbox" else "Tango_dark"}.conf
    '';
  };

  home.file.".config/kitty/themes" = {
    source = ./themes;
    recursive = true;
  };

  home.packages = with pkgs; [
    jetbrains-mono
  ];
}
