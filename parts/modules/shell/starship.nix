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
          # fish_style_pwd_dir_length = 2;
          read_only = " ";
          # truncation_length = 5;
          # before_repo_root_style = "white";
          repo_root_format = " [$repo_root]($repo_root_style) [$path]($style)[$read_only]($read_only_style) ";
          repo_root_style = "yellow";
          # Эта опция не работает, если используется fish_style_pwd_dir_length
          # truncation_symbol = "… /";
        };
      };
    };
  };
}
