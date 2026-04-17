{ lib, ... }: {
  disko.devices = {
    disk.disk1 = {
      device = lib.mkDefault
        "/dev/disk/by-id/ata-Intenso_SSD_Sata_III_AA000000000000002795";
      type = "disk";
      content = {
        type = "gpt";
        partitions = {
          boot = {
            name = "boot";
            size = "1M";
            type = "EF02";
          };
          esp = {
            name = "ESP";
            size = "500M";
            type = "EF00";
            content = {
              type = "filesystem";
              format = "vfat";
              mountpoint = "/boot";
            };
          };
          root = {
            name = "root";
            size = "100%";
            content = {
              type = "lvm_pv";
              vg = "pool";
            };
          };
        };
      };
    };
    disk.disk2 = {
      device = lib.mkDefault "/dev/disk/by-id/ata-ST3500413AS_Z2AR49VF";
      type = "disk";
      content = {
        type = "gpt";
        partitions = {
          storage = {
            size = "100%";
            content = {
              type = "lvm_pv";
              vg = "pool"; # Same name as your existing VG
            };
          };
        };
      };
    };
    lvm_vg = {
      pool = {
        type = "lvm_vg";
        lvs = {
          root = {
            size = "100%FREE";
            content = {
              type = "filesystem";
              format = "ext4";
              mountpoint = "/";
              mountOptions = [ "defaults" ];
            };
          };
          swap = {
            size = "16G";
            content = {
              type = "swap";
              discardPolicy = "both";
            };
          };
        };
      };
    };
  };
}
