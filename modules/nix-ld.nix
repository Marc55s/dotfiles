{ config, pkgs, ... }:
{
  programs.nix-ld.enable = true;
  programs.nix-ld.libraries = with pkgs; [
        stdenv.cc.cc
        stdenv.cc.cc.lib
        zlib
        glfw
        openssl
        glibc
        libGL
        libxkbcommon
        xorg.libX11
        xorg.libXcursor
        xorg.libXrandr
        xorg.libXi
        xorg.libXxf86vm
        wayland
    ];
}
