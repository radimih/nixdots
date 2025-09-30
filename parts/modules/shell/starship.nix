# https://starship.rs/config/
{
  flake.modules.homeManager.shell = {

    programs.starship = {
      enable = true;
      settings = {
        format = builtins.concatStringsSep "" [
          "$username"
          "$hostname"
          "$directory"
          "$git_branch"
          "$git_state"
          "$git_status"
          "$kubernetes"
          "$nix_shell"
          "$cmd_duration"
          "\n"
          "$shlvl"
          "$character"
        ];
        cmd_duration = {
          min_time = 2 * 1000;  # 2 секунды
          format = "[󰥔 $duration]($style)";
        };
        directory = {
          read_only = " ";
          repo_root_format = " [$repo_root]($repo_root_style) [$path]($style)[$read_only]($read_only_style) ";
          repo_root_style = "yellow";
          truncation_length = 0;
        };
        shlvl = {
          disabled = false;
          format = "[$]($style)";
          threshold = 3;
        };
      };
    };
  };
}
