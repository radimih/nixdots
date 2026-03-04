{
  flake.modules.homeManager.desktop = {

    services = {
      network-manager-applet.enable = true;
    };
  };
}
