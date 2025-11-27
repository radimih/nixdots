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
            rlwrap  # для замены команды read, в которой не работает редактирование строки,
                    # так как скрипт запускается в неинтерактивном варианте bash
          ];
          text = builtins.readFile ./starter.sh;
        };
      };
    };
}
