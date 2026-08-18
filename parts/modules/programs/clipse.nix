{
  ...
}:
{
  flake.modules.nixos.clipse =
    { pkgs, ... }:
    {
      environment.systemPackages = [
        pkgs.wl-clipboard
      ];
    };

  flake.modules.homeManager.clipse = {

    # TUI clipboard manager: https://github.com/savedra1/clipse
    services.clipse = {
      enable = true;
      # TODO: next-release: параметр появился в версии clipse 1.2
      # enableDescription = false;
      historySize = 20;
    };

    services.wl-clip-persist.enable = true;

    # Настройка клавиш для Niri:
    # programs.niri.settings.binds = {
    #   "Print" = {
    #     # TODO: next-release: использовать clipse -pause 1s (с версии 1.2), чтобы скриншот всего экрана не попадал в историю буфера обмена
    #     action.spawn-sh = ''
    #       ${lib.getExe pkgs.niri} msg action screenshot-screen && sleep 0.5
    #       ${lib.getExe' pkgs.wl-clipboard "wl-paste"} --type image/png | ${lib.getExe pkgs.satty} --filename -
    #     '';
    #     repeat = false;
    #   };
    #   "Mod+V" = {
    #     action.spawn = [ "${lib.getExe pkgs.xdg-terminal-exec}" "--app-id=clipse" "--" "clipse" ];
    #     repeat = false;
    #     hotkey-overlay.title = "Open Clipboard history";
    #   };
    # };
  };
}
