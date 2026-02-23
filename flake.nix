{
  description = "Heuzef NixOS-Config";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    sops-nix = {
      url = "github:Mic92/sops-nix";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = { self, nixpkgs, home-manager, sops-nix, ... }@inputs:
    let
      system = "x86_64-linux";
      lib = nixpkgs.lib;
    in {
      nixosConfigurations = {

        # Generate Hardware config : sudo nixos-generate-config --show-hardware-config
        # Printers : https://nixos.wiki/wiki/Printing

        # pgmr
        pgmr = lib.nixosSystem {
          inherit system;
          modules = [
            ./configuration.nix
            ./software/docker/docker.nix
            ./software/obs/obs.nix
            ./software/python/python.nix
            ./software/steam/steam.nix
            ./software/vscodium/vscodium.nix
            ./hardware/pgmr.nix
            ./hardware/printers.nix
            home-manager.nixosModules.home-manager {
              networking.hostName = "pgmr";
              home-manager.useGlobalPkgs = true;
              home-manager.useUserPackages = true;
              home-manager.sharedModules = [ inputs.sops-nix.homeManagerModules.sops ];
              home-manager.users.heuzef = {
                imports = [
                  ./home.nix
                  ./software/zed/zed.nix
                ];
              };
            }
          ];
        };

        # x240
        x240 = lib.nixosSystem {
          inherit system;
          modules = [
            ./configuration.nix
            ./software/python/python.nix
            ./hardware/x240.nix # sudo nixos-generate-config --show-hardware-config
            ./hardware/printers.nix # https://nixos.wiki/wiki/Printing
            home-manager.nixosModules.home-manager
            {
              networking.hostName = "x240";
              home-manager.useGlobalPkgs = true;
              home-manager.useUserPackages = true;
              home-manager.sharedModules = [ inputs.sops-nix.homeManagerModules.sops ];
              home-manager.users.heuzef = import ./home.nix;
            }
          ];
        };

        # latitude3380
        latitude3380 = lib.nixosSystem {
          inherit system;
          modules = [
            ./configuration.nix
            ./software/python/python.nix
            ./hardware/latitude3380.nix # sudo nixos-generate-config --show-hardware-config
            ./hardware/printers.nix # https://nixos.wiki/wiki/Printing
            home-manager.nixosModules.home-manager
            {
              networking.hostName = "latitude3380";
              home-manager.useGlobalPkgs = true;
              home-manager.useUserPackages = true;
              home-manager.sharedModules = [ inputs.sops-nix.homeManagerModules.sops ];
              home-manager.users.heuzef = import ./home.nix;
            }
          ];
        };
      };
    };
}
