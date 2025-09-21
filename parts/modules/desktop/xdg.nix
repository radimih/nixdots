{
  flake.modules.nixos.desktop = {

    home-manager.sharedModules = [
      ({ config, ... }:
      {
        home.preferXdgDirectories = true;
        xdg = {
          enable = true;
          userDirs = {
            enable = true;
            createDirectories = true;
          };
          userDirs = {
            # TODO: уточнить каталог для документов
            documents = "${config.home.homeDirectory}/1cloud/documents";
            download = "${config.home.homeDirectory}/1temp";
          };
          userDirs = {
            desktop = null;
            music = null;
            pictures = null;
            publicShare = null;
            templates = null;
            videos = null;
          };
        };
      })
    ];

    xdg.portal = {
      enable = true;
      xdgOpenUsePortal = true;
    };
  };
}

