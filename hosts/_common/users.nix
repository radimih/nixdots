{
  globalSpec,
  pkgs,
  ...
}:

{
  users = {
    defaultUserShell = pkgs.fish;
    users.${globalSpec.admin.name} = {
      isNormalUser = true;
      description = globalSpec.admin.desc;
      extraGroups = [
        "networkmanager"
        "wheel"
      ];
    };
  };
}
