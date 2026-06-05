{
  flake.modules.nixos.desktop = {

    xdg.portal = {
      enable = true;
      xdgOpenUsePortal = true;
    };
  };

  flake.modules.homeManager.desktop =
    { lib, ...}:
    {

      home.preferXdgDirectories = true;

      xdg = {
        enable = true;
        userDirs = {
          enable = true;
          createDirectories = true;
        };
        # Оставить только documents и download
        userDirs = {
          desktop = lib.mkDefault null;
          music = lib.mkDefault null;
          pictures = lib.mkDefault null;
          projects = lib.mkDefault null;
          publicShare = lib.mkDefault null;
          templates = lib.mkDefault null;
          videos = lib.mkDefault null;
        };
      };
    };
}

