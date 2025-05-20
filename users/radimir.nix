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

  # Let home Manager install and manage itself
  programs.home-manager.enable = true;
}
