# https://github.com/fairyglade/ly
{
  flake.modules.nixos.service-display-manager-ly = {

    services.displayManager.ly = {
      enable = true;
      # Описание параметров и значения по-умолчанию:
      # https://github.com/fairyglade/ly/blob/master/res/config.ini
      settings = {
        animation = "matrix";
        asterisk = "0x2022";  # код UTF-32 символа '•'
        brightness_down_key = null;
        brightness_up_key = null;
        clear_password = true;
        clock = "%d.%m.%Y %T";
        cmatrix_min_codepoint = "0x3000";
        cmatrix_max_codepoint = "0x30FF";
        vi_mode = true;
      };
      x11Support = false;
    };
  };
}
