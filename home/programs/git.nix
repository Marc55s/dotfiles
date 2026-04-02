{
    programs.delta = {
        enable = true;
        enableGitIntegration = true;
        options = {
            features = "decorations";
            line-numers = true;
            side-by-side = true;
            conflictStyle = "zdiff3";
        };
    };
    programs.git = {
        enable = true;
        aliases = {
            tree = "log --graph --oneline --all --decorate";
        };
        settings = {
            user = {
                email = "marc.schoenig@gmail.com";
                name = "marc55s";
            };
            push.autoSetupRemote = true;
            rerere.enabled = true;
            init.defaultBranch = "main";
            core = {
                editor = "nvim";
            };
        };
    };
}
