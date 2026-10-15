{ config, pkgs, ... }:
{
  programs.gpu-screen-recorder.enable = true;

  environment.systemPackages = [ pkgs.gpu-screen-recorder-gtk ];

  systemd.user.services.gpu-screen-recorder-replay = {
    description = "GPU Screen Recorder Replay-Puffer";
    wantedBy = [ "graphical-session.target" ];
    partOf = [ "graphical-session.target" ];
    after = [
      "graphical-session.target"
      "pipewire.service"
    ];

    path = [ "/run/wrappers" ];

    serviceConfig = {
      ExecStartPre = "${pkgs.coreutils}/bin/mkdir -p %h/Videos/Replays";
      ExecStart = ''
        ${config.programs.gpu-screen-recorder.package}/bin/gpu-screen-recorder \
          -w portal \
          -restore-portal-session yes \
          -f 60 \
          -a "app-inverse:spotify|default_input" \
          -c mp4 \
          -r 300 \
          -replay-storage disk \
          -o %h/Videos/Replays
      '';
      Restart = "always";
      RestartSec = 5;
    };
  };
}
