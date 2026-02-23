{
  flake.modules.homeManager.desktop = {

    # BUG: служба не запускается с первого раза
    # Временно в niri/default.nix эта служба перезапускается
    services = {
      network-manager-applet.enable = true;
    };
  };
}
