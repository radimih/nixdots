{
  config,
  ...
}:

{
  flake.modules.nixos.host-vm-test =
    { pkgs, ...}:
    {
      boot = {
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

      environment.systemPackages = with pkgs; [
        vim
      ];

      imports = with config.flake.modules.nixos; [
        base
        sound
      ];
  };
}
