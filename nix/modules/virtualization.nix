{ lib, pkgs, ... }:
{
  virtualisation.libvirtd.enable = true;

  programs.virt-manager.enable = false;

  boot.kernelModules = [ "kvm-amd" "kvm-intel" ];

  # Upstream libvirt unit uses /usr/bin/sh, which is not present on NixOS.
  systemd.services.virt-secret-init-encryption.serviceConfig.ExecStart = lib.mkForce [
    ""
    "${pkgs.runtimeShell} -c 'umask 0077 && (dd if=/dev/random status=none bs=32 count=1 | systemd-creds encrypt --name=secrets-encryption-key - /var/lib/libvirt/secrets/secrets-encryption-key)'"
  ];
  systemd.services.virt-secret-init-encryption.serviceConfig.ExecStartPre = lib.mkForce [
    "+${pkgs.coreutils}/bin/mkdir -p /var/lib/libvirt/secrets"
    "+${pkgs.coreutils}/bin/chmod 0700 /var/lib/libvirt/secrets"
  ];
}
