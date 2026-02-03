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
          substitutedScript = pkgs.replaceVars {
            src = ./rekey.sh;
            replacements = {
              masterKeyFile = "${inputs.secrets.outPath}/master-key.age";
              rekeyCommand = "nix run .#agenix-rekey.${system}.rekey";
            };
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
