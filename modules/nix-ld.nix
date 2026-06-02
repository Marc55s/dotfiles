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
        vulkan-loader
        vulkan-tools
        libx11
        libxcursor
        libxrandr
        libxi
        libxxf86vm
        wayland
    ];
}
