{
  config,
  pkgs,
  globalSpec,
  inputs,
  ...
}:

{
  home.packages = with pkgs; [
    wl-clipboard
  ];

  home.stateVersion = globalSpec.stateVersion;
}
