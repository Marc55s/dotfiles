{ config, pkgs, ... }:
{
  imports =
    [
      ./hardware-configuration.nix
      ../../modules/nix-ld.nix
      ../../modules/ssh.nix
      ../../modules/wireshark.nix
    ];

  fileSystems."/mnt/nvme" = {
    device ="/dev/disk/by-uuid/6fd86718-7584-455a-9093-28881876a250" ;
    fsType = "ext4";
  };

  fileSystems."/mnt/hdd" = {
    device ="/dev/disk/by-uuid/a9ef4979-66c9-401b-a218-10cbbdb4bfe4" ;
    fsType = "ext4";
  };

  # Bootloader.
  # boot.kernelPackages = pkgs.linuxPackages_zen;
  boot.loader = {
    systemd-boot.enable = false;
    efi.canTouchEfiVariables = true;

    grub = {
      enable = true;
      efiSupport = true;
      device = "nodev";  # required for UEFI systems
    };
  };
  networking.hostName = "pc"; # Define your hostname.
  networking.interfaces.enp34s0.wakeOnLan = {
    enable = true;
    policy = [ "magic" ];
  };
  # networking.wireless.enable = true;  # Enables wireless support via wpa_supplicant.

  # Configure network proxy if necessary
  # networking.proxy.default = "http://user:password@proxy:port/";
  # networking.proxy.noProxy = "127.0.0.1,localhost,internal.domain";

  # Gaming
  hardware.graphics= {
        enable = true;
        enable32Bit = true;
  };

  programs.steam = {
    enable = true;
    remotePlay.openFirewall = true; # Open ports in the firewall for Steam Remote Play
    dedicatedServer.openFirewall = true; # Open ports in the firewall for Source Dedicated Server
    localNetworkGameTransfers.openFirewall = true; # Open ports in the firewall for Steam Local Network Game Transfers
  };
  programs.gamemode.enable = true;

  powerManagement = {
    enable = true;
    cpuFreqGovernor = "performance";
  };
  environment.variables = {
  AMD_VULKAN_ICD = "RADV";  # Force RADV
  RADV_PERFTEST = "aco";    # Use ACO compiler (faster for games)
  };

  programs.steam.gamescopeSession.enable = false;
  # Enable networking
  networking.networkmanager.enable = true;

  # Set your time zone.
  time.timeZone = "Europe/Berlin";

  # Select internationalisation properties.
  i18n.defaultLocale = "en_US.UTF-8";

  i18n.extraLocaleSettings = {
    LC_ADDRESS = "de_DE.UTF-8";
    LC_IDENTIFICATION = "de_DE.UTF-8";
    LC_MEASUREMENT = "de_DE.UTF-8";
    LC_MONETARY = "de_DE.UTF-8";
    LC_NAME = "de_DE.UTF-8";
    LC_NUMERIC = "de_DE.UTF-8";
    LC_PAPER = "de_DE.UTF-8";
    LC_TELEPHONE = "de_DE.UTF-8";
    LC_TIME = "de_DE.UTF-8";
  };

  services.flatpak.enable = true;
  # Enable the X11 windowing system.
  # You can disable this if you're only using the Wayland session.
  services.xserver.enable = true;

  # Enable the KDE Plasma Desktop Environment.
  services.greetd = {
      enable = true;
      settings = {
          default_session = {
              command = "${pkgs.greetd.tuigreet}/bin/tuigreet --cmd startplasma-wayland";
          };
      };
  };
  services.displayManager.sddm.enable = false;
  services.desktopManager.plasma6.enable = true;

  # Configure keymap in X11
  services.xserver.xkb = {
    layout = "de";
    variant = "";
  };

  # Configure console keymap
  console.keyMap = "de";

  # Enable CUPS to print documents.
  services.printing.enable = true;

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

  # Enable touchpad support (enabled default in most desktopManager).
  # services.xserver.libinput.enable = true;

  # Define a user account. Don't forget to set a password with ‘passwd’.
  users.users.marc = {
    isNormalUser = true;
    description = "Marc";
    extraGroups = [ "networkmanager" "docker" "wheel" "audio"];
    shell = pkgs.zsh;
    packages = with pkgs; [
      kdePackages.kate
      thunderbird
    ];
  };
  programs.zsh.enable = true;

  # flakes
  nix.settings = {
      experimental-features = [ "nix-command" "flakes" ];
      warn-dirty = false;
  };

  nix.gc = {
    automatic = true;
    dates = "weekly";
    options = "--delete-older-than 14d";
  };

  # Allow unfree packages
  # nixpkgs.config.allowUnfree = true;

  environment.systemPackages = with pkgs; [
    wl-clipboard
    gamescope
    kdePackages.kcalc
    lutris
    mangohud
  ];

 nixpkgs.overlays = [
    (self: super: {
      lutris = super.lutris.override {
        extraLibraries = pkgs: with pkgs; [
          # 64-bit libraries
          keyutils
          libkrb5
          libpng
          libpulseaudio
          libvorbis
          stdenv.cc.cc
          vulkan-loader
          xorg.libXcomposite
          xorg.libXext
          xorg.libX11
          xorg.libXau
          xorg.libxcb
          xorg.libXdmcp
          xorg.libXfixes
          xorg.libXrandr
          xorg.libXrender
          xorg.libXxf86vm
          xorg.libxshmfence

          # 32-bit libraries
          pkgsi686Linux.keyutils
          pkgsi686Linux.libkrb5
          pkgsi686Linux.libpng
          pkgsi686Linux.libpulseaudio
          pkgsi686Linux.libvorbis
          pkgsi686Linux.stdenv.cc.cc
          pkgsi686Linux.vulkan-loader
          pkgsi686Linux.xorg.libXcomposite
          pkgsi686Linux.xorg.libXext
          pkgsi686Linux.xorg.libX11
          pkgsi686Linux.xorg.libXau
          pkgsi686Linux.xorg.libxcb
          pkgsi686Linux.xorg.libXdmcp
          pkgsi686Linux.xorg.libXfixes
          pkgsi686Linux.xorg.libXrandr
          pkgsi686Linux.xorg.libXrender
          pkgsi686Linux.xorg.libXxf86vm
          pkgsi686Linux.xorg.libxshmfence

          # GStreamer and its plugins (both 64 and 32-bit)
          gst_all_1.gstreamer
          gst_all_1.gst-plugins-base
          gst_all_1.gst-plugins-good
          gst_all_1.gst-plugins-bad
          gst_all_1.gst-plugins-ugly
          gst_all_1.gst-libav

          pkgsi686Linux.gst_all_1.gstreamer
          pkgsi686Linux.gst_all_1.gst-plugins-base
          pkgsi686Linux.gst_all_1.gst-plugins-good
          pkgsi686Linux.gst_all_1.gst-plugins-bad
          pkgsi686Linux.gst_all_1.gst-plugins-ugly
          pkgsi686Linux.gst_all_1.gst-libav

          # Specific libraries mentioned in your errors
          pkgsi686Linux.libgudev # fixes "libgudev-1.0.so.0" error
          pkgsi686Linux.speex    # fixes "libspeex.so.1" error
          pkgsi686Linux.libtheora # fixes "libtheoradec.so.1" error
          pkgsi686Linux.openal   # fixes "libopenal.so.1" error
          pkgsi686Linux.libvdpau # fixes "libvdpau.so.1" error
        ];
      };
    })
  ];

  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken. It‘s perfectly fine and recommended to leave
  # this value at the release version of the first install of this system.
  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  system.stateVersion = "24.11"; # Did you read the comment?
}
