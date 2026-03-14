{
  flake.modules.homeManager.desktop =
    { pkgs, ... }:
    {
      home.packages = [
        pkgs.networkmanagerapplet
      ];

      services = {
        network-manager-applet.enable = true;
      };
    };
}
