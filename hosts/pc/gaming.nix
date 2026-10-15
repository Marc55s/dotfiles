{ pkgs, config, ... }: {

  # Gaming
  hardware.graphics = {
    enable = true;
    enable32Bit = true;
    extraPackages =
      [ pkgs.vulkan-loader pkgs.vulkan-tools pkgs.vulkan-validation-layers ];
  };

  zramSwap.enable = true;
  zramSwap.priority = 100;

  services.lact.enable = true;

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
    RADV_PERFTEST = "aco,sam";
  };

  powerManagement = {
    enable = true;
    cpuFreqGovernor = "schedutil";
  };

}
