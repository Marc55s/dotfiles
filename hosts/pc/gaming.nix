{ pkgs, config, ... }: {

  # Gaming
  hardware.graphics = {
    enable = true;
    enable32Bit = true;
    extraPackages =
      [ pkgs.vulkan-loader pkgs.vulkan-tools pkgs.vulkan-validation-layers ];
  };

  swapDevices = [{
    device = "/var/lib/swapfile";
    size = 16*1024; # 16 GB
  }];

  services.lact.enable = true;

  environment.sessionVariables = {
    # RADV_PERFTEST = "aco,sam";
    # AMD_VULKAN_ICD = "RADV";
    # AMD_DEBUG = "high_performance,null_fifo"; 
    # vblank_mode = "0";
  };

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


  powerManagement = {
    enable = true;
    cpuFreqGovernor = "schedutil";
  };

}
