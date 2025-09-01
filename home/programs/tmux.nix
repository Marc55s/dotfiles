{ config, pkgs, ... }:

{
    programs.tmux = {
        enable = true;
        newSession = true;
        plugins = with pkgs;[
            /*
            {
                plugin = tmuxPlugins.catppuccin;
                extraConfig = ''
                  # Additional tmux customizations for Catppuccin theme
                  set -g @catppuccin_window_left_separator ""
                  set -g @catppuccin_window_right_separator ""
                  set -g @catppuccin_window_middle_separator " █"
                  set -g @catppuccin_window_number_position "right"

                  set -g @catppuccin_window_default_fill "number"
                  set -g @catppuccin_window_default_text "#W"

                  set -g @catppuccin_window_current_fill "number"
                  set -g @catppuccin_window_current_text "#W"

                  set -g @catppuccin_status_left_separator " "
                  set -g @catppuccin_status_right_separator ""
                  set -g @catppuccin_status_fill "icon"
                  set -g @catppuccin_status_connect_separator "no"

                  set -g @catppuccin_directory_text "#{pane_current_path}"

                  set -g status-right "#{E:@catppuccin_status_directory}"
                  set -ag status-right "#{E:@catppuccin_status_session}"
                '';
            }
            */
            {
                plugin = tmuxPlugins.gruvbox;
                extraConfig = ''
                    set -g @tmux-gruvbox 'dark' # or 'dark256', 'light', 'light256'
                '';
            }
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
      # Start counting pane and window number at 1
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

      set-option -g status-position top
      set-option -g allow-passthrough on

        '';
    };
}

