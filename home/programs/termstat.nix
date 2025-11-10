{
    programs.termstat = {
        enable = true;
        enableZshIntegration = true;
        systemd = {
            enable = true;
            onCalendar = "*:0/15";
        };
    };
}

