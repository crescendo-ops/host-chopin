{...}: {
  networking.useNetworkd = true;
  networking.useDHCP = true;

  # Set this per interface in host-level config if needed.
  networking.interfaces = {};

  networking.firewall = {
    enable = true;
    allowedTCPPorts = [22];
  };
}
