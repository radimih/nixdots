{
  flake.modules.nixos.boot2 = {

    boot = {
      initrd.verbose = false;
      kernelParams = [
        "quiet"
        "splash"
        "vga=current"
        "systemd.show_status=auto"
        # https://www.freedesktop.org/software/systemd/man/latest/systemd-udevd.service.html#Kernel%20command%20line
        # Нет необходимости задавать аналогичные параметры с префиксом rd.* ()
        "udev.log_level=3"
      ];
    };
  };
}
