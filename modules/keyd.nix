{
  services.keyd = {
    enable = true;
    keyboards.default = {
      ids = [ "*" ];
      settings = {
        "control+alt" = {
          "7" = "G-7"; # {
          "8" = "G-8"; # [
          "9" = "G-9"; # ]
          "0" = "G-0"; # }
          "minus" = "G-minus"; # \  (ß key on DE)
          "q" = "G-q"; # @
          "rightbrace" = "G-rightbrace"; # ~
        };
      };
    };
  };
}
