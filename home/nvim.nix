{pkgs, pkgs-unstable, ... }:
{
    home.packages = with pkgs;[
        # LSPs
        texlab
        lua-language-server
        nil
        pylyzer
        pyright
        tree-sitter-grammars.tree-sitter-latex
        tree-sitter
        rust-analyzer
    ];

    programs.neovim =  {
        enable = true;
        defaultEditor = true;
        vimAlias = true;
        viAlias = true;
        package = pkgs-unstable.neovim.unwrapped;
        plugins = with pkgs.vimPlugins; [
            # ... your other plugins
            (nvim-treesitter.withPlugins (_: nvim-treesitter.allGrammars ++ [
                (pkgs.tree-sitter.buildGrammar {
                    language = "just";
                    version = "8af0aab";
                    src = pkgs.fetchFromGitHub {
                        owner = "IndianBoy42";
                        repo = "tree-sitter-just";
                        rev = "8af0aab79854aaf25b620a52c39485849922f766";
                        sha256 = "sha256-hYKFidN3LHJg2NLM1EiJFki+0nqi1URnoLLPknUbFJY=";
                    };
                })
            ]))
        ];
    };
}
