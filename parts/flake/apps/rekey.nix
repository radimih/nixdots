{ inputs, ... }:
{
  perSystem =
    { pkgs, system, ... }:
    {
      apps.rekey = {
        meta.description = "Rekey";
        type = "app";
        program =
        let
          substitutedScript = pkgs.substituteAll {
            src = ./rekey.sh;
            master-key-file = "${inputs.secrets.outPath}/master-key.age";
            agenix-rekey-command = "nix run .#agenix-rekey.${system}.rekey";
          };
        in
        pkgs.writeShellApplication {
          name = "rekey.sh";
          runtimeInputs = with pkgs; [
            expect
          ];
          text = builtins.readFile substitutedScript;
        };
      };
    };
}
