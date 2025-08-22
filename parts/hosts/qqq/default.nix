{
  config,
  ...
}:

{
  flake.modules.nixos.host-qqq =
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

      imports = with config.flake.modules.nixos; [
        base
      ];

      # Enable sound with PipeWire
      services.pulseaudio.enable = false;
      security.rtkit.enable = true;
      services.pipewire = {
        enable = true;
        alsa.enable = true;
        alsa.support32Bit = true;
        pulse.enable = true;
      };
  };
}
