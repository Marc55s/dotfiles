{pkgs, config, ...}:
{
    home.packages = with pkgs; [ 
        fluxcd
        kubectl
        kind
        k9s
    ];

    programs.kubecolor = {
        enable = true;
        enableAlias = true;
        enableZshIntegration = true;
    };
}
