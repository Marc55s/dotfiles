{pkgs, ...}:
{
    programs.nnn = {
        enable = true;
            plugins = {
                # Point to plugins folder
                src = pkgs.fetchFromGitHub {
                    owner = "jarun";
                    repo = "nnn";
                    rev = "v5.0"; # change to latest nnn release
                    sha256 = "sha256-HShHSjqD0zeE1/St1Y2dUeHfac6HQnPFfjmFvSuEXUA="; # fill with nix-prefetch result
                } + "/plugins";

                # Map 'o' key to nuke (opener)
                mappings = {
                    o = "nuke";
                };
            };
    };
    home.file.".config/nnn/plugins/nuke".text = ''
        #!/usr/bin/env sh
        # minimal nuke with zathura for pdfs
        case "$1" in
          *.pdf) exec zathura "$@" ;;
          *) exec xdg-open "$@" ;;
        esac
    '';
}
