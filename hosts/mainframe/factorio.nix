{ pkgs, lib, ... }: {

  environment.systemPackages = (with pkgs; [ factorio-headless ]);

  services.factorio = {
    enable = true;
    openFirewall = true;

    saveName = "40";
    loadLatestSave = false;
    extraSettingsFile =
      "/home/mainframe/faserver/factorio/data/server-settings.json";

    package = pkgs.factorio-headless.overrideAttrs (old: rec {
      version = "2.0.76";
      src = pkgs.fetchurl {
        name = "factorio_headless_x64-${version}.tar.xz";
        url = "https://factorio.com/get-download/${version}/headless/linux64";
        hash = "sha256-7zZj9mFG12NC98CaP3Q3kmNvjNlcOeomz8pb0uDpJDA=";
      };
      postInstall = (old.postInstall or "") + ''
        rm -rf $out/share/factorio/data/space-age
        rm -rf $out/share/factorio/data/quality
        rm -rf $out/share/factorio/data/elevated-rails
      '';

      extraArgs = [ "--mod-directory" "/var/lib/factorio/mods" ];

    });
  };

  systemd.services.factorio.serviceConfig = {
    StateDirectory = "factorio";
    StateDirectoryMode = "0750";

    # This fixes the "Permission Denied" on /var/lib/private/factorio/temp
    RuntimeDirectory = "factorio";
    RuntimeDirectoryMode = "0750";
  };

  virtualisation.oci-containers.containers.factorio-space-age = {
    image = "factoriotools/factorio:latest";
    ports = [ "34198:34197/udp" ];
    volumes = [ "/var/lib/factorio-second:/factorio" ];
    environment = {
      # If these are set, the server can download mods from the portal
      DLC_SPACE_AGE = "false";
      # Update mods on every startup
      UPDATE_MODS_ON_START = "true";
    };
  };
}
