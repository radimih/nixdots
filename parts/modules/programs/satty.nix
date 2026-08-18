# Screenshot annotation tool: https://github.com/Satty-org/Satty
{
  flake.modules.homeManager.satty =
    { lib, pkgs, ... }:
    {
      programs.satty = {
        enable = true;
        settings = {
          general = {
            actions-on-escape = [ "exit" ];
            annotation-size-factor = 1;
            copy-command = "${lib.getExe' pkgs.wl-clipboard "wl-copy"}";
            disable-notifications = true;
            early-exit = true;
            # fullscreen = true;
            initial-tool = "arrow";
            input-scale = 1.0;
            primary-highlighter = "freehand";
            zoom-factor = 1.0;
          };
        };
      };
    };
}
