# Keyboard customization by https://github.com/jtroo/kanata
{
  flake.modules.nixos.service-kanata = {

    # TODO: горячие клавиши для переключения раскладок через опции модуля

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
