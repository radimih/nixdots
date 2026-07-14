# agenix: https://github.com/ryantm/agenix
# agenix-rekey: https://github.com/oddlama/agenix-rekey
# agenix-rekey flake-parts: https://flake.parts/options/agenix-rekey.html
{
  inputs,
  ...
}:
let
  cacheDir = "/var/tmp/agenix-rekey";
  rekey = {
    cacheDir = "${cacheDir}/\"$UID\"";
    masterIdentities = [ "${inputs.secrets}/master-key.age" ];
    # Не используется "local", так как в этом случае перезашифрованные для хоста секреты
    # должны располагаться в каталоге относительно корня флейка (см. описание параметра
    # age.rekey.localStorageDir), следовательно, находиться в git или в git submodule.
    # А хотелось бы обойтись без лишних git-коммитов при простом развёртывании хоста.
    storageMode = "derivation";
  };
in
{
  imports = [
    inputs.agenix-rekey.flakeModule
  ];

  flake.modules.nixos.base =
  let
    hostKeyPath = "/etc/ssh/ssh_host_ed25519_key";
  in
  {
    imports = with inputs; [
      agenix.nixosModules.default
      agenix-rekey.nixosModules.default
    ];

    age.identityPaths = [ hostKeyPath ];
    age.rekey.hostPubkey = "${hostKeyPath}.pub";
    age.rekey = { inherit (rekey) cacheDir masterIdentities storageMode; };

    # https://github.com/oddlama/agenix-rekey/issues/9#issuecomment-1741764749
    nix.settings.extra-sandbox-paths = [ cacheDir ];
    systemd.tmpfiles.rules = [
      "d ${cacheDir} 1777 root root"
    ];

    services.openssh = {
      generateHostKeys = true;
      hostKeys = [
        {
          path = hostKeyPath;
          type = "ed25519";
        }
      ];
    };
  };

  flake.modules.homeManager.base =
    { config, ... }:
    {
      imports = with inputs; [
        agenix.homeManagerModules.default
        agenix-rekey.homeManagerModules.default
      ];

      age.identityPaths = [ "${config.home.homeDirectory}/.ssh/id_ed25519" ];
      age.rekey.hostPubkey = "${config.home.homeDirectory}/.ssh/id_ed25519.pub";
      age.rekey = { inherit (rekey) cacheDir masterIdentities storageMode; };
    };
}
