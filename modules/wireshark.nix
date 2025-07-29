{config, pkgs, ...}:
{
    users.users.marc = {
        extraGroups = [ "wireshark" ];
    };

    programs.wireshark.enable = true;
    programs.wireshark.dumpcap.enable = true;

    environment.systemPackages = with pkgs; [
        wireshark
    ];
}
