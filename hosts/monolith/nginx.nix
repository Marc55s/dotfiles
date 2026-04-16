{ config, pkgs, ... }:

{
  services.nginx = {
    enable = true;
  };

  # networking.firewall.allowedTCPPorts = [ ];
}
