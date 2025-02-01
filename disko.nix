{
  disko.devices = {
    disk = {
      main = {
        device = "/dev/nvme0n1";
        content = {
          type = "gpt";

          partitions = {
            biosboot = {
              size = "1M";
              type = "EF02"; # BIOS Boot Partition for GRUB (for BIOS mode)
            };

            ESP = {
              size = "768M";
              type = "EF00"; # EFI System Partition (for UEFI mode)
              content = {
                type = "filesystem";
                format = "vfat";
                mountpoint = "/boot";
                mountOptions = ["umask=0077"];
              };
            };

            luks = {
              name = "luks";
              end = "-64G"; # Leave 64GB for swap at the end
              content = {
                type = "luks";
                name = "crypted";
                passwordFile = "/tmp/secret.key";
                content = {
                  type = "btrfs";
                  extraArgs = ["-f"];
                  subvolumes = {
                    "/root" = {
                      mountpoint = "/";
                      mountOptions = ["compress=zstd" "noatime"];
                    };
                    "/home" = {
                      mountpoint = "/home";
                      mountOptions = ["noatime"];
                    };
                    "/nix" = {
                      mountpoint = "/nix";
                      mountOptions = ["compress=zstd" "noatime"];
                    };
                    "/var" = {
                      mountpoint = "/var";
                      mountOptions = ["compress=zstd" "noatime"];
                    };
                  };
                };
              };
            };

            swap = {
              size = "64G";
              content = {
                type = "swap";
                resumeDevice = true;
                discardPolicy = "both";
              };
            };
          };
        };
      };
    };
  };
}
