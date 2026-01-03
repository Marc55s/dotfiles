{ config, pkgs, ... }: {
  imports = [
    ./hardware-configuration.nix
    ./gaming.nix
    ./boot.nix
    ../../modules/nix-ld.nix
    ../../modules/ssh.nix
    ../../modules/wireshark.nix
    ../../modules/nix.nix
    ../../modules/local.nix
  ];

  fileSystems."/mnt/nvme" = {
    device = "/dev/disk/by-uuid/6fd86718-7584-455a-9093-28881876a250";
    fsType = "ext4";
  };

  fileSystems."/mnt/hdd" = {
    device = "/dev/disk/by-uuid/a9ef4979-66c9-401b-a218-10cbbdb4bfe4";
    fsType = "ext4";
  };
  fileSystems."/" = {
    device = "zroot/root";
    fsType = "zfs";
  };
  fileSystems."/nix" = {
    device = "zroot/nix";
    fsType = "zfs";
  };
  fileSystems."/home" = {
    device = "zroot/home";
    fsType = "zfs";
  };
  fileSystems."/boot" = {
    device = "dev/disk/by-label/boot";
    fsType = "vfat";
  };

  networking.hostName = "pc"; # Define your hostname.
  networking.interfaces.enp34s0.wakeOnLan = {
    enable = true;
    policy = [ "magic" ];
  };

  services.xserver.videoDrivers = [ "amdgpu" ];
  # Enable networking
  networking.networkmanager.enable = true;

  services.flatpak.enable = true;
  # Enable the X11 windowing system.
  # You can disable this if you're only using the Wayland session.
  services.xserver.enable = true;
  services.greetd = {
    enable = true;
    settings = {
      default_session = {
        command = ''
          ${pkgs.tuigreet}/bin/tuigreet \
            --time \
            --remember \
            --remember-user-session \
            --asterisks \
            --cmd startplasma-wayland
        '';
        user = "greeter";
      };
    };
  };

  systemd.services.greetd = {
    unitConfig = { After = [ "multi-user.target" "display-manager.target" ]; };
    serviceConfig = {
      Type = "idle";
      StandardInput = "tty";
      StandardOutput = "tty";
      StandardError = "journal";
      TTYReset = true;
      TTYVHangup = true;
      TTYVTDisallocate = true;
    };
  };
  # Enable the KDE Plasma Desktop Environment.
  services.displayManager.sddm.enable = false;
  services.desktopManager.plasma6.enable = true;

  # Enable CUPS to print documents.
  services.printing = {
    enable = true;
    drivers = with pkgs; [ cups-filters cups-browsed ];
  };
  services.avahi = {
    enable = true;
    nssmdns4 = true;
    openFirewall = true;
  };

  # docker
  virtualisation.docker.enable = true;

  # Enable sound with pipewire.
  services.pulseaudio.enable = false;
  security.rtkit.enable = true;
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
    # If you want to use JACK applications, uncomment this
    #jack.enable = true;

    # use the example session manager (no others are packaged yet so this is enabled by default,
    # no need to redefine it in your config for now)
    #media-session.enable = true;
  };

  # Define a user account. Don't forget to set a password with ‘passwd’.
  users.users.marc = {
    hashedPassword =
      "$6$KF5GV021S8V51Bfe$Rc3tnTNBwX46RNxdEORCsr64/DkVKbTIu2cS9837YEPsjJAj5EZwDUSYZ72zVOgqhZWGyvtYZ35jTDrwMhMiw1";
    isNormalUser = true;
    description = "Marc";
    extraGroups = [ "networkmanager" "wheel" "docker" "tty" "dialout" ];
    shell = pkgs.zsh;
    packages = with pkgs; [ kdePackages.kate thunderbird ];
  };

  programs.zsh.enable = true;

  environment.systemPackages = with pkgs; [
    wl-clipboard
    gamescope
    kdePackages.kcalc
    lutris
    mangohud
  ];

  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken. It‘s perfectly fine and recommended to leave
  # this value at the release version of the first install of this system.
  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  system.stateVersion = "24.11"; # Did you read the comment?
}
