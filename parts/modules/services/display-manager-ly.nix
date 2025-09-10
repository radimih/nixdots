{
  flake.modules.nixos.service-display-manager-ly = {

    services.displayManager.ly = {
      enable = true;
      settings = {
        animation = "matrix";
        clock = "%d.%m.%Y %T";
        vi_mode = true;
      };
      # TODO: попробовать новый параметр: https://github.com/NixOS/nixpkgs/commit/17260c31264ea0de35594e9bb28770972cdb74d0
      # x11Support = false;
    };
  };
}
