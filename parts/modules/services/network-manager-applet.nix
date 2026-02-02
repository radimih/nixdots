{
  flake.modules.homeManager.desktop = {

    # BUG: служба не запускается с первого раза
    services = {
      network-manager-applet.enable = true;
    };
  };
}
