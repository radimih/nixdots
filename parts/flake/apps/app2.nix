{ inputs, ... }:
{
  perSystem =
    { pkgs, ... }:
    {
      apps.app2 = {
        meta.description = "app2";
        type = "app";
        program = pkgs.writeShellApplication {
          name = "app2.sh";
          runtimeInputs = with pkgs; [
            expect
          ];
          text = ''
            echo It is app2!
          '';
        };
      };
    };
}
