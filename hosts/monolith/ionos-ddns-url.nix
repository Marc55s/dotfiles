{ config, pkgs, ... }:
{
  age.secrets.ionos-ddns-url.file = ../../modules/ionos-ddns-url.age;

  systemd.services.ionos-ddns = {
    description = "Update IONOS DynDNS record";
    after = [ "network-online.target" ];
    wants = [ "network-online.target" ];

    serviceConfig = {
      Type = "oneshot";
    };

    path = [ pkgs.curl pkgs.coreutils ];

    script = ''
      set -euo pipefail

      url="$(cat ${config.age.secrets.ionos-ddns-url.path})"

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
