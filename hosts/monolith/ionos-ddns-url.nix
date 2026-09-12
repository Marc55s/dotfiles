{ config, pkgs, ... }:
{
  sops.defaultSopsFile = ../../secrets/ionos-ddns-url.enc.env;
  sops.age.sshKeyPaths = [ "/etc/ssh/ssh_host_ed25519_key" ];
  sops.secrets.ionos-ddns-url = {
    format = "dotenv";
    sopsFile = ../../secrets/ionos-ddns-url.enc.env;
  };

  systemd.services.ionos-ddns = {
    description = "Update IONOS DynDNS record";
    after = [ "network-online.target" ];
    wants = [ "network-online.target" ];

    serviceConfig = {
      Type = "oneshot";
    };

    path = [
      pkgs.curl
      pkgs.coreutils
    ];

    script = ''
      set -euo pipefail

      url="$(cat ${config.sops.secrets.ionos-ddns-url.path})"

      # -f  -> bei HTTP-Fehler mit Fehlercode abbrechen (landet sichtbar im Journal)
      # -sS -> still, aber Fehler zeigen
      # -L  -> Weiterleitungen folgen (IONOS leitet http->https um)
      curl -fsSL --max-time 30 "$url" > /dev/null
      echo "IONOS DynDNS erfolgreich aktualisiert."
    '';
  };

  # Startet den Dienst 2 Min nach Boot und danach alle 15 Min.
  systemd.timers.ionos-ddns = {
    description = "Run IONOS DynDNS updater periodically";
    wantedBy = [ "timers.target" ];
    timerConfig = {
      OnBootSec = "2min";
      OnUnitActiveSec = "15min";
      Persistent = true;
    };
  };
}
