{
  flake.modules.homeManager.shell = {

    home = {
      # Включить shell-интеграцию только для fish
      shell = {
        enableFishIntegration = true;
        enableShellIntegration = false;
      };
      shellAliases = {
        cat = "bat";
        ls = "eza";
        grep = "rg";
      };
    };
  };
}
