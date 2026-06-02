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
        nodejs_24
        nixfmt
        arduino-language-server
        arduino-cli
    ];

    programs.neovim = {
        enable = true;
        viAlias = true;
        vimAlias = true;
        sideloadInitLua = true;
        withPython3 = false;
        withRuby = false;
    };

}
