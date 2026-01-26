{ pkgs, ... }:
{
  imports = [
    ./disk.nix
    ../../modules/ssh.nix
    ../../modules/local.nix
  ];

    boot.loader.grub = {
        # no need to set devices, disko will add all devices that have a EF02 partition to the list already
        # devices = [ ];
        efiSupport = true;
        efiInstallAsRemovable = true;
    };
  networking.hostName = "nixos-server";


  environment.systemPackages = (with pkgs; [
    git
    vim
    curl
  ]);

  users = {
    users.mainframe = {
        isNormalUser = true;
        description = "Mainframe user";
        extraGroups = [ "networkmanager" "wheel" "docker"];
        openssh.authorizedKeys.keys = [
          "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIDmMEHJkey2YR4q7pgJVcgq8mi3Wfu2rJnwnQiMAoLjW marc@pc
           ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIBUBslv6CEeXw6xVnNi9AOvkpQh5k3eN/moHNKLxja87 marc@laptop"
        ];
    };
  };

  virtualisation.docker.enable = true;

  system.stateVersion = "25.11";
}
