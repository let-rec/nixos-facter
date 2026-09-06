{
  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs?ref=nixos-unstable";

    nixos-facter.url = "github:nix-community/nixos-facter";

    disko.url = "github:nix-community/disko";
    disko.inputs.nixpkgs.follows = "nixpkgs";
  };

  outputs = {self, nixpkgs, nixos-facter, disko, ...}@inputs: {
    nixosConfigurations.cooked = nixpkgs.lib.nixosSystem {
      system = "x86_64-linux";
      modules = [
        disko.nixosModules.disko
        ./diskol.nix

        nixos-facter.nixosModules.facter
        ./hardware-facter.nix

        ./configuration.nix
      ];
      specialArgs = { inherit inputs; };
    };
  };
}
