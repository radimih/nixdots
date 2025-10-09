{
  flake.modules.homeManager.shell = {

    home = {
      # Включить shell-интеграцию только для fish
      shell = {
        enableFishIntegration = true;
        enableShellIntegration = false;
      };
    };
  };
}
