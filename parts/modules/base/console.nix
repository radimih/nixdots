{
  flake.modules.nixos.base =
    { pkgs, ...}:
    {
      # Установить шрифт для текстовой консоли (/dev/ttyN) с поддержкой кириллицы
      console = {
        font = "ter-u16n";  # "UniCyr_8x16" - вариант шрифта из стандартной поставки
        packages = [ pkgs.terminus_font ];
      };
    };
}

