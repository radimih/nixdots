# https://starship.rs/config/
{
  flake.modules.homeManager.shell = {

    programs.starship = {
      enable = true;
      settings = {
        cmd_duration = {
          min_time = 2 * 1000;  # 2 секунды
          format = "[󰥔 $duration]($style)";
        };
        directory = {
          fish_style_pwd_dir_length = 1;
          read_only = " ";
          truncation_length = 5;
          truncation_symbol = "… /";
        };
      };
    };
  };
}
