{
  config,
  pkgs,
  ...
}:

{
  flake.modules.nixos.host-vm-test = {

    imports = with config.flake.modules.nixos; [
      base
    ];

    boot = {
      kernelPackages = pkgs.linuxPackages_latest;
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
