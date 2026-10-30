{ pkgs, inputs, ... }: {
  imports = [ inputs.noctalia.homeModules.default ];

  programs.noctalia = {
    enable = true;
    systemd.enable = true;

    # noctalia 5.x schema: TOML, snake_case, named bars + named widgets.
    # Reference: `noctalia config export full` and the bundled example.toml.
    settings = {
      accessibility = {
        ui_scale = 1.0;
        high_contrast = false;
      };

      shell = {
        corner_radius_scale = 1.0;
        font_family = "sans-serif";
        time_format = "{:%H:%M}";
        date_format = "%A, %x";
        telemetry_enabled = false;
        setup_wizard_enabled = false;
        settings_show_advanced = true;
        show_location = false;
        clipboard_enabled = false;
        app_icon_colorize = false;

        animation = {
          enabled = true;
          speed = 1.0;
        };

        shadow = {
          direction = "down_right";
          alpha = 0.55;
        };

        screen_corners = {
          enabled = false;
          size = 32;
        };

        panel = {
          transparency_mode = "soft";
          borders = true;
          shadow = true;
          launcher_placement = "attached";
          clipboard_placement = "attached";
          control_center_placement = "attached";
          wallpaper_placement = "attached";
          session_placement = "attached";
          launcher_position = "center";
          open_near_click_control_center = true;
        };

        launcher = {
          categories = true;
          show_icons = true;
          compact = false;
          app_grid = false;
          sort_by_usage = true;
          pinned = [ ];
        };

        session = {
          grid = false;
          show_shortcuts = true;
          actions = [
            {
              action = "lock";
              shortcut = "1";
              enabled = true;
              variant = "default";
            }
            {
              action = "lock_and_suspend";
              shortcut = "2";
              enabled = true;
              variant = "default";
            }
            {
              action = "reboot";
              shortcut = "3";
              enabled = true;
              variant = "default";
            }
            {
              action = "logout";
              shortcut = "4";
              enabled = true;
              variant = "default";
            }
            {
              action = "shutdown";
              shortcut = "5";
              enabled = true;
              variant = "destructive";
            }
          ];
        };

        window_switcher = {
          style = "carousel";
          show_caption = true;
          show_app_icon = true;
        };
      };

      theme = {
        mode = "dark";
        shell_mode = "follow";
        source = "builtin";
        builtin = "Gruvbox";
        pure_black_dark = false;
      };

      # ── Bar ──────────────────────────────────────────────────────────────
      bar = {
        order = [ "main" ];

        # `order` only sets draw order, it does not gate which bars exist.
        # The 5.x setup wizard persisted its own "default" bar into
        # ~/.local/state/noctalia/settings.toml, which renders alongside ours.
        # State overrides config per-key, and that block sets no `enabled`,
        # so disabling it here wins.
        default.enabled = false;

        main = {
          position = "top";
          thickness = 34;
          background_opacity = 0.93;
          radius = 12;
          margin_edge = 5;
          margin_ends = 5;
          padding = 10;
          widget_spacing = 6;
          scale = 1.0;
          font_scale = 1.0;
          shadow = true;
          auto_hide = false;
          reserve_space = true;
          concave_edge_corners = true;
          capsule = true;
          capsule_fill = "surface_variant";
          capsule_opacity = 1.0;

          start = [
            "control-center"
            "launcher"
            "clock"
            "cpu"
            "temp"
            "ram"
            "disk"
            "active_window"
            "media"
          ];
          # Swap to "workspaces" for numbered pills instead of app icons.
          center = [ "taskbar" ];
          end = [
            "tray"
            "power_profile"
            "battery"
            "volume"
            "brightness"
            "network"
            "nightlight"
            "notifications"
            "session"
          ];
        };
      };

      # ── Widgets ──────────────────────────────────────────────────────────
      widget = {
        "control-center" = {
          type = "control-center";
          custom_image_colorize = false;
        };

        launcher = {
          type = "launcher";
          glyph = "rocket";
        };

        clock = {
          type = "clock";
          format = "{:%H:%M %a, %b %d}";
          vertical_format = "{:%H\n%M}";
          tooltip_format = "{:%A, %B %d, %Y}";
        };

        cpu = {
          type = "sysmon";
          stat = "cpu_usage";
        };

        temp = {
          type = "sysmon";
          stat = "cpu_temp";
        };

        ram = {
          type = "sysmon";
          stat = "ram_used";
        };

        disk = {
          type = "sysmon";
          stat = "disk_used";
          path = "/";
        };

        active_window = {
          type = "active_window";
          min_length = 80;
          max_length = 145;
          icon_size = 14;
          title_scroll = "on_hover";
          display = "icon_and_text";
          show_empty_label = false;
        };

        media = {
          type = "media";
          artist_first = true;
          art_size = 16;
          max_length = 145;
          title_scroll = "on_hover";
          hide_when_no_media = true;
        };

        # App icons grouped per workspace, no workspace numbers.
        # The 5.x `workspaces` widget can no longer draw per-app icons
        # (only one focused-app icon, and only with style = "focus_hint"),
        # so workspace-with-icons lives on the taskbar widget now.
        # Needs per-window workspace data from the compositor; niri provides it.
        taskbar = {
          type = "taskbar";
          group_by_workspace = true;
          workspace_group_content = "icons";
          show_workspace_label = false;
          workspace_group_capsule = true;
          group_single_icon_per_app = true;
          hide_empty_workspaces = true;
          show_all_outputs = false;
          only_active_workspace = false;
          icon_scale = 1.0;
          item_spacing = 4;
          show_window_title = false;
          show_active_indicator = true;
          active_indicator_color = "primary";
          active_opacity = 1.0;
          inactive_opacity = 1.0;
          focused_color = "primary";
          occupied_color = "secondary";
          empty_color = "secondary";
          urgent_color = "error";
        };

        # Kept for easy fallback; unused unless listed in a bar section.
        workspaces = {
          type = "workspaces";
          style = "regular";
          show_labels = true;
          show_icons = true;
          label_source = "id";
          max_label_chars = 2;
          show_tooltip = true;
          labels_only_when_occupied = false;
          hide_when_empty = false;
          pill_scale = 0.6;
          focused_color = "primary";
          occupied_color = "secondary";
          empty_color = "secondary";
          urgent_color = "error";
        };

        tray = {
          type = "tray";
          drawer = true;
          hide_passive = false;
          hidden = [ ];
          pinned = [ ];
        };

        power_profile.type = "power_profile";

        battery = {
          type = "battery";
          device = "auto";
          scale = 1.15;
        };

        volume = {
          type = "volume";
          device = "output";
          show_label = false;
          mute_color = "error";
          actions.middle = "exec sh -c 'pwvucontrol || pavucontrol'";
        };

        brightness = {
          type = "brightness";
          show_label = false;
        };

        network = {
          type = "network";
          show_label = false;
        };

        nightlight.type = "nightlight";

        notifications = {
          type = "notifications";
          hide_when_no_unread = true;
        };

        session = {
          type = "session";
          glyph = "power";
        };
      };

      # ── Dock ─────────────────────────────────────────────────────────────
      dock = {
        enabled = true;
        position = "bottom";
        auto_hide = true;
        reserve_space = false;
        icon_size = 40;
        background_opacity = 1.0;
        active_monitor_only = true;
        launcher_position = "none";
        show_dots = false;
        show_running = true;
        show_instance_count = true;
        magnification = true;
        radius = 16;
        margin_edge = 8;
        shadow = true;
        pinned = [ ];
        monitors = [ ];
      };

      # ── Control center ───────────────────────────────────────────────────
      control_center = {
        sidebar = "compact";
        width = 700;
        show_session_button = true;
        show_shortcut_labels = true;
        hidden_tabs = [ ];
        calendar.show_events_card = true;
        shortcuts = [
          { type = "wifi"; }
          { type = "bluetooth"; }
          { type = "wallpaper"; }
          { type = "notification"; }
          { type = "power_profile"; }
          { type = "caffeine"; }
        ];
      };

      # ── Notifications / OSD ──────────────────────────────────────────────
      notification = {
        enable_daemon = true;
        position = "top_right";
        layer = "overlay";
        background_opacity = 1.0;
        border = true;
        show_app_name = true;
        show_actions = true;
        keep_dismissed_in_history = false;
        collapse_on_dismiss = true;
        width = 360;
      };

      osd = {
        enabled = true;
        position = "top_right";
        hide_delay_ms = 2000;
        background_opacity = 1.0;
        border = true;
        orientation = "horizontal";
      };

      # ── Lockscreen ───────────────────────────────────────────────────────
      lockscreen = {
        enabled = true;
        lock_before_suspend = true;
        fingerprint = false;
        allow_empty_password = false;
        blurred_desktop = false;
        transition_duration = 1500.0;
      };

      # ── Wallpaper ────────────────────────────────────────────────────────
      wallpaper = {
        enabled = true;
        directory = "/home/marc/dotfiles/wallpaper";

        # `directory` only says where the picker looks; the active wallpaper is
        # its own key. 5.x keeps the live selection in the state file, which
        # overrides this per-key, so the picker still works at runtime.
        default.path = "/home/marc/dotfiles/wallpaper/Aleph2.jpg";
        fill_mode = "crop";
        edge_smoothness = 0.05;
        transition_duration = 1500.0;
        transition_on_startup = false;
        per_monitor_directories = false;
        transition = [ "fade" "wipe" "disc" "stripes" "zoom" "honeycomb" ];
        automation = {
          enabled = false;
          interval_seconds = 300;
          order = "random";
          recursive = false;
        };
      };

      # ── Location / weather ───────────────────────────────────────────────
      location = {
        address = "Heidenheim";
        auto_locate = false;
      };

      weather = {
        enabled = true;
        unit = "metric";
        effects = true;
        refresh_minutes = 30;
      };

      calendar = {
        enabled = false;
        event_date_format = "%A %e %B";
        event_time_format = "%H:%M";
      };

      # ── Hardware ─────────────────────────────────────────────────────────
      battery.warning_threshold = 20;

      brightness = {
        enable_ddcutil = false;
        minimum_brightness = 0.0;
        sync_all_monitors = false;
      };

      nightlight = {
        enabled = false;
        force = false;
        temperature_day = 6500;
        temperature_night = 4000;
      };

      audio = {
        enable_overdrive = false;
        enable_sounds = false;
        sound_volume = 0.5;
      };

      system.monitor = {
        enabled = true;
        cpu_usage_activity_threshold = 50.0;
        cpu_usage_critical_threshold = 90.0;
        cpu_temp_activity_threshold = 60.0;
        cpu_temp_critical_threshold = 90.0;
        ram_pct_activity_threshold = 60.0;
        ram_pct_critical_threshold = 90.0;
        disk_used_pct_activity_threshold = 80.0;
        disk_used_pct_critical_threshold = 90.0;
        swap_pct_activity_threshold = 20.0;
        swap_pct_critical_threshold = 90.0;
      };

      # Idle handled by services.swayidle, keep noctalia's own idle off.
      idle = {
        behavior.lock.enabled = false;
        behavior.screen-off.enabled = false;
        behavior.lock-and-suspend.enabled = false;
      };

      desktop_widgets.enabled = false;
      hot_corners.enabled = false;
      backdrop.enabled = false;
      plugins.auto_update = "none";
    };
  };
}
