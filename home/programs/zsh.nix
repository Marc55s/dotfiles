{
    programs.zsh = {
        enable = true;
        enableCompletion = true;
        initContent = ''
            export DIRENV_LOG_FORMAT=" "
            export PATH="$HOME/.cargo/bin:$PATH"
            if command -v tmux &> /dev/null && [ -z "$TMUX" ]; then
                tmux new
                    fi
                    set bell-style none
        '';
    };
}
