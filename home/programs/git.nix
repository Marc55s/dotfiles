{
    programs.git = {
        enable = true;
        userEmail = "marc.schoenig@gmail.com";
        userName = "marc55s";
        delta = {
            enable = true;
            options = {
                features = "decorations";
                line-numers = true;
                side-by-side = true;
            };
        };
        extraConfig = {
            push.autoSetupRemote = true;
            rerere.enabled = true;
            init.defaultBranch = "main";
            core = {
                editor = "nvim";
            };
        };
    };
}
