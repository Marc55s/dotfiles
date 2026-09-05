{
  services.k3s = {
    enable = true;
    role = "server";
    extraFlags = [
      "--write-kubeconfig-mode=0644"
      "--tls-san=monolith"
      # "--tls-san=monolith.<dein-tailnet>.ts.net"
      # "--tls-san=192.168.x.y"
    ];
  };

  networking.firewall = {
    allowedTCPPorts = [ 6443 ];
    trustedInterfaces = [ "cni0" "flannel.1" ];
  };
}
