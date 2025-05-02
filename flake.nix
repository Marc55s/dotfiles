{
    description = "A very basic flake";

    inputs = {
        hyprpanel = {
            url = "github:Jas-SinghFSU/HyprPanel";
            inputs.nixpkgs.follows = "nixpkgs";
        };

        home-manager = {
            url = "github:nix-community/home-manager/release-24.11";
            inputs.nixpkgs.follows = "nixpkgs";
        };

        todo-shell = {
            url = "github:itsanian/todo-shell";
        };

        nixpkgs.url = "nixpkgs/nixos-24.11";
        nixpkgs-unstable.url = "nixpkgs/nixos-unstable";
        textfox.url = "github:adriankarlen/textfox";
    };

    outputs = inputs@{self, nixpkgs, nixpkgs-unstable, home-manager, textfox, todo-shell, ... }:
        let
            system = "x86_64-linux";
            pkgs = import nixpkgs {
                inherit system;
                config = { allowUnfree = true; };
                overlays = [
                    inputs.hyprpanel.overlay
                ];
            };

            pkgs-unstable = import nixpkgs-unstable {
                inherit system;
                config = { allowUnfree = true; };
            };

            lib = nixpkgs.lib;
        in {
            nixosConfigurations = {
                white = lib.nixosSystem {
                    inherit system pkgs;
                    modules = [
                        ./hosts/white/configuration.nix
                        ./hosts/white/hardware-configuration.nix
                        home-manager.nixosModules.home-manager
                        {
                            home-manager.useGlobalPkgs = true;
                            home-manager.useUserPackages = true;
                            home-manager.users.mc = import ./home/white.nix;
                            home-manager.extraSpecialArgs = {
                                inherit inputs pkgs-unstable;
                            };

                        }
                    ];
                };

                black = lib.nixosSystem {
                    inherit system pkgs;
                    modules = [
                        ./hosts/black/configuration.nix
                        ./hosts/black/hardware-configuration.nix
                        home-manager.nixosModules.home-manager
                        {
                            home-manager.useGlobalPkgs = true;
                            home-manager.useUserPackages = true;
                            home-manager.users.marc = import ./home/black.nix;
                            home-manager.extraSpecialArgs = {
                                inherit inputs pkgs-unstable;
                            };

                        }
                    ];
                };
            };
        };
}
