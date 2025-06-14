{
  services.openssh = {
    enable = true;
    settings = {
      PermitRootLogin = "no";
      PasswordAuthentication = false; # Only allow key-based auth
    };
    allowSFTP = false; # Optional, disable file transfer if you don't need it
  };

  networking.firewall.allowedTCPPorts = [ 22 41641 ];

  services.tailscale = {
    enable = true;
  };

}
