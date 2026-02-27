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
      enableDescription = false;
      imageDisplay.type = "kitty";
    };

    services.wl-clip-persist.enable = true;
  };
}
