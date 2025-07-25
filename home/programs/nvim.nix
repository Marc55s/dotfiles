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
        nixfmt-classic
        arduino-language-server
        arduino-cli
    ];

    programs.neovim =  {
        enable = true;
        defaultEditor = true;
        vimAlias = true;
        viAlias = true;
        package = pkgs-unstable.neovim.unwrapped;
    };
}
