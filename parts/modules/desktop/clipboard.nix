{
  ...
}:
{
  flake.modules.nixos.desktop =
    { pkgs, ... }:
    {
      environment.systemPackages = [
        pkgs.wl-clipboard
      ];
    };

  flake.modules.homeManager.desktop = {

    services.clipse = {
      enable = true;
      imageDisplay.type = "kitty";
    };

    services.wl-clip-persist.enable = true;
  };
}
