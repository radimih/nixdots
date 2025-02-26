{ config, pkgs, userSettings, ... }:

{
  home.username = userSettings.name;
  home.homeDirectory = "/home/${userSettings.name}";

  home.packages = with pkgs; [
    eza
    wl-clipboard
  ];

  home.stateVersion = "24.11";

  # Let home Manager install and manage itself.
  programs.home-manager.enable = true;
}
