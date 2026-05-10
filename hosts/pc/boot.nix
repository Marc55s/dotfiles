{ pkgs, config, ... }: {
  boot.initrd.systemd.enable = true;
  boot.kernelPackages = pkgs.linuxPackages_6_6;

  # Force high performance and prevent "Scatter/Gather" memory bugs on Navi 10
  boot.kernelParams = [
    "amdgpu.ppfeaturemask=0xffffffff"
    "amdgpu.runpm=0" # DISABLES Runtime Power Management entirely
    "amdgpu.dcfeaturemask=0x2" # Forces the display core to prioritize refresh rate over power
    "amdgpu.dcdebugmask=0x10" # Disables PSR (Stops the FPS decay)
  ];

  # Stop the service that is fighting your manual echo commands
  systemd.services.power-profiles-daemon.enable = false;

  boot.loader = {
    systemd-boot.enable = false;
    efi.canTouchEfiVariables = true;

    grub = {
      enable = true;
      efiSupport = true;
      device = "nodev"; # required for UEFI systems
    };
  };
}
