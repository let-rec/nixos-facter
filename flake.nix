{
  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs?ref=nixos-unstable";

    # nixos-facter.url = "github:nix-community/nixos-facter";

    disko = {
      url = "github:nix-community/disko";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = {self, nixpkgs, disko, ...}: 
    {
      nixosConfigurations.nixos = nixpkgs.lib.nixosSystem {
        system = "x86_64-linux";
        modules = [
          disko.nixosModules.disko
          ./disko.nix

          # nixos-facter.nixosModules.facter
          # ./hardware-facter.nix
          {
            hardware.facter.reportPath = ./facter.json;
          }

          ./configuration.nix
        ];
        # specialArgs = { inherit inputs; };
      };
    };
}
