# Настройки ядра Linux
#
# Текущие параметры ядра, с которыми оно было собрано:
#   посмотреть: zcat /proc/config.gz
#   описание параметров: https://www.kernelconfig.io/
{
  flake.modules.nixos.base = {

    boot = {
      # По-умолчанию используется LTS-версия ядра
      # kernelPackages = pkgs.linuxPackages_latest;

      # https://docs.kernel.org/admin-guide/kernel-parameters.html#
      kernelParams = [
        "mitigations=off"
        "split_lock_detect=off"
      ];
    };
  };
}
