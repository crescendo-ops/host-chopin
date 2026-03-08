{ lib, pkgs, ... }:
{
  imports = [
    ./disko.nix
    ./hardware-configuration.nix
    ./network.nix
    ../../profiles/server-common.nix
    ../../profiles/vm-host.nix
    ../../profiles/router-vm-host.nix
  ];

  networking.hostName = "chopin";
  networking.hostId = "c10f1a01";
  nixpkgs.hostPlatform = lib.mkDefault "x86_64-linux";

  boot = {
    supportedFilesystems = [ "zfs" ];
    zfs.devNodes = "/dev/disk/by-partlabel";
    kernelParams = [ "amd_iommu=on" "iommu=pt" ];
    loader = {
      systemd-boot.enable = true;
      efi.canTouchEfiVariables = true;
    };
  };

  zramSwap = {
    enable = true;
    memoryPercent = 25;
  };

  # Keep this host optimized for low power and quiet operation.
  powerManagement.cpuFreqGovernor = "powersave";

  # Ensure the shared parent dataset for VM zvols exists on already-provisioned hosts.
  systemd.services.zfs-create-vm-disks = {
    description = "Ensure zroot/vm-disks dataset exists";
    wantedBy = [ "multi-user.target" ];
    after = [ "zfs-import.target" ];
    path = [ pkgs.zfs ];
    serviceConfig = {
      Type = "oneshot";
      RemainAfterExit = true;
    };
    script = ''
      if ! zfs list -H -o name zroot/vm-disks >/dev/null 2>&1; then
        zfs create -p -o mountpoint=none zroot/vm-disks
      fi
    '';
  };

  system.stateVersion = "25.11";
}
