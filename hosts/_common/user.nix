{
  config,
  globalSpec,
  ...
}:

{
  users.users.${globalSpec.user.name} = {
    isNormalUser = true;
    description = globalSpec.user.desc;
    extraGroups = [
      "networkmanager"
      "wheel"
    ];
  };

}
