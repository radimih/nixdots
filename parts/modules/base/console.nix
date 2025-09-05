{
  flake.modules.nixos.base =
    { pkgs, ...}:
    {
      # Выводить в консоль только сообщения ядра уровнем меньше 3
      # (4 - warning, 3 - error, 2 - critical, 1- alert, 0 - emergy)
      boot.consoleLogLevel = 3;

      # Настроить консоль как можно раньше, для initrd (например, если для консоли переопределяется шрифт)
      console.earlySetup = true;

      # Установить шрифт для текстовой консоли (/dev/ttyN) с поддержкой кириллицы
      console = {
        font = "ter-u16n";  # "UniCyr_8x16" - вариант шрифта из стандартной поставки
        packages = [ pkgs.terminus_font ];
      };
    };
}
