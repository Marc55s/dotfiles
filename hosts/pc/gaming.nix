{ pkgs, config, ... }: {

  # Gaming
  hardware.graphics = {
    enable = true;
    enable32Bit = true;
    extraPackages =
      [ pkgs.vulkan-loader pkgs.vulkan-tools pkgs.vulkan-validation-layers ];
  };

  zramSwap.enable = true;

  programs.steam = {
    enable = true;
    remotePlay.openFirewall = true;
    dedicatedServer.openFirewall = true;
    localNetworkGameTransfers.openFirewall = true;
    gamescopeSession.enable = false;
    extest.enable = true;
    extraPackages = with pkgs; [
      gamescope
      mangohud
      xorg.libXcursor
      xorg.libXi
      xorg.libXinerama
      xorg.libXScrnSaver
      libpng
      libpulseaudio
      libvorbis
      stdenv.cc.cc.lib
      libkrb5
      keyutils
    ];
  };

  programs.gamemode.enable = true;

  environment.sessionVariables = {
    # Force RADV (AMD) instead of LLVMPIPE
    RADV_PERFTEST = "aco,sam";
    AMD_VULKAN_ICD = "RADV";
    VK_ICD_FILENAMES =
      "/run/opengl-driver/share/vulkan/icd.d/radeon_icd.x86_64.json:/run/opengl-driver-32/share/vulkan/icd.d/radeon_icd.i686.json";
    AMD_DEBUG = "high_performance,null_fifo";
    vblank_mode = "0";
  };

  powerManagement = {
    enable = true;
    cpuFreqGovernor = "performance";
  };


  nixpkgs.overlays = [
    (self: super: {
      lutris = super.lutris.override {
        extraLibraries = pkgs:
          with pkgs; [
            # 64-bit libraries
            keyutils
            libkrb5
            libpng
            libpulseaudio
            libvorbis
            stdenv.cc.cc
            vulkan-loader
            xorg.libXcomposite
            xorg.libXext
            xorg.libX11
            xorg.libXau
            xorg.libxcb
            xorg.libXdmcp
            xorg.libXfixes
            xorg.libXrandr
            xorg.libXrender
            xorg.libXxf86vm
            xorg.libxshmfence

            # 32-bit libraries
            pkgsi686Linux.keyutils
            pkgsi686Linux.libkrb5
            pkgsi686Linux.libpng
            pkgsi686Linux.libpulseaudio
            pkgsi686Linux.libvorbis
            pkgsi686Linux.stdenv.cc.cc
            pkgsi686Linux.vulkan-loader
            pkgsi686Linux.xorg.libXcomposite
            pkgsi686Linux.xorg.libXext
            pkgsi686Linux.xorg.libX11
            pkgsi686Linux.xorg.libXau
            pkgsi686Linux.xorg.libxcb
            pkgsi686Linux.xorg.libXdmcp
            pkgsi686Linux.xorg.libXfixes
            pkgsi686Linux.xorg.libXrandr
            pkgsi686Linux.xorg.libXrender
            pkgsi686Linux.xorg.libXxf86vm
            pkgsi686Linux.xorg.libxshmfence

            # GStreamer and its plugins (both 64 and 32-bit)
            gst_all_1.gstreamer
            gst_all_1.gst-plugins-base
            gst_all_1.gst-plugins-good
            gst_all_1.gst-plugins-bad
            gst_all_1.gst-plugins-ugly
            gst_all_1.gst-libav

            pkgsi686Linux.gst_all_1.gstreamer
            pkgsi686Linux.gst_all_1.gst-plugins-base
            pkgsi686Linux.gst_all_1.gst-plugins-good
            pkgsi686Linux.gst_all_1.gst-plugins-bad
            pkgsi686Linux.gst_all_1.gst-plugins-ugly
            pkgsi686Linux.gst_all_1.gst-libav

            # Specific libraries mentioned in your errors
            pkgsi686Linux.libgudev # fixes "libgudev-1.0.so.0" error
            pkgsi686Linux.speex # fixes "libspeex.so.1" error
            pkgsi686Linux.libtheora # fixes "libtheoradec.so.1" error
            pkgsi686Linux.openal # fixes "libopenal.so.1" error
            pkgsi686Linux.libvdpau # fixes "libvdpau.so.1" error
          ];
      };
    })
  ];
}
