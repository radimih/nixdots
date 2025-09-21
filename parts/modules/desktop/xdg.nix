{
  flake.modules.nixos.desktop = {

    home-manager.sharedModules = [
      {
        home.preferXdgDirectories = true;
        xdg = {
          enable = true;
          userDirs = {
            enable = true;
            createDirectories = true;
          };
          userDirs = {
            music = null;
            pictures = null;
            publicShare = null;
            templates = null;
            videos = null;
          };
        };
      }
    ];

    xdg.portal = {
      enable = true;
      xdgOpenUsePortal = true;
    };
  };
}

