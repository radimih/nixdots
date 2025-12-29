# Home: https://github.com/oddlama/agenix-rekey
# Flake-parts: https://flake.parts/options/agenix-rekey.html
{
  flake.modules.homeManager.agenix-home =
    { inputs, ... }:
    {
      imports = [
        inputs.agenix.homeManagerModules.default
        # inputs.agenix-rekey.homeManagerModules.default
      ];

      # age.identityPaths = [ "/etc/ssh/ssh_host_ed25519_key" ];
      # age.rekey = {
      #   cacheDir = "${cacheDir}/\"$UID\"";
      #   hostPubkey = "/etc/ssh/ssh_host_ed25519_key.pub";
      #   masterIdentities = [ "${inputs.secrets}/master-key.age" ];
      #   storageMode = "derivation";
      # };
    };
}
