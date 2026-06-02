{ pkgs, config, ... }: {

  # Gaming
  hardware.graphics = {
    enable = true;
    enable32Bit = true;
    extraPackages =
      [ pkgs.vulkan-loader pkgs.vulkan-tools pkgs.vulkan-validation-layers ];
  };
  environment.systemPackages = [ pkgs.lact ];
  # systemd.services.lactd = {
  #   enable = true;
  #   description = "AMDGPU Control Daemon";
  #   after = [ "multi-user.target" ];
  #   wantedBy = [ "multi-user.target" ];
  #   serviceConfig = {
  #     ExecStart = "${pkgs.lact}/bin/lact daemon";
  #     Restart = "on-failure";
  #   };
  # };

  zramSwap.enable = true;
  zramSwap.priority = 100;

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
      libxcursor
      libxi
      libxinerama
      libXScrnSaver
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
    # VK_ICD_FILENAMES = "/run/opengl-driver/share/vulkan/icd.d/radeon_icd.x86_64.json:/run/opengl-driver-32/share/vulkan/icd.d/radeon_icd.i686.json";
    AMD_DEBUG = "high_performance,null_fifo";
    vblank_mode = "0";
  };

  powerManagement = {
    enable = true;
    cpuFreqGovernor = "schedutil";
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
            libxcomposite
            libxext
            libx11
            libxau
            libxcb
            libxdmcp
            libxfixes
            libxrandr
            libxrender
            libxxf86vm
            libxshmfence

            # 32-bit libraries
            pkgsi686Linux.keyutils
            pkgsi686Linux.libkrb5
            pkgsi686Linux.libpng
            pkgsi686Linux.libpulseaudio
            pkgsi686Linux.libvorbis
            pkgsi686Linux.stdenv.cc.cc
            pkgsi686Linux.vulkan-loader
            pkgsi686Linux.libxcomposite
            pkgsi686Linux.libxext
            pkgsi686Linux.libx11
            pkgsi686Linux.libxau
            pkgsi686Linux.libxcb
            pkgsi686Linux.libxdmcp
            pkgsi686Linux.libxfixes
            pkgsi686Linux.libxrandr
            pkgsi686Linux.libxrender
            pkgsi686Linux.libxxf86vm
            pkgsi686Linux.libxshmfence

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
