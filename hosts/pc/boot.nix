{pkgs, config, ...}:
{
  boot.initrd.systemd.enable = true;
  boot.initrd.luks.devices."cryptroot".device =
    "/dev/disk/by-uuid/b9fb3b65-bc59-48f7-8f31-94b5e60e0d16";
  boot.initrd.luks.devices."cryptroot".preLVM = true;
  networking.hostId = "c5a47126";
  boot.zfs.devNodes = "/dev/mapper";
  boot.zfs.extraPools = [ "zroot" ];
  boot.zfs.requestEncryptionCredentials = true;

    boot.kernelPackages = pkgs.linuxPackages_6_6;

  # Force high performance and prevent "Scatter/Gather" memory bugs on Navi 10
  boot.kernelParams = [
    "amdgpu.ppfeaturemask=0xffffffff"
    "amdgpu.runpm=0" # DISABLES Runtime Power Management entirely
    "amdgpu.dcfeaturemask=0x2" # Forces the display core to prioritize refresh rate over power
    "amdgpu.dcdebugmask=0x10"        # Disables PSR (Stops the FPS decay)
    "zfs.zfs_arc_max=4294967296"
  ];


  # Stop the service that is fighting your manual echo commands
  systemd.services.power-profiles-daemon.enable = false;

  boot.loader = {
    systemd-boot.enable = false;
    efi.canTouchEfiVariables = true;

    grub = {
      enable = true;
      efiSupport = true;
      zfsSupport = true;
      copyKernels = true;
      device = "nodev"; # required for UEFI systems
    };
  };
}
