{ inputs, ... }:
{
  perSystem =
    { pkgs, ... }:
    {
      apps.app1 = {
        meta.description = "app1";
        type = "app";
        program = pkgs.writeShellApplication {
          name = "rekey.sh";
          runtimeInputs = with pkgs; [
            expect
          ];
          text = ''
            echo Hello! It's app1
            echo ${inputs.secrets}/master-key.age
          '';
        };
      };

      apps.app2 = {
        meta.description = "app2";
        type = "app";
        program = pkgs.writeShellApplication {
          name = "app2.sh";
          runtimeInputs = with pkgs; [
            expect
          ];
          text = ''
            echo It's app2!
          '';
        };
      };
    };
}
