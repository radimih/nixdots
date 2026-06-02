{
  flake.modules.nixos.desktop = {

    xdg.portal = {
      enable = true;
      xdgOpenUsePortal = true;
    };
  };

  flake.modules.homeManager.desktop = {

    home.preferXdgDirectories = true;

    xdg = {
      enable = true;
      userDirs = {
        enable = true;
        createDirectories = true;
      };
      # Оставить только documents и download
      userDirs = {
        desktop = null;
        music = null;
        pictures = null;
        projects = null;
        publicShare = null;
        templates = null;
        videos = null;
      };
    };
  };
}

