# Enable sound with PipeWire
{
  flake.modules.nixos.sound = {

    security.rtkit.enable = true;

    services = {
      pipewire = {
        enable = true;
        alsa.enable = true;
        jack.enable = true;
        pulse.enable = true;
      };
      pulseaudio.enable = false;
    };
  };
}
