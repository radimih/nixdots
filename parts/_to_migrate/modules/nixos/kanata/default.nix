{
  config,
  lib,
  ...
}:

let
  cfg = config.modules.kanata;
in
{
  options.modules.kanata = {

    enable = lib.mkEnableOption "Keyboard customization by https://github.com/jtroo/kanata";

    # TODO: горячие клавиши для переключения раскладок через опции модуля
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
