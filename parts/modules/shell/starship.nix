# https://starship.rs/config/
{
  flake.modules.homeManager.shell = {

    programs.starship = {
      enable = true;
      settings = {
        directory = {
          # read_only = " ";
          truncation_length = 2;
          truncation_symbol = "…/";
        };
      };
    };
  };
}
