{ config, pkgs, ... }:
{
    home.packages = with pkgs; [ 
        nix-search-tv
    ];
    programs.television = {
        enable = true;
        enableZshIntegration = true;
        enableBashIntegration = true;
        settings = {
            ui = {
                theme = "gruvbox-dark";
            };
            shell_integration = {
                channel_triggers = {
                    "git-branches" = [ "git checkout" ];
                    "dirs" = [ "ls" ];
                    "files" = [ "cat" "nano" ];
                };
            };
        };

        channels = {
            my-custom = {
                cable_channel = [
                    {
                        name = "git-log";
                        source_command = "git log --oneline --date=short --pretty=\"format:%h %s %an %cd\" \"$@\"";
                        preview_command = "git show -p --stat --pretty=fuller --color=always {0}";
                    }
                    {
                        name = "nixpkgs";
                        source_command = "nix-search-tv print";
                        preview_command = "nix-search-tv preview {}";
                    }
                    {
                        name = "zsh_history";
                        source_command = "sed '1!G;h;$!d' ~/.zsh_history";
                        source_display = "{split:;:1..}";
                        source_output = "{split:;:1..}";
                    }
                ];
            };
        };
    };
}
