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
            fullscreen = true;
            initial-tool = "crop";
            primary-highlighter = "freehand";
            # TODO: next-release: новый параметр в 0.20.1, default = 1.1
            # zoom-factor = 1.0;
          };
        };
      };
    };
}
