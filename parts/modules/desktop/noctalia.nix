# Noctalia: native Wayland desktop shell (https://docs.noctalia.dev/)
{
  inputs,
  ...
}:
{
  flake.modules.nixos.noctalia = {
    nix.settings = {
      extra-substituters = [ "https://noctalia.cachix.org" ];
      extra-trusted-public-keys = [ "noctalia.cachix.org-1:pCOR47nnMEo5thcxNDtzWpOxNFQsBRglJzxWPp3dkU4=" ];
    };
  };

  flake.modules.homeManager.noctalia =
    { lib, pkgs, ... }:
    {
      imports = [
        inputs.noctalia.homeModules.default
      ];

      # https://docs.noctalia.dev/noctalia/compositor-settings/niri/
      programs.niri.settings = {
        debug = {
          honor-xdg-activation-with-invalid-serial = [];
        };
        spawn-at-startup = [
          { command = [ "noctalia" ]; }
        ];
        window-rules = [
          # Floating Noctalia settings window
          {
            matches = [
              { app-id = "dev.noctalia.Noctalia"; }
            ];
            default-column-width.fixed = 1080;
            default-window-height.fixed = 920;
            open-floating = true;
          }
        ];
      };

      programs.noctalia = {
        enable = true;
      };
    };
}
