# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

{ pkgs, pkgs-unstable, ... }:

{
    # Bootloader.

    boot.supportedFilesystems = ["ntfs"];

    boot.loader.efi.canTouchEfiVariables = true;
    boot.loader.grub.enable = true;
    boot.loader.grub.devices = ["nodev"];
    boot.loader.grub.efiSupport = true;
    boot.loader.grub.useOSProber = true;

    networking.hostName = "nixos"; # Define your hostname.
    # networking.wireless.enable = true;  # Enables wireless support via wpa_supplicant.

    # Configure network proxy if necessary
    # networking.proxy.default = "http://user:password@proxy:port/";
    # networking.proxy.noProxy = "127.0.0.1,localhost,internal.domain";

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

    boot.kernelModules = [ "evdi" ];

    # Enable the X11 windowing system.
    services.xserver.enable = false;

    # Enable the GNOME Desktop Environment.
    services.xserver.displayManager.gdm.enable = false;
    services.xserver.desktopManager.gnome.enable = false;
    services.xserver.videoDrivers = [ "displaylink" "modesetting" ];
    services.xserver.displayManager.sessionCommands = ''
    ${pkgs.lib.getBin pkgs.xorg.xrandr}/bin/xrandr --setprovideroutputsource 2 0
    '';


    # Configure keymap in X11
    services.xserver.xkb = {
        layout = "de";
        variant = "";
    };

    programs.hyprland = {
        # Install the packages from nixpkgs
        enable = true;
        # Whether to enable XWayland
        xwayland.enable = true;
    }; 

    services.greetd = {
        enable = true;
        settings = {
            default_session = {
                command = "${pkgs.greetd.greetd}/bin/agreety --cmd hyprland";
            };
        };

    };
    # Configure console keymap
    console.keyMap = "de";

    # Enable CUPS to print documents.
    services.printing.enable = true;


    # Enable sound with pipewire.
    hardware.pulseaudio.enable = false;
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
        description = "marc";
        extraGroups = [ "networkmanager" "wheel" ];
        shell = pkgs.zsh;
        packages = with pkgs; [
            #  thunderbird
        ];
    };

    programs.zsh.enable = true;

    # flakes
    nix.settings.experimental-features = [ "nix-command" "flakes" ];


    # List packages installed in system profile. To search, run:
    # $ nix search wget
    environment.systemPackages = with pkgs; [
        #  vim # Do not forget to add an editor to edit configuration.nix! The Nano editor is also installed by default.
        #  wget
        pkgs-unstable.neovim
        hyprpanel
        gcc
        zsh
        python3
        gnumake
        displaylink
        (discord.override {
            # withOpenASAR = true; # can do this here too
            withVencord = true;
        })
        wl-clipboard
        brightnessctl
    ];


    fonts.packages = with pkgs; [
        (nerdfonts.override { fonts = [ "JetBrainsMono" ]; })
    ];



# Some programs need SUID wrappers, can be configured further or are
# started in user sessions.
# programs.mtr.enable = true;
# programs.gnupg.agent = {
#   enable = true;
#   enableSSHSupport = true;
# };

# List services that you want to enable:

# Enable the OpenSSH daemon.
# services.openssh.enable = true;

# Open ports in the firewall.
# networking.firewall.allowedTCPPorts = [ ... ];
# networking.firewall.allowedUDPPorts = [ ... ];
# Or disable the firewall altogether.
# networking.firewall.enable = false;

# This value determines the NixOS release from which the default
# settings for stateful data, like file locations and database versions
# on your system were taken. It‘s perfectly fine and recommended to leave
# this value at the release version of the first install of this system.
# Before changing this value read the documentation for this option
# (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
system.stateVersion = "24.05"; # Did you read the comment?
    }
