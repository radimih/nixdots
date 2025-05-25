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
}
