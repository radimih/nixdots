{ inputs, ... }:
{
  perSystem =
    { pkgs, system, ... }:
    {
      apps.rekey = {
        meta.description = "Enroll disk encryption password into TPM2";
        type = "app";
        program = pkgs.writeShellApplication {
          name = "tpm2.sh";
          text = builtins.readFile ./tpm2.sh;
        };
      };
    };
}
