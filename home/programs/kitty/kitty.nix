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
      background_opacity = if isLaptop then 1 else 0.9;
      enable_audio_bell = "no";
    };

    extraConfig = ''include themes/gruvbox_dark.conf'';
  };

  home.file.".config/kitty/themes" = {
    source = ./themes;
    recursive = true;
  };

  home.packages = with pkgs; [
    jetbrains-mono
  ];
}
