{
  config,
  pkgs,
  pkgs-unstable,
  lib,
  ...
}: let
  cfgPath = "presenterm/config.yaml";
  cleanAttrs = attrSet: let
    cleaned =
      lib.mapAttrs (
        _: v:
          if v == null
          then null
          else if lib.isAttrs v
          then let
            sub = cleanAttrs v;
          in
            if sub == {}
            then null
            else sub
          else v
      )
      attrSet;
  in
    lib.filterAttrs (_: v: v != null) cleaned;
  yamlFormat = pkgs.formats.yaml {};
in {
  options.unstable-presenterm = {
    enable = lib.mkOption {
      type = lib.types.bool;
      default = false;
      description = "Enable Module";
    };

    defaults = lib.mkOption {
      type = lib.types.submodule {
        options = {
          theme = lib.mkOption {
            type = lib.types.enum ["dark" "light"];
            default = "dark";
            description = "Sets the theme";
          };

          image_protocol = lib.mkOption {
            type = lib.types.enum ["auto" "kitty-local" "kitty-remote" "iterm2" "sixel"];
            default = "auto";
            description = "Image protocol to use";
          };

          max_columns = lib.mkOption {
            type = with lib.types; nullOr int;
            default = null;
            description = "Maximum number of columns";
          };

          max_columns_alignment = lib.mkOption {
            type = lib.types.enum ["left" "center" "right"];
            default = "left";
            description = "Alignment of columns";
          };

          max_rows = lib.mkOption {
            type = with lib.types; nullOr int;
            default = null;
            description = "Maximum number of rows";
          };

          max_rows_alignment = lib.mkOption {
            type = lib.types.enum ["top" "center" "bottom"];
            default = "top";
            description = "Alignment of rows";
          };

          incremental_lists = lib.mkOption {
            type = lib.types.submodule {
              options = {
                pause_before = lib.mkOption {
                  type = lib.types.bool;
                  default = false;
                  description = "Pause before new item";
                };
                pause_after = lib.mkOption {
                  type = lib.types.bool;
                  default = false;
                  description = "Pause after new item";
                };
              };
            };
            default = {};
            description = "Configuration for incremental lists";
          };

          validate_overflows = lib.mkOption {
            type = lib.types.enum ["never" "always" "when_presenting" "when_developing"];
            default = "never";
            description = "Checks if the presentation fits into the terminal";
          };
        };
      };
      default = {};
      description = "Default settings for Presenterm";
    };

    transition = lib.mkOption {
      type = lib.types.submodule {
        options = {
          duration_millis = lib.mkOption {
            type = with lib.types; nullOr int;
            default = null;
            description = "Duration of transition in ms";
          };
          frames = lib.mkOption {
            type = with lib.types; nullOr int;
            default = null;
            description = "Number of frames in transition";
          };
          animation = lib.mkOption {
            type = lib.types.submodule {
              options = {
                style = lib.mkOption {
                  type = with lib.types; nullOr (enum ["fade" "slide_horizontal" "collapse_horizontal"]);
                  default = null;
                  description = "Transition style";
                };
              };
            };
            default = {};
            description = "Animation configuration";
          };
        };
      };
      default = {};
      description = "Transition settings";
    };

    bindings = lib.mkOption {
      type = lib.types.attrsOf (lib.types.listOf lib.types.str);
      default = {
        next = ["l" "j" "<right>" "<page_down>" "<down>" " "];
        previous = ["h" "k" "<left>" "<page_up>" "<up>"];
        next_fast = ["n"];
        previous_fast = ["p"];
        first_slide = ["gg"];
        last_slide = ["G"];
        go_to_slide = ["<number>G"];
        execute_code = ["<c-e>"];
        reload = ["<c-r>"];
        toggle_slide_index = ["<c-p>"];
        toggle_bindings = ["?"];
        close_modal = ["<esc>"];
        exit = ["<c-c>" "q"];
        suspend = ["<c-z>"];
      };
      description = "Keyboard bindings";
    };

    snippet = lib.mkOption {
      type = lib.types.submodule {
        options = {
          exec = lib.mkOption {
            type = lib.types.submodule {
              options = {
                enable = lib.mkOption {
                  type = lib.types.bool;
                  default = false;
                  description = "Enable snippet execution";
                };

                custom = lib.mkOption {
                  type = lib.types.attrsOf (lib.types.submodule {
                    options = {
                      filename = lib.mkOption {
                        type = with lib.types; nullOr str;
                        default = null;
                        description = "File name for the snippet";
                      };

                      environment = lib.mkOption {
                        type = with lib.types; attrsOf (nullOr str);
                        default = {};
                        description = "Environment variables for snippet execution";
                      };

                      hidden_line_prefix = lib.mkOption {
                        type = with lib.types; nullOr str;
                        default = null;
                        description = "Prefix for hidden lines";
                      };

                      commands = lib.mkOption {
                        type = with lib.types; listOf (listOf str);
                        default = [];
                        description = "List of commands to run";
                      };
                    };
                  });
                  default = {};
                  description = "Custom snippet executors by language";
                };
              };
            };
            default = {};
            description = "Exec snippet configuration";
          };

          exec_replace = lib.mkOption {
            type = lib.types.submodule {
              options = {
                enable = lib.mkOption {
                  type = lib.types.bool;
                  default = false;
                  description = "Enable exec with replace";
                };
              };
            };
            default = {};
            description = "Exec-replace snippet configuration";
          };

          render = lib.mkOption {
            type = lib.types.submodule {
              options = {
                threads = lib.mkOption {
                  type = lib.types.int;
                  default = 2;
                  description = "Number of render threads";
                };
              };
            };
            default = {};
            description = "Render configuration for snippets";
          };
        };
      };
      default = {};
      description = "Snippet configuration";
    };

    mermaid = lib.mkOption {
      type = lib.types.submodule {
        options = {
          scale = lib.mkOption {
            type = lib.types.int;
            default = 2;
            description = "Scale factor for mermaid diagrams";
          };
        };
      };
      default = {};
      description = "Mermaid configuration";
    };

    d2 = lib.mkOption {
      type = lib.types.submodule {
        options.scale = lib.mkOption {
          type = lib.types.int;
          default = 2;
          description = "Scale factor for d2 diagrams";
        };
      };
      default = {};
      description = "d2 configuration";
    };

    speaker_notes = lib.mkOption {
      type = lib.types.submodule {
        options = {
          always_publish = lib.mkOption {
            type = lib.types.bool;
            default = false;
            description = "Publish speaker notes";
          };
        };
      };
      default = {};
      description = "Speaker notes configuration";
    };

    export = lib.mkOption {
      type = lib.types.submodule {
        options = {
          dimensions = lib.mkOption {
            type = lib.types.submodule {
              options = {
                columns = lib.mkOption {
                  type = lib.types.int;
                  default = 80;
                  description = "Number of columns in export";
                };
                rows = lib.mkOption {
                  type = lib.types.int;
                  default = 30;
                  description = "Number of rows in export";
                };
              };
            };
            default = {};
            description = "Dimensions for export";
          };

          pauses = lib.mkOption {
            type = lib.types.enum ["ignore" "new_slide"];
            default = "ignore";
            description = "How pauses are handled in export";
          };

          snippets = lib.mkOption {
            type = lib.types.enum ["sequential" "parallel"];
            default = "sequential";
            description = "How snippets are executed in export";
          };

          pdf = lib.mkOption {
            type = lib.types.submodule {
              options = {
                fonts = lib.mkOption {
                  type = lib.types.submodule {
                    options = {
                      normal = lib.mkOption {
                        type = lib.types.nullOr lib.types.path;
                        default = null;
                        description = "Normal font";
                      };
                      italic = lib.mkOption {
                        type = lib.types.nullOr lib.types.path;
                        default = null;
                        description = "Italic font";
                      };
                      bold = lib.mkOption {
                        type = lib.types.nullOr lib.types.path;
                        default = null;
                        description = "Bold font";
                      };
                      bold_italic = lib.mkOption {
                        type = lib.types.nullOr lib.types.path;
                        default = null;
                        description = "Bold italic font";
                      };
                    };
                  };
                  default = {};
                  description = "PDF font configuration";
                };
              };
            };
            default = {};
            description = "PDF export configuration";
          };
        };
      };
      default = {};
      description = "Export configuration";
    };

    options = lib.mkOption {
      type = lib.types.submodule {
        options = {
          implicit_slide_ends = lib.mkOption {
            type = lib.types.bool;
            default = false;
            description = "Enable implicit end slides";
          };
          end_slide_shorthand = lib.mkOption {
            type = lib.types.bool;
            default = false;
            description = "Enable shorthand for end slides";
          };
          command_prefix = lib.mkOption {
            type = lib.types.str;
            default = "";
            description = "Prefix for commands";
          };
          incremental_lists = lib.mkOption {
            type = lib.types.bool;
            default = false;
            description = "Enable incremental lists globally";
          };
          strict_front_matter_parsing = lib.mkOption {
            type = lib.types.bool;
            default = true;
            description = "Strict front matter parsing";
          };
          image_attributes_prefix = lib.mkOption {
            type = lib.types.str;
            default = "image:";
            description = "Prefix for image attributes";
          };
          auto_render_languages = lib.mkOption {
            type = lib.types.listOf lib.types.str;
            default = [];
            description = "Languages to auto-render (e.g., mermaid)";
          };
          list_item_newlines = lib.mkOption {
            type = lib.types.int;
            default = 1;
            description = "Number of newlines between list items";
          };
        };
      };
      default = {};
      description = "General options";
    };
  };

  config = lib.mkIf config.unstable-presenterm.enable {
    home.packages = [pkgs-unstable.presenterm];
    home.sessionVariables = {
      PRESENTERM_CONFIG_FILE = "${config.xdg.configHome}/presenterm/config.yaml";
    };

    xdg.configFile.${cfgPath}.source = yamlFormat.generate "presenterm-config" (
      cleanAttrs {
        defaults = config.unstable-presenterm.defaults;
        export = config.unstable-presenterm.export;
        options = config.unstable-presenterm.options;
        snippet = config.unstable-presenterm.snippet;
        bindings = config.unstable-presenterm.bindings;
        mermaid = config.unstable-presenterm.mermaid;
        d2 = config.unstable-presenterm.d2;
        speaker_notes = config.unstable-presenterm.speaker_notes;
        transition = config.unstable-presenterm.transition;
      }
    );
  };
}
