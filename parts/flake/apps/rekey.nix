{ inputs, pkgs, ... }:
{
  # meta.description = "Rekey";
  type = "app";
  program = pkgs.writeShellApplication {
    name = "rekey.sh";
    runtimeInputs = with pkgs; [
      expect
    ];
    text = ''
      echo Hello!
      echo ${inputs.secrets}/master-key.age
    '';
  };
}
