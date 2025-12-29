# https://github.com/oddlama/agenix-rekey
{
  inputs,
  ...
}:
{
  imports = [
    # flake-parts.agenix-rekey: https://flake.parts/options/agenix-rekey.html
    inputs.agenix-rekey.flakeModule
  ];

  flake.modules.nixos.base =
    { ... }:
    let
      cacheDir = "/var/tmp/agenix-rekey";
    in
    {
      imports = [
        inputs.agenix.nixosModules.default
        inputs.agenix-rekey.nixosModules.default
      ];

      age.identityPaths = [ "/etc/ssh/ssh_host_ed25519_key" ];
      age.rekey = {
        cacheDir = "${cacheDir}/\"$UID\"";
        hostPubkey = "/etc/ssh/ssh_host_ed25519_key.pub";
        masterIdentities = [ "${inputs.secrets}/master-key.age" ];
        storageMode = "derivation";
      };

      # https://github.com/oddlama/agenix-rekey/issues/9#issuecomment-1741764749
      nix.settings.extra-sandbox-paths = [ cacheDir ];
      systemd.tmpfiles.rules = [
        "d ${cacheDir} 1777 root root"
      ];
    };

  flake.modules.homeManager.base =
    { ... }:
    {
      imports = [
        inputs.agenix.homeManagerModules.default
        # inputs.agenix-rekey.homeManagerModules.default
        inputs.agenix-rekey.homeManagerModules.agenix-rekey
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
