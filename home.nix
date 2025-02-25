{ config, pkgs, ... }:

{
  home.username = "radimir";
  home.homeDirectory = "/home/radimir";

  home.packages = with pkgs; [
    git
    google-chrome
  ];

  home.stateVersion = "24.11";

  # Let home Manager install and manage itself.
  programs.home-manager.enable = true;
}
