{ inputs, ... }:
{
  perSystem =
    { pkgs, system, ... }:
    {
      apps.rekey = {
        meta.description = "Rekey";
        type = "app";
        program = pkgs.writeShellApplication {
          name = "rekey.sh";
          runtimeInputs = with pkgs; [
            expect
          ];
          text = builtins.readFile (
            pkgs.replaceVars ./rekey.sh {
                # masterKeyFile = "${inputs.secrets.outPath}/master-key.age";
                # rekeyCommand = "nix run .#agenix-rekey.${system}.rekey";
                hello = "world";
              }
          );
        };
      };
    };
}
