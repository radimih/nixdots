# Home: https://github.com/oddlama/agenix-rekey
# Flake-parts: https://flake.parts/options/agenix-rekey.html
{
  inputs,
  ...
}:
let
  age = {
    identityPaths = [ "/etc/ssh/ssh_host_ed25519_key" ];
    rekey = {
      cacheDir = "${cacheDir}/\"$UID\"";
      hostPubkey = "/etc/ssh/ssh_host_ed25519_key.pub";
      masterIdentities = [ "${inputs.secrets}/master-key.age" ];
      # Не используется "local", так как в этом случае перезашифрованные для хоста секреты
      # должны располагаться в каталоге относительно корня флейка (см. описание параметра
      # age.rekey.localStorageDir), следовательно, находиться в git или в git submodule.
      # А хотелось бы обойтись без лишних git-коммитов при простом разворачивании хоста.
      storageMode = "derivation";
    };
  };
  cacheDir = "/var/tmp/agenix-rekey";
in
{
  imports = [
    inputs.agenix-rekey.flakeModule
  ];

  flake.modules.nixos.base = {

    imports = with inputs; [
      agenix.nixosModules.default
      agenix-rekey.nixosModules.default
    ];

    inherit age;

    # https://github.com/oddlama/agenix-rekey/issues/9#issuecomment-1741764749
    nix.settings.extra-sandbox-paths = [ cacheDir ];
    systemd.tmpfiles.rules = [
      "d ${cacheDir} 1777 root root"
    ];
  };

  flake.modules.homeManager.base = {

    imports = with inputs; [
      agenix.homeManagerModules.default
      agenix-rekey.homeManagerModules.default
    ];

    inherit age;
  };
}
