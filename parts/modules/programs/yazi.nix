# TUI file manager: https://github.com/sxyazi/yazi
{
  flake.modules.nixos.yazi =
    { pkgs, ...}:
    {
      environment.systemPackages = [
        pkgs.file
      ];
    };

  flake.modules.homeManager.yazi =
    { pkgs, ...}:
    {
      programs.yazi = {
        enable = true;
        settings = {
          yazi = {
            mgr = {
              linemode = "size";
              ratio = [
                1
                4
                4
              ];
              show_hidden = true;
              show_symlink = true;
              sort_by = "natural";
              sort_dir_first = true;
              sort_reverse = false;
              sort_sensitive = false;
            }:
          };
        };
      };
    };
}
