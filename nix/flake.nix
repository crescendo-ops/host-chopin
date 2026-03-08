{
  description = "Chopin host configuration and upgrade artifact tooling";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    disko = {
      url = "github:nix-community/disko";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = inputs@{ self, nixpkgs, ... }:
    let
      system = "x86_64-linux";
      lib = nixpkgs.lib;
      pkgsFor = system: import nixpkgs { inherit system; };
    in {
      nixosConfigurations = {
        chopin = lib.nixosSystem {
          inherit system;
          specialArgs = { inherit self inputs; hostName = "chopin"; };
          modules = [
            inputs.disko.nixosModules.disko
            ./default.nix
          ];
        };
      };

      devShells.${system}.default =
        let pkgs = pkgsFor system;
        in pkgs.mkShell {
          packages = with pkgs; [
            alejandra
            git
            nil
            nixd
            sops
            age
            terraform
          ];
        };

      formatter.${system} = (pkgsFor system).alejandra;
    };
}
