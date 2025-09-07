{
  flake.modules.nixos.boot = {

    boot = {
      initrd.verbose = false;
      kernelParams = [
        "quiet"
        "plymouth.use-simpledrm"
        "systemd.show_status=auto"
        # https://www.freedesktop.org/software/systemd/man/latest/systemd-udevd.service.html#Kernel%20command%20line
        # Нет необходимости задавать аналогичные параметры с префиксом rd.* ()
        "udev.log_level=3"
      ];
    };
  };
}
