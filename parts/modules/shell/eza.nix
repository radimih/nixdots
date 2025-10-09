# Современная альтернатива ls: https://eza.rocks/
# https://github.com/eza-community/eza/blob/main/man/eza.1.md
{
  flake.modules.homeManager.shell = {

    programs.eza = {
      colors = "always";
      enable = true;
      extraOptions = [
        "--group-directories-first"
        "--no-quotes"
      ];
      icons = "auto";
    };
  };
}
