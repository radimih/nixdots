{
  pkgs,
  ...
}:

{
  flake.modules.hosts.vm-test.boot = {

    # kernelPackages = pkgs.linuxPackages_latest;
    kernelParams = [
    ];

    loader = {
      timeout = 0;
      grub = {
        enable = true;
        device = "/dev/vda";
        useOSProber = true;
      };
    };

  };
}
