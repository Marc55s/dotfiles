{
  services.samba = {
    enable = true;
    openFirewall = true;
    settings = {
      global = {
        "workgroup" = "WORKGROUP";
        "server string" = "NixOS-Home-Server";
        "netbios name" = "monolith";
        "security" = "user";
        "map to guest" = "bad user";
        "guest account" = "nobody";
      };
      "Privat" = {
        "path" = "/mnt/storage/privat";
        "browseable" = "yes";
        "read only" = "no";
        "guest ok" = "no";
        "create mask" = "0664";
        "directory mask" = "0775";
        "force group" = "mediashare";
      };
      "Austausch" = {
        "path" = "/mnt/storage/austausch";
        "browseable" = "yes";
        "read only" = "no";
        "guest ok" = "yes";
      };
    };
  };

  services.gvfs.enable = true;
}
