{ config, pkgs, ... }:

let
    # Fetch the Catppuccin tmux theme from GitHub
    tmux-cat = pkgs.tmuxPlugins.mkTmuxPlugin
        {
            pluginName = "tmux-cat";
            src = pkgs.fetchFromGitHub {
                owner = "catppuccin";
                repo = "tmux";
                rev = "v2.1.2";  # Replace with the desired version
                sha256 = "sha256-vBYBvZrMGLpMU059a+Z4SEekWdQD0GrDqBQyqfkEHPg";  # Replace with the correct SHA256
            };
        };
in
    {
    programs.tmux = {
        enable = true;  # Enable TMUX through Home Manager
        plugins = with pkgs;[
            {
                plugin = tmux-cat;
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

        ];
        extraConfig = ''
      # Start counting pane and window number at 1
      set -g base-index 1
      set -g pane-base-index 1

      # conf typecraft
      unbind r 
      bind r source-file ~/.config/tmux/tmux.conf

      set -g mouse on
      bind-key h select-pane -L
      bind-key j select-pane -D
      bind-key k select-pane -U
      bind-key l select-pane -R

      set-option -g status-position top

        '';
    };
}

