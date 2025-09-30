# https://starship.rs/config/
{
  flake.modules.homeManager.shell = {

    programs.starship = {
      enable = true;
      settings =
      let
        # colors.path = {
        #   bg = "#769ff0";
        #   fg = "#e3e5e5";
        #   fg_repo = "yellow";
        # };
        # colors.git = {
        #   bg = "#394260";
        #   fg = "#769ff0";
        # };
        # colors.other = {
        #   bg = "#212736";
        #   fg = "#769ff0";
        # };
        # colors.duration = {
        #   bg = "#1d2230";
        #   fg = "#a0a9cb";
        # };
        colors.path = {
          bg = "#5980cf";
          fg = "#e3e5e5";
          fg_repo = "yellow";
        };
        colors.git = {
          bg = "#394260";
          fg = "#769ff0";
        };
        colors.other = {
          bg = "#212736";
          fg = "#769ff0";
        };
        colors.duration = {
          bg = "#1d2230";
          fg = "#a0a9cb";
        };
      in
      {
        format = builtins.concatStringsSep "" [
          # "$username"
          # "$hostname"
          "$directory"
          "[](fg:${colors.path.bg} bg:${colors.git.bg})"  # )
          "$git_branch"
          "$git_status"
          "[](fg:${colors.git.bg} bg:${colors.other.bg})"  # )
          "$kubernetes"
          "$nix_shell"
          "[](fg:${colors.other.bg} bg:${colors.duration.bg})"  # )
          "$cmd_duration"
          "[ ](fg:${colors.duration.bg})"  # )
          "\n"
          "$shlvl"
          "$character"
        ];
        cmd_duration = {
          min_time = 2 * 1000;  # 2 секунды
          format = "[[ 󰚭 $duration ](fg:${colors.duration.fg} bg:${colors.duration.bg} bold)]($style)";
          style = "bg:${colors.duration.bg}";
        };
        directory = {
          format = "[ $path ]($style)[$read_only]($read_only_style)";
          read_only = "";
          read_only_style = "bg:${colors.path.bg} red";
          repo_root_format = "[  $repo_root]($repo_root_style)[ $path ]($style)[$read_only]($read_only_style)";
          repo_root_style = "bg:${colors.path.bg} fg:${colors.path.fg_repo} bold";
          style = "fg:${colors.path.fg} bg:${colors.path.bg}";
          truncation_length = 0;
        };
        git_branch = {
          format = "[[ $symbol $branch ](fg:${colors.git.fg} bg:${colors.git.bg})]($style)";
          style = "bg:${colors.git.bg}";
          symbol = "";
        };
        git_status = {
          format = "[[($all_status$ahead_behind )](fg:${colors.git.fg} bg:${colors.git.bg})]($style)";
          style = "bg:${colors.git.bg}";
        };
        nix_shell = {
          format = "[[ $symbol $state( \\($name\\)) ](fg:${colors.other.fg} bg:${colors.other.bg})]($style)";
          style = "bg:${colors.other.bg}";
          symbol = "";
        };
        shlvl = {
          disabled = false;
          format = "[❯]($style)";
          style = "bold green";
          threshold = 3;
        };
      };
    };
  };
}
