{ config, pkgs, ... }:
{
    programs.zathura = {
        enable = true;
        options = {
            default-bg = "#2A2A2A";          # Background color
            statusbar-bg = "#3c3836";        # Status bar color
            highlight-active = true;         # Highlight links
            selection-clipboard = "clipboard"; # Use system clipboard
            adjust-open = "best-fit";        # Adjust zoom level
            synctex = true;                  # Enable SyncTeX support
            recolor = true;                   # Enable dark mode
        };
    };
}
