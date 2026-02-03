{
  perSystem =
    { pkgs, ... }:
    {
      apps.rekey = {
        meta.description = "Rekey";
        type = "app";
        program = pkgs.writeShellApplication {
          name = "rekey.sh";
          runtimeInputs = with pkgs; [
            expect
          ];
          # text = builtins.readFile ./rekey.sh;
          text = ''
            echo Hello!
          ''
        };
      };
    };
}
