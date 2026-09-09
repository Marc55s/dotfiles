{ inputs, ... }:
{
  imports = [ inputs.stylix.homeModules.stylix ];

  stylix = {
    enable = true;
    polarity = "dark";
    base16Scheme = ./hull.yaml;

    image = ../wallpaper/Aleph2.jpg;

    targets = {
      neovim.enable = false;
      rofi.enable = false;

      kitty.enable = true;
      noctalia-shell.enable = true;
      firefox = {
        enable = true;
        profileNames = [ "default" ];
        colorTheme.enable = true;
      };
    };
  };
}
