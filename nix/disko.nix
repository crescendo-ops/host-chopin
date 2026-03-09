{lib, ...}: {
  disko.devices = {
    disk.main = {
      type = "disk";
      device = lib.mkDefault "/dev/nvme0n1";
      content = {
        type = "gpt";
        partitions = {
          ESP = {
            name = "EFI";
            size = "1G";
            type = "EF00";
            content = {
              type = "filesystem";
              format = "vfat";
              mountpoint = "/boot";
              mountOptions = ["umask=0077"];
            };
          };

          swap = {
            name = "SWAP";
            size = "32G";
            type = "8200";
            content = {
              type = "swap";
              resumeDevice = true;
            };
          };

          zfs = {
            name = "ZFS";
            size = "100%";
            content = {
              type = "zfs";
              pool = "zroot";
            };
          };
        };
      };
    };

    zpool.zroot = {
      type = "zpool";
      options = {
        ashift = "12";
        autotrim = "on";
      };
      rootFsOptions = {
        acltype = "posixacl";
        compression = "zstd";
        dnodesize = "auto";
        normalization = "formD";
        relatime = "on";
        xattr = "sa";
        mountpoint = "none";
      };
      datasets = {
        "root" = {
          type = "zfs_fs";
          mountpoint = null;
          options.mountpoint = "none";
        };
        "root/nixos" = {
          type = "zfs_fs";
          mountpoint = "/";
          options.canmount = "noauto";
        };
        "nix" = {
          type = "zfs_fs";
          mountpoint = "/nix";
        };
        "var/lib" = {
          type = "zfs_fs";
          mountpoint = "/var/lib";
        };
      };
    };
  };
}
