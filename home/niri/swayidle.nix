{ config, pkgs, ...}:
{
  services.swayidle =
    let
      lock = "${config.programs.noctalia-shell.package}/bin/noctalia-shell ipc call lockScreen lock";
    in
    {
      enable = true;
      systemdTarget = "graphical-session.target";

      timeouts = [
        {
          timeout = 340;
          command = "${pkgs.libnotify}/bin/notify-send 'Locking in 30 seconds' -t 30";
        }
        {
          timeout = 370;
          command = lock;
        }
      ];

      events = [
        {
          event = "before-sleep";
          command = lock;
        }
        {
          event = "lock";
          command = lock;
        }
      ];
    };
}
