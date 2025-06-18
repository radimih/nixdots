{
  pkgs,
  ...
}:

{
  # Установить шрифт для текстовой консоли (/dev/ttyN) с поддержкой кириллицы
  console = {
    font = "ter-u16n";  # "UniCyr_8x16" - вариант шрифта из стандартной поставки
    packages = [ pkgs.terminus_font ];
  };

  i18n = {
    defaultLocale = "en_US.UTF-8";
    extraLocaleSettings = {
      LC_ADDRESS = "ru_RU.UTF-8";
      LC_IDENTIFICATION = "ru_RU.UTF-8";
      LC_MEASUREMENT = "ru_RU.UTF-8";
      LC_MONETARY = "ru_RU.UTF-8";
      LC_NAME = "ru_RU.UTF-8";
      LC_NUMERIC = "ru_RU.UTF-8";
      LC_PAPER = "ru_RU.UTF-8";
      LC_TELEPHONE = "ru_RU.UTF-8";
      LC_TIME = "ru_RU.UTF-8";
    };
  };
}
