{ lib, ... }:
{
  # Keep DHCP only on the bridge used by the host and VMs.
  networking.useDHCP = lib.mkForce false;

  networking.bridges = {
    brMgmt.interfaces = [ "enp9s0" ];
    brVyos.interfaces = [ "enp1s0f1" ];
  };

  # `networking.bridges` does not expose VLAN filtering, so set it via networkd.
  systemd.network.netdevs."40-brVyos".bridgeConfig.VLANFiltering = true;

  networking.interfaces = {
    brMgmt.useDHCP = true;
    enp9s0.useDHCP = false;
    enp1s0f0.useDHCP = false;
    enp1s0f1.useDHCP = false;
    brVyos.useDHCP = false;
  };

  # Allow libvirt-managed networks to attach guests to this bridge.
  virtualisation.libvirtd.allowedBridges = [ "brMgmt" "brVyos" ];
}
