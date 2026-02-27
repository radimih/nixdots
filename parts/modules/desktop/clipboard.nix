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
      # TODO: next-release: параметр появился в версии clipse 1.2
      # enableDescription = false;
      imageDisplay.type = "kitty";
    };

    services.wl-clip-persist.enable = true;
  };
}
