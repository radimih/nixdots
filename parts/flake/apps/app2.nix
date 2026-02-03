{ inputs, ... }:
{
  perSystem =
    { pkgs, system, ... }:
    {
      apps.app2 = {
        meta.description = "Rekey";
        type = "app";
        program = pkgs.writeShellApplication {
          name = "rekey.sh";
          runtimeInputs = with pkgs; [
            expect
          ];
          text =
          let
            qqq = pkgs.replaceVars ./rekey.sh {
                master-key-file = "${inputs.secrets.outPath}/master-key.age";
                rekey-command = "nix run .#agenix-rekey.${system}.rekey";
              };
          in
            builtins.readFile qqq;
        };
      };
    };
}
