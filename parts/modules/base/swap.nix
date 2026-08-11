# Настройка swap и zswap
# ---
# Статьи Chris Down:
#   https://chrisdown.name/2018/01/02/in-defence-of-swap.html
#   https://chrisdown.name/2026/03/24/zswap-vs-zram-when-to-use-what.html
{
  flake.modules.nixos.base = {

    boot.zswap.enable = true;

    # https://docs.kernel.org/admin-guide/sysctl/vm.html
    boot.kernel.sysctl = {
      "vm.page-cluster" = 0; # Отключить загрузку "соседних" страниц. Для SSD это не имеет смысла.
      "vm.swappiness" = 100; #
      "vm.watermark_boost_factor" = 0;   # Отключить агрессивную превентивную подкачку. Это предотвращает от внезапных "тормозов".
      "vm.watermark_scale_factor" = 125; # kswapd начнет работать, когда свободно около 1.25% RAM (по-умолчанию - 0.1%).
                                         # Чтобы система начинала подготовку к подкачке заранее и делала это плавно.
    };

    swapDevices = [
      {
        device = "/swapfile";
        size = 4 * 1024; # 4 ГБ
      }
    ];

  };
}
