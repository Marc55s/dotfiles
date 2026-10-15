{
  fileSystems."/mnt/nvme" = {
    device = "/dev/disk/by-uuid/6fd86718-7584-455a-9093-28881876a250";
    fsType = "ext4";
    options = [ "nofail" ];
  };

  fileSystems."/mnt/hdd" = {
    device = "/dev/disk/by-uuid/a9ef4979-66c9-401b-a218-10cbbdb4bfe4";
    fsType = "ext4";
    options = [ "nofail" ];
  };
}
