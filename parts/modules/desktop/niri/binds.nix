# Scrollable-tiling Wayland compositor Niri: https://github.com/YaLTeR/niri
# Flake: https://github.com/sodiboo/niri-flake
{
  flake.modules.homeManager.niri =
  let
    defaultKeyBinds = import ./_defaultKeyBinds.nix;
  in
  {
    programs.niri.settings.binds = defaultKeyBinds // {

      "Mod+D" = {
        action.spawn = "fuzzel";
        hotkey-overlay.title = "Run an Application";
      };

      "Mod+Return" = {
        action.spawn = "kitty";
        repeat = false;
        hotkey-overlay.title = "Open a Terminal";
      };
    };
  };
}
