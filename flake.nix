{
    description = "A very basic flake";

    inputs = {
        hyprpanel.url = "github:Jas-SinghFSU/HyprPanel";
        hyprpanel.inputs.nixpkgs.follows = "nixpkgs";
        nixpkgs.url = "nixpkgs/nixos-24.11";
        home-manager.url = "github:nix-community/home-manager/release-24.11";
        home-manager.inputs.nixpkgs.follows = "nixpkgs";
        nixpkgs-unstable.url = "nixpkgs/nixos-unstable";
    };

    outputs = { nixpkgs, nixpkgs-unstable, home-manager, ... }@inputs:
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
                nixos = lib.nixosSystem {
                    inherit system pkgs;
                    modules = [
                        (import ./configuration.nix {inherit pkgs pkgs-unstable;})
                        ./hardware-configuration.nix
                        home-manager.nixosModules.home-manager
                        {
                            home-manager.useGlobalPkgs = true;
                            home-manager.useUserPackages = true;
                            home-manager.users.marc = import ./home.nix;
                            home-manager.extraSpecialArgs = {
                                inherit pkgs-unstable;
                            };

                        }
                    ];
                };
            };
        };
}
