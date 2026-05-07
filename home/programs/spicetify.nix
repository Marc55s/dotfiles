{ pkgs, inputs, ... }: {
  imports = [ inputs.spicetify-nix.homeManagerModules.default ];

  programs.spicetify = {
    enable = true;
    enabledExtensions = with pkgs.spicePkgs.extensions; [
      fullAppDisplay
      shuffle
    ];
    theme = pkgs.spicePkgs.themes.catppuccin;
    colorScheme = "mocha";
  };
}
