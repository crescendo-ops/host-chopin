{ ... }:
{
  imports = [
    ../modules/nixos/base.nix
    ../modules/nixos/networking.nix
    ../modules/nixos/users.nix
    ../modules/nixos/ops-tools.nix
    ../modules/nixos/monitoring.nix
  ];
}
