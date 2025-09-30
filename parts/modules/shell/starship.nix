# https://starship.rs/config/
{
  flake.modules.homeManager.shell = {

    programs.starship = {
      enable = true;
      settings = {
        format = builtins.concatStringsSep "" [
          "[ ](bg:#a3aed2 fg:#090c0c)"
          # "$username"
          # "$hostname"
          "$directory"
          "[](fg:#769ff0 bg:#394260)"
          "$git_branch"
          "$git_status"
          "[](fg:#394260 bg:#212736)"
          "$kubernetes"
          "$nix_shell"
          "[](fg:#212736 bg:#1d2230)"
          "$cmd_duration"
          "[ ](fg:#1d2230)"
          "\n"
          "$shlvl"
          "$character"
        ];
        cmd_duration = {
          min_time = 2 * 1000;  # 2 секунды
          format = "[󰚭 $duration]($style)";
        };
        directory = {
          read_only = " ";
          repo_root_format = " [$repo_root]($repo_root_style) [$path]($style)[$read_only]($read_only_style) ";
          repo_root_style = "bg:#a3aed2 fg:#090c0c";
          style = "fg:#e3e5e5 bg:#769ff0";
          truncation_length = 0;
        };
        git_branch = {
          format = "[[ $symbol $branch ](fg:#769ff0 bg:#394260)]($style)";
          style = "bg:#394260";
          symbol = "";
        };
        git_status = {
          format = "[[($all_status$ahead_behind )](fg:#769ff0 bg:#394260)]($style)";
          style = "bg:#394260";
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
