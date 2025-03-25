{config, pkgs, ...}:
{
    home.packages = with pkgs;[
        zap
        nmap
        gobuster
   ];
}
