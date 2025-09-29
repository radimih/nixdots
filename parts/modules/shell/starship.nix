# https://starship.rs/config/
{
  flake.modules.homeManager.shell = {

    programs.starship = {
      enable = true;
      settings = {
        directory = {
          # read_only = " ";
          truncation_length = 6;
          truncation_symbol = "…/";
        };
      };
    };
  };
}
