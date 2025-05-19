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

  home.stateVersion = "24.11";

  # Let home Manager install and manage itself
  programs.home-manager.enable = true;
}
