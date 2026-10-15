{pkgs, ...}:
{
  services.greetd = {
    enable = true;
    settings = {
      default_session = {
        command = ''
          ${pkgs.tuigreet}/bin/tuigreet \
            --time \
            --remember \
            --remember-user-session \
            --asterisks \
            --cmd startplasma-wayland
        '';
        user = "greeter";
      };
    };
  };

  systemd.services.greetd = {
    unitConfig = { After = [ "multi-user.target" "display-manager.target" ]; };
    serviceConfig = {
      Type = "idle";
      StandardInput = "tty";
      StandardOutput = "tty";
      StandardError = "journal";
      TTYReset = true;
      TTYVHangup = true;
      TTYVTDisallocate = true;
    };
  };
}
