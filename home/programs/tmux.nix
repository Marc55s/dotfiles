{ config, pkgs, ... }:
let
  gh-opener = pkgs.writeShellApplication {
    name = "gh-opener-script";

    runtimeInputs = [ pkgs.git pkgs.xdg-utils pkgs.tmux ];

    text = ''
      #!${pkgs.bash}/bin/bash
      # Url
      url=$(git remote get-url origin 2>/dev/null || true)
      if [[ -z "$url" ]]; then
        tmux display-message "Not in a git repo (or no 'origin' remote)"
        exit 0
      fi

      if [[ $url == *github.com* || $url == *gitlab* ]]; then
        if [[ $url == git@* ]]; then
          url="''${url#git@}"
          url="''${url/:/\/}"
          url="https://''${url}"
        fi
        
        url="''${url%.git}"
        
        xdg-open "$url"
      else
        tmux display-message "Not a github repo"
      fi
    '';
  };
in {
programs.tmux = {
  enable = true;
  newSession = true;
  plugins = with pkgs; [
    {
      plugin = tmuxPlugins.resurrect;
      extraConfig = ''
        unbind s
        unbind r
        bind s run-shell '${tmuxPlugins.resurrect}/share/tmux-plugins/resurrect/scripts/save.sh'
        bind r run-shell '${tmuxPlugins.resurrect}/share/tmux-plugins/resurrect/scripts/restore.sh'
      '';
    }
  ];

  extraConfig = ''
    set -g base-index 1
    set -g pane-base-index 1
    set-option -sg escape-time 10

    set -g mouse on
    bind-key h select-pane -L
    bind-key j select-pane -D
    bind-key k select-pane -U
    bind-key l select-pane -R
    bind-key & kill-window
    bind-key x kill-pane

    bind-key g run-shell "cd #{pane_current_path} && ${gh-opener}/bin/gh-opener-script"

    set-option -g status-position top
    set-option -g allow-passthrough on

    # --- Theme: nutzt die Kitty-Palette ---
# --- Theme: nutzt die Kitty-Palette ---
set -g status-style "bg=default,fg=colour7"
set -g status-left-length 30
set -g status-left "#[bg=colour3,fg=colour0,bold] #S #[bg=default] "
set -g status-right "#[fg=colour7]%a %d %H:%M "

set -g window-status-format "#[fg=colour7] #I #W "
set -g window-status-current-format "#[bg=colour3,fg=colour0,bold] #I #W "
set -g window-status-separator " "

set -g pane-border-style "fg=colour8"
set -g pane-active-border-style "fg=colour3"
set -g message-style "bg=colour3,fg=colour0"
set -g mode-style "bg=colour3,fg=colour0"
  '';
};
}
