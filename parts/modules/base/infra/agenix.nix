# https://github.com/oddlama/agenix-rekey
{
  inputs,
  ...
}:
{
  flake.modules.nixos.base =
    { config, ... }:
    {
      imports = [
        inputs.agenix.nixosModules.default
        inputs.agenix-rekey.nixosModules.default
      ];

      age.identityPaths = [ "/etc/ssh/ssh_host_ed25519_key" ];
      age.rekey = {
        localStorageDir = inputs.self + "/secrets/${config.networking.hostName}";
        masterIdentities = [ (inputs.self + "/secrets/master-key.age") ];
        storageMode = "local";
      };
    };
}
