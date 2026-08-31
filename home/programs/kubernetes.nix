{pkgs, config, ...}:
{
    home.packages = with pkgs; [ 
        fluxcd
        kubectl
        kind
        k9s
        kubernetes-helm
    ];

    programs.kubecolor = {
        enable = true;
        enableAlias = true;
        enableZshIntegration = true;
    };

    home.shellAliases = {
        k = "kubectl";
    };
}
