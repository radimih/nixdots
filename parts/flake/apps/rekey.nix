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
            age
            expect
          ];
          text = builtins.readFile (
            pkgs.replaceVars ./rekey.sh {
                master-key-file = "${inputs.secrets.outPath}/master-key.age";
                rekey-command = "nix run .#agenix-rekey.${system}.rekey";
              }
          );
        };
      };
    };
}
