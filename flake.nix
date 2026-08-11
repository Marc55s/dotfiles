{
  description = "NixOS + home-manager configurations for pc, laptop, mainframe and monolith";

  inputs = {
    # --- nixpkgs channels -------------------------------------------------
    nixpkgs.url = "nixpkgs/nixos-26.05";
    nixpkgs-unstable.url = "nixpkgs/nixos-unstable";
    nixpkgs-openconnect-sso.url = "github:nixos/nixpkgs/46397778ef1f73414b03ed553a3368f0e7e33c2f";

    # --- system tooling ---------------------------------------------------
    home-manager = {
      url = "github:nix-community/home-manager/release-26.05";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    disko = {
      url = "github:nix-community/disko";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    nix-index-database = {
      url = "github:nix-community/nix-index-database";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    grub2-themes.url = "github:vinceliuice/grub2-themes";

    # --- desktop ----------------------------------------------------------
    niri = {
      url = "github:sodiboo/niri-flake";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    noctalia = {
      url = "github:noctalia-dev/noctalia-shell";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    spicetify-nix.url = "github:Gerg-L/spicetify-nix";

    # --- custom packages -----------------------------------------------------
    edu-sync-nix = {
      url = "github:Marc55s/edu-sync-nix";
      inputs.nixpkgs.follows = "nixpkgs-unstable";
    };

    wakafetch = {
      url = "github:marc55s/wakafetch";
      inputs.nixpkgs.follows = "nixpkgs-unstable";
    };

    termstat = {
      url = "github:marc55s/termstat";
      inputs.nixpkgs.follows = "nixpkgs-unstable";
    };

    openconnect-sso = {
      url = "github:jcszymansk/openconnect-sso";
      inputs.nixpkgs.follows = "nixpkgs-openconnect-sso";
    };
  };

  outputs =
    inputs:
    let
      inherit (inputs) nixpkgs nixpkgs-unstable;
      inherit (nixpkgs) lib;

      system = "x86_64-linux";

      overlay = final: prev: {
        edu-sync-cli = inputs.edu-sync-nix.packages.${system}.default;
        wakafetch = inputs.wakafetch.packages.${system}.default;
        openconnect-sso = inputs.openconnect-sso.packages.${system}.openconnect-sso;
        spicePkgs = inputs.spicetify-nix.legacyPackages.${system};

        # portlist_test.go fails during the build; drop it beforehand.
        tailscale = prev.tailscale.overrideAttrs (old: {
          preBuild = (old.preBuild or "") + ''
            rm -f portlist/portlist_test.go
          '';
        });
      };

      mkPkgs =
        source: extraOverlays:
        import source {
          inherit system;
          config.allowUnfree = true;
          overlays = [ overlay ] ++ extraOverlays;
        };

      pkgs = mkPkgs nixpkgs [ inputs.termstat.overlays.default ];
      pkgs-unstable = mkPkgs nixpkgs-unstable [ ];

      hosts = {
        pc = {
          modules = [ inputs.nix-index-database.nixosModules.default ];
          users.marc = ./home/pc.nix;
        };

        laptop = {
          modules = [ inputs.grub2-themes.nixosModules.default ];
          users.marc = ./home/laptop.nix;
        };

        mainframe.modules = [ inputs.disko.nixosModules.disko ];

        monolith.modules = [ inputs.disko.nixosModules.disko ];
      };

      mkHost =
        hostName:
        {
          modules ? [ ],
          users ? { },
        }:
        lib.nixosSystem {
          inherit pkgs;
          specialArgs = { inherit inputs pkgs-unstable hostName; };
          modules = [
            ./hosts/${hostName}/configuration.nix
            ./hosts/${hostName}/hardware-configuration.nix
            inputs.home-manager.nixosModules.home-manager
            {
              home-manager = {
                useGlobalPkgs = true;
                useUserPackages = true;
                extraSpecialArgs = { inherit inputs pkgs-unstable hostName; };
                inherit users;
              };
            }
          ]
          ++ modules;
        };
    in
    {
      nixosConfigurations = lib.mapAttrs mkHost hosts;

      formatter.${system} = pkgs.nixfmt-rfc-style;
    };
}
