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
          read_only = " ";
          # before_repo_root_style = "white";
          repo_root_format = " [$repo_root]($repo_root_style) [$path]($style)[$read_only]($read_only_style) ";
          repo_root_style = "yellow";
          truncation_length = 0;
        };
      };
    };
  };
}
