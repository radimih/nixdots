# https://starship.rs/config/
{
  flake.modules.homeManager.shell = {

    programs.starship = {
      enable = true;
      settings =
      let
        colors.sect1 = {
          bg = "";
          fg = "";
        };
        colors.sect2 = {
          bg = "#769ff0";
          fg = "#e3e5e5";
        };
        colors.sect3 = {
          bg = "";
          fg = "";
        };
        colors.sect4 = {
          bg = "#1d2230";
          fg = "#a0a9cb";
        };
      in
      {
        format = builtins.concatStringsSep "" [
          "[ ](bg:#a3aed2 fg:#090c0c)"
          # "$username"
          # "$hostname"
          "$directory"
          "[](fg:${colors.sect2.bg} bg:#394260)"  # )
          "$git_branch"
          "$git_status"
          "[](fg:#394260 bg:#212736)"  # )
          "$kubernetes"
          "$nix_shell"
          "[](fg:#212736 bg:${colors.sect4.bg})"  # )
          "$cmd_duration"
          "[ ](fg:${colors.sect4.bg})"  # )
          "\n"
          "$shlvl"
          "$character"
        ];
        cmd_duration = {
          min_time = 2 * 1000;  # 2 секунды
          format = "[[ 󰚭 $duration ](fg:${colors.sect4.fg} bg:${colors.sect4.bg} bold)]($style)";
          style = "bg:${colors.sect4.bg}";
        };
        directory = {
          format = "[ $path ]($style)[$read_only]($read_only_style)";
          read_only = "";
          read_only_style = "bg:${colors.sect2.bg} red";
          repo_root_format = "[ $repo_root]($repo_root_style)[ $path ]($style)[$read_only]($read_only_style)";
          repo_root_style = "bg:${colors.sect2.bg} yellow bold";
          style = "fg:${colors.sect2.fg} bg:${colors.sect2.bg}";
          truncation_length = 0;
        };
        git_branch = {
          format = "[[ $symbol $branch ](fg:${colors.sect2.bg} bg:#394260)]($style)";
          style = "bg:#394260";
          symbol = "";
        };
        git_status = {
          format = "[[($all_status$ahead_behind )](fg:${colors.sect2.bg} bg:#394260)]($style)";
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
