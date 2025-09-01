{ config, pkgs, inputs, ... }: {
  services.wpaperd = {
    enable = true;
    settings = {
      eDP-1 = {
        path = "~/dotfiles/wallpaper/";
        # duration = "5m";
        # sorting = "random";
        # apply-shadow = true;
      };
    };
  };
}
