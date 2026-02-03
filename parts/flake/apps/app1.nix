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
            echo Hello! It is app1
            echo ${inputs.secrets.outPath}/master-key.age
          '';
        };
      };
    };
}
