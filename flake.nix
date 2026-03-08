{
  description = "Home infrastructure: NixOS hosts, VMs, and infra tooling";

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
            ./nix/hosts/chopin
          ];
        };

        beethoven = lib.nixosSystem {
          inherit system;
          specialArgs = { inherit self inputs; hostName = "beethoven"; };
          modules = [
            ./nix/hosts/beethoven
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
