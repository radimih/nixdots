{ inputs, ... }:
{
  perSystem =
    { pkgs, system, ... }:
    {
      apps.rekey = {
        meta.description = "Enroll the password for the encrypted disk into TPM2 memory";
        type = "app";
        program = pkgs.writeShellApplication {
          name = "tpm2.sh";
          text = builtins.readFile ./tpm2.sh;
        };
      };
    };
}
