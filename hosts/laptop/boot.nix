{pkgs, config, ...}:
{
    # Bootloader.
    boot.supportedFilesystems = ["ntfs"];

    boot.loader.efi.canTouchEfiVariables = true;
    boot.loader.grub.enable = true;
    boot.loader.grub.devices = ["nodev"];
    boot.loader.grub.efiSupport = true;
    boot.loader.grub.useOSProber = true;

    boot.loader.grub2-theme = {
        enable = true;
        theme = "vimix";
        footer = true;
    };

    boot.kernelParams = [ "amd_pstate=active" ];
    boot.kernelPackages = pkgs.linuxPackages_latest;
}
