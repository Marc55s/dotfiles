{ pkgs, ... }:

let
  lock-false = {
    Value = false;
    Status = "locked";
  };
  lock-true = {
    Value = true;
    Status = "locked";
  };
in {
  programs.firefox = {
    enable = true;
    languagePacks = [ "de" "en-US" ];

    # ---- 1. POLICIES (Global & Extensions) ----
    policies = {
      DisableTelemetry = true;
      DisableFirefoxStudies = true;
      EnableTrackingProtection = {
        Value = true;
        Locked = true;
        Cryptomining = true;
        Fingerprinting = true;
      };
      DisablePocket = true;
      DisableFirefoxAccounts = true;
      DisableAccounts = true;
      DisableFirefoxScreenshots = true;
      OverrideFirstRunPage = "";
      OverridePostUpdatePage = "";
      DontCheckDefaultBrowser = false;
      DisplayBookmarksToolbar = "always";

      # ---- EXTENSIONS ----
      ExtensionSettings = {
        "*".installation_mode = "allowed";
        allow_types = [ "theme" "locale" ];

        # Themes
        "{51fd00e2-c195-4740-824f-c8e789b1c066}" = {
          install_url =
            "https://addons.mozilla.org/firefox/downloads/latest/praisethesun/latest.xpi";
          installation_mode = "force_installed";
        };
        # uBlock Origin
        "uBlock0@raymondhill.net" = {
          install_url =
            "https://addons.mozilla.org/firefox/downloads/latest/ublock-origin/latest.xpi";
          installation_mode = "force_installed";
        };
        # Privacy Badger
        "jid1-MnnxcxisBPnSXQ@jetpack" = {
          install_url =
            "https://addons.mozilla.org/firefox/downloads/latest/privacy-badger17/latest.xpi";
          installation_mode = "force_installed";
        };
        # Bitwarden
        "{446900e4-71c2-419f-a6a7-df9c091e268b}" = {
          install_url =
            "https://addons.mozilla.org/firefox/downloads/latest/bitwarden-password-manager/latest.xpi";
          installation_mode = "force_installed";
        };
        # Dark Reader
        "dark-reader@darkreader.org" = {
          install_url =
            "https://addons.mozilla.org/firefox/downloads/latest/darkreader/latest.xpi";
          installation_mode = "force_installed";
        };
        # Simple Translate
        "simple-translate@sienori" = {
          install_url =
            "https://addons.mozilla.org/firefox/downloads/latest/simple-translate/latest.xpi";
          installation_mode = "force_installed";
        };
        # Zotero
        "zotero@chnm.gmu.edu" = {
          install_url =
            "https://www.zotero.org/download/connector/dl?browser=firefox";
          installation_mode = "force_installed";
        };
      };

      # ---- PREFERENCES ----
      Preferences = {
        "browser.contentblocking.category" = {
          Value = "strict";
          Status = "locked";
        };
        "extensions.pocket.enabled" = lock-false;
        "extensions.screenshots.disabled" = lock-true;
        "browser.topsites.contile.enabled" = lock-false;
        "browser.formfill.enable" = lock-false;
        "browser.search.suggest.enabled" = lock-true;
        "browser.search.suggest.enabled.private" = lock-false;
        "browser.ml.enable" = false;
        "browser.ml.chat.enabled" = false;
        "browser.urlbar.suggest.searches" = lock-true;
        "browser.urlbar.showSearchSuggestionsFirst" = lock-true;
        "browser.newtabpage.activity-stream.feeds.section.topstories" =
          lock-false;
        "browser.newtabpage.activity-stream.feeds.snippets" = lock-false;
        "browser.newtabpage.activity-stream.section.highlights.includePocket" =
          lock-false;
        "browser.newtabpage.activity-stream.section.highlights.includeBookmarks" =
          lock-false;
        "browser.newtabpage.activity-stream.section.highlights.includeDownloads" =
          lock-false;
        "browser.newtabpage.activity-stream.section.highlights.includeVisited" =
          lock-false;
        "browser.newtabpage.activity-stream.showSponsored" = lock-false;
        "browser.newtabpage.activity-stream.system.showSponsored" = lock-false;
        "browser.newtabpage.activity-stream.showSponsoredTopSites" = lock-false;
        "privacy.firstparty.isolate" = lock-true;
      };
    };

    # ---- 2. PROFILES ----
    profiles.default = {
      id = 0;
      name = "default";
      isDefault = true;

      settings = {
        "extensions.activeThemeID" = "{51fd00e2-c195-4740-824f-c8e789b1c066}";
        "lightweightThemes.selectedID" = "{51fd00e2-c195-4740-824f-c8e789b1c066}";
        "browser.startup.homepage" = "https://www.ecosia.org/";
        "browser.newtabpage.enabled" = false;
        "signon.rememberSignons" = false;
        "signon.autofillForms" = false;
        "ui.systemUsesDarkTheme" = 1;
        "browser.theme.contenttheme" = 0;
      };

      search = {
        force = true;
        default = "ecosia";
        privateDefault = "ecosia";

        engines = {
          "ecosia" = {
            urls =
              [{ template = "https://www.ecosia.org/search?q={searchTerms}"; }];
            icon = "https://cdn.ecosia.org/assets/images/ico/favicon.ico";
            updateInterval = 24 * 60 * 60 * 1000;
            definedAliases = [ "@e" ];
          };

          "google".metaData.alias = "@g";

          "Nix Packages" = {
            urls = [{
              template = "https://search.nixos.org/packages";
              params = [{
                name = "query";
                value = "{searchTerms}";
              }];
            }];
            icon =
              "${pkgs.nixos-icons}/share/icons/hicolor/scalable/apps/nix-snowflake.svg";
            definedAliases = [ "@np" ];
          };

        };
      };

      bookmarks = {
        force = true;
        settings = [{
          name = "Toolbar";
          toolbar = true;
          bookmarks = [
            {
              name = "GitHub";
              url = "https://github.com";
            }
            {
              name = "Gmail";
              url = "https://mail.google.com";
            }
            {
              name = "Research";
              bookmarks = [
                {
                  name = "Semantic Scholar";
                  url = "https://www.semanticscholar.org/";
                }
                {
                  name = "Google Scholar";
                  url = "https://scholar.google.com/";
                }
                {
                  name = "Ebsco";
                  url = "https://research.ebsco.com/";
                }
              ];
            }
            {
              name = "AI";
              bookmarks = [
                {
                  name = "Gemini";
                  url = "https://gemini.google.com";
                }
                {
                  name = "NotebookLM";
                  url = "https://notebooklm.google.com";
                }
                {
                  name = "Collab";
                  url = "https://colab.research.google.com/";
                }
              ];
            }
            {
              name = "Semester Paper";
              bookmarks = [{
                name = "Gitlab";
                url =
                  "https://gitlab.dhbw-heidenheim.de/projects26/ultimate-tic-tac-toe";
              }];
            }
            {
              name = "Study";
              bookmarks = [
                {
                  name = "Moodle DHBW";
                  url = "https://moodle.heidenheim.dhbw.de/";
                }
                {
                  name = "Office";
                  url = "https://www.office.com/";
                }
                {
                  name = "Dualis";
                  url = "https://dualis.dhbw.de/";
                }
              ];
            }
          ];
        }];
      };
    };
  };
}
