{
  config,
  pkgs,
  globalSpec,
  inputs,
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

  environment.systemPackages = with pkgs; [
    wget
  ];

  services.displayManager.ly = {
    enable = true;
    settings = {
      animation = "doom";
      clock = "%d.%m.%Y %T";
      vi_mode = true;
    };
  };
}
