{ inputs, ... }:
{
  imports = [ inputs.stylix.homeModules.stylix ];

  stylix = {
    enable = true;
    polarity = "dark";

    # Single source of truth for colors: the hand-derived "hull" base16 palette.
    # NOT wallpaper-generated. Do not remove base16Scheme.
    base16Scheme = ./hull.yaml;

    # Pinned wallpaper (drives the desktop + Stylix's Noctalia wallpaper cache).
    # Colors still come from base16Scheme above, NOT generated from this image.
    image = ../wallpaper/Aleph2.jpg;

    # Global theming (autoEnable = true by default) applies the palette to every
    # supported program that is enabled, except the ones disabled below.
    targets = {
      # neovim keeps its own colorscheme.
      neovim.enable = false;

      # rofi has a fully hand-crafted rasi theme (home/programs/rofi/rofi.nix)
      # whose selectors reference its own @vars, so Stylix can't recolor it
      # without a rewrite -- it only collides (theme."*".blue etc). Disabled.
      # To put rofi on the hull palette, port the rasi to Stylix's color vars.
      rofi.enable = false;

      # Explicitly requested targets.
      kitty.enable = true;
      noctalia-shell.enable = true;
      firefox = {
        enable = true;
        # Real Firefox profile (programs.firefox profiles.default -> name "default").
        profileNames = [ "default" ];
        # Recolor the chrome with the hull palette via the Firefox Color addon
        # (a lightweight theme) -- keeps Firefox's NATIVE tab/toolbar layout.
        # (firefoxGnomeTheme was dropped: it forced a GNOME tab layout.)
        # Needs the default theme active -> praisethesun pins removed in
        # home/programs/firefox.nix.
        colorTheme.enable = true;
      };
    };
  };
}
