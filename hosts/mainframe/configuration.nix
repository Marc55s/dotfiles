{ pkgs, pkgs-unstable, ... }: {
  imports = [ ./disk.nix ./nginx.nix ./factorio.nix ../../modules/local.nix ../../modules/ssh.nix ];

  boot.supportedFilesystems = [ "ntfs" ];
  boot.loader.grub = {
    enable = true;
    efiSupport = true;
    useOSProber = true;
    devices = [ "/dev/sda" ];
    efiInstallAsRemovable = true;
  };

  boot.kernelParams = [ "nomodeset" ];
  networking.hostName = "nixos-server";
  hardware.enableRedistributableFirmware = true;

  networking.wireless.enable = true;
  networking.useDHCP = true;

  environment.systemPackages = (with pkgs; [ git vim curl ]);
  users.users.root.openssh.authorizedKeys.keys = [
    "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIDmMEHJkey2YR4q7pgJVcgq8mi3Wfu2rJnwnQiMAoLjW marc@pc"
    "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIBUBslv6CEeXw6xVnNi9AOvkpQh5k3eN/moHNKLxja87 marc@laptop"
  ];
  users = {
    users.mainframe = {
      isNormalUser = true;
      description = "Mainframe user";
      extraGroups = [ "networkmanager" "wheel" "docker" ];
      openssh.authorizedKeys.keys = [
        "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIDmMEHJkey2YR4q7pgJVcgq8mi3Wfu2rJnwnQiMAoLjW marc@pc"
        "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIBUBslv6CEeXw6xVnNi9AOvkpQh5k3eN/moHNKLxja87 marc@laptop"
      ];
    };
  };
  security.sudo.wheelNeedsPassword = false;
  nix.settings.experimental-features = [ "nix-command" "flakes" ];
  virtualisation.docker.enable = true;

  services.logind = {
    # This is the new "structured" way to replace extraConfig
    settings = {
      Login = {
        HandlePowerKey = "ignore";
        HandleSuspendKey = "ignore";
        HandleHibernateKey = "ignore";
      };
    };
  };

  system.stateVersion = "25.11";
}
