{ config, pkgs, hostName, ... }: {
  home.packages = with pkgs;
    [ zap nmap gobuster hashcat ] ++ (if hostName == "laptop" then [
      aircrack-ng
      aircrack-ng
      hcxdumptool
      reaverwps-t6x
    ] else
      [ ]);
}
