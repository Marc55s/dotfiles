{
  boot.initrd.systemd.enable = true;
  boot.initrd.luks.devices."cryptroot".device = "/dev/disk/by-uuid/b9fb3b65-bc59-48f7-8f31-94b5e60e0d16";
  boot.initrd.luks.devices."cryptroot".preLVM = true;
  networking.hostId = "c5a47126";
  boot.zfs.devNodes = "/dev/mapper";
  boot.zfs.extraPools = [ "zroot" ];
  boot.zfs.requestEncryptionCredentials = true;

  # Bootloader.
  # boot.kernelPackages = pkgs.linuxPackages_zen;
  boot.kernelParams = [ "zfs.zfs_arc_max=4294967296" ]; # Limits ZFS to 4GB
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
