# https://starship.rs/config/
{
  flake.modules.homeManager.shell = {

    programs.starship = {
      enable = true;
      settings = {
        cmd_duration = {
          min_time = 5 * 1000;
          format = "[󰥔 $duration]($style)";
        };
        directory = {
          read_only = " ";
          truncation_length = 5;
          truncation_symbol = "… /";
        };
      };
    };
  };
}
