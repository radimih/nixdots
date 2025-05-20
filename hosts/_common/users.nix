{
  globalSpec,
  ...
}:

{
  users.users.${globalSpec.admin.name} = {
    isNormalUser = true;
    description = globalSpec.admin.desc;
    extraGroups = [
      "networkmanager"
      "wheel"
    ];
  };
}
