{
    description = "A very basic flake";

    inputs = {
        nixpkgs.url = "nixpkgs/nixos-25.05";
        nixpkgs-unstable.url = "nixpkgs/nixos-unstable";
        nixpkgs-24_11.url = "nixpkgs/nixos-24.11";

        home-manager = {
            url = "github:nix-community/home-manager/release-25.05";
            inputs.nixpkgs.follows = "nixpkgs";
        };

        grub2-themes = {
            url = "github:vinceliuice/grub2-themes";
        };

        todo-shell = {
            url = "github:itsanian/todo-shell";
        };

        edu-sync-nix = {
            url = "github:Marc55s/edu-sync-nix";
        };
    };

    outputs = inputs@{self, nixpkgs, nixpkgs-unstable, home-manager, todo-shell, grub2-themes, ... }:
        let
            system = "x86_64-linux";

            overlay = final: prev: {
                edu-sync-cli = inputs.edu-sync-nix.packages.${system}.default;
            };

            pkgs = import nixpkgs {
                inherit system;
                config = { allowUnfree = true; };
                overlays = [ overlay ];
            };

            pkgs-unstable = import nixpkgs-unstable {
                inherit system;
                config = { allowUnfree = true; };
                overlays = [ overlay ];
            };

            lib = nixpkgs.lib;
        in {
            nixosConfigurations = {
                pc = lib.nixosSystem {
                    inherit system pkgs;
                    modules = [
                        ./hosts/pc/configuration.nix
                        ./hosts/pc/hardware-configuration.nix
                        home-manager.nixosModules.home-manager
                        {
                            home-manager.useGlobalPkgs = true;
                            home-manager.useUserPackages = true;
                            home-manager.users.marc = import ./home/pc.nix;
                            home-manager.extraSpecialArgs = {
                                inherit inputs pkgs-unstable;
                                hostName = "pc";
                            };

                        }
                    ];
                };

                laptop = lib.nixosSystem {
                    inherit system pkgs;
                    modules = [
                        grub2-themes.nixosModules.default
                        ./hosts/laptop/configuration.nix
                        ./hosts/laptop/hardware-configuration.nix
                        home-manager.nixosModules.home-manager
                        {
                            home-manager.useGlobalPkgs = true;
                            home-manager.useUserPackages = true;
                            home-manager.users.marc = import ./home/laptop.nix;
                            home-manager.extraSpecialArgs = {
                                inherit inputs pkgs-unstable;
                                hostName = "laptop";
                            };
                        }
                    ];
                };
            };
        };
}
