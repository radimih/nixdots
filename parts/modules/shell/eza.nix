{
  flake.modules.homeManager.shell = {

    programs.eza = {
      colors = "always";
      enable = true;
      extraOptions = [
        "--group-directories-first"
      ];
      icons = "auto";
    };
  };
}
