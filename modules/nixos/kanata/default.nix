{
  config,
  lib,
  ...
}:

let
  cfg = config.keyboard.kanata;
in
{
  options.keyboard.kanata = {

    enable = lib.mkEnableOption "Keyboard customization by https://github.com/jtroo/kanata";

  };

  config = lib.mkIf cfg.enable {

    services.kanata = {
      enable = true;
      keyboards = {
        default = {
        config = builtins.readFile ./kanata.kbd;
        extraDefCfg = ''
          process-unmapped-keys yes
        '';
        };
      };
    };

  };
}
