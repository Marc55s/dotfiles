{ config, lib, pkgs, ... }:

let
  davinci-wrapped = pkgs.symlinkJoin {
    name = "davinci-resolve-wrapped";
    paths = [ pkgs.davinci-resolve ];
    nativeBuildInputs = [ pkgs.makeWrapper ];
    postBuild = ''
      wrapProgram $out/bin/davinci-resolve \
        --set RUSTICL_ENABLE radeonsi \
        --set QT_QPA_PLATFORM xcb
    '';
  };
in
{
  hardware.graphics = {
    enable = true;
    extraPackages = with pkgs; [ mesa.opencl ];
  };

  home-manager.users.marc = { pkgs, ... }: {
    home.packages = [ davinci-wrapped pkgs.ffmpeg];
  };
}
