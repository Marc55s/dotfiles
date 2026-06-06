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

}
