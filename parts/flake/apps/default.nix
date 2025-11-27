{
  perSystem =
    { pkgs, ... }:
    {
      apps.starter = {
        meta.description = "Hello";
        type = "app";
        program = pkgs.writeShellApplication {
          name = "starter.sh";
          runtimeInputs = with pkgs; [
            gh
            git
            rlwrap  # для полноценной работы команды read при вводе Github-токена в bash-скрипте starter.sh
          ];
          text = builtins.readFile ./starter.sh;
        };
      };
    };
}
