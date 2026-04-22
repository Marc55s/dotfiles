{ lib, pkgs, pkgs-unstable, ... }: {
  imports =
    [
        ./disk.nix
        ./nginx.nix
        ./media/media.nix
        ./media/samba.nix
        ../../modules/local.nix
        ../../modules/ssh.nix
    ];

  boot.supportedFilesystems = [ "ntfs" ];
  boot.loader.grub = {
    enable = true;
    devices = lib.mkForce
      [ "/dev/disk/by-id/ata-Intenso_SSD_Sata_III_AA000000000000002795" ];
    efiSupport = false;
    device = lib.mkForce "nodev";
  };
  boot.loader.efi.canTouchEfiVariables = false;

  boot.loader.systemd-boot.enable = false;
  boot.kernelParams = [ "nomodeset" ];
  networking.hostName = "monolith";
  hardware.enableRedistributableFirmware = true;

  environment.systemPackages = (with pkgs; [ git vim curl ]);
  users.users.root.openssh.authorizedKeys.keys = [
    "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIDmMEHJkey2YR4q7pgJVcgq8mi3Wfu2rJnwnQiMAoLjW marc@pc"
    "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIBUBslv6CEeXw6xVnNi9AOvkpQh5k3eN/moHNKLxja87 marc@laptop"
  ];

  users = {
    users.monolith = {
      isNormalUser = true;
      description = "Monolith user";
      extraGroups = [ "networkmanager" "wheel" "docker" ];
      openssh.authorizedKeys.keys = [
        "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIDmMEHJkey2YR4q7pgJVcgq8mi3Wfu2rJnwnQiMAoLjW marc@pc"
        "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIBUBslv6CEeXw6xVnNi9AOvkpQh5k3eN/moHNKLxja87 marc@laptop"
      ];
    };
  };

  security.sudo.wheelNeedsPassword = false;
  nix.settings.experimental-features = [ "nix-command" "flakes" ];
  nix.settings.trusted-users = [ "root" "monolith" ]; # Add your username here
  virtualisation.docker.enable = true;

  system.stateVersion = "24.11";
}
