{
    description = "A very basic flake";

    inputs = {
        nixpkgs.url = "nixpkgs/nixos-25.05";
        nixpkgs-unstable.url = "nixpkgs/nixos-unstable";
        nixpkgs-24_11.url = "nixpkgs/nixos-24.11";

        hyprpanel = {
            url = "github:Jas-SinghFSU/HyprPanel/94a00a49dae15c87e4234c9962295aed2b0dc45e";
            inputs.nixpkgs.follows = "nixpkgs";
        };

        home-manager = {
            url = "github:nix-community/home-manager/release-25.05";
            inputs.nixpkgs.follows = "nixpkgs";
        };

        todo-shell = {
            url = "github:itsanian/todo-shell";
        };

        #spicetify-nix.url = "github:Gerg-L/spicetify-nix"; 
    };

    outputs = inputs@{self, nixpkgs, nixpkgs-unstable, home-manager, todo-shell, ... }:
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
