{
  pkgs,
  ...
}:

{
  imports = [
    ./hardware-configuration.nix
    ./../_common
  ];

  boot.loader.grub = {
    enable = true;
    device = "/dev/vda";
    useOSProber = true;
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

  modules.desktop.enable = true;
}
