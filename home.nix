{ config, pkgs, ... }:

{
  home.username = "radimir";
  home.homeDirectory = "/home/radimir";

  home.packages = with pkgs; [
    firefox
    git
    kubectl
    kubernetes-helm
    helmfile
    telegram-desktop
  ];

  home.stateVersion = "24.11";

  # Let home Manager install and manage itself.
  programs.home-manager.enable = true;
}
