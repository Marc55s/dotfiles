{ config, pkgs, ... }:

{
  services.nginx = {
    enable = true;
    virtualHosts."localhost" = {
      default = true;
      root = pkgs.writeTextDir "index.html" (builtins.readFile ./web/index.html);
    };
  };

  networking.firewall.allowedTCPPorts = [ 80 ];
}
