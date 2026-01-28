# https://github.com/fairyglade/ly
{
  flake.modules.nixos.service-display-manager-ly = {

    services.displayManager.ly = {
      enable = true;
      settings = {
        animation = "matrix";
        clock = "%d.%m.%Y %T";
        vi_mode = true;
      };
      x11Support = false;
    };
  };
}
