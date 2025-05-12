{
  config,
  pkgs,
  globalSpec,
  ...
}:

{
  home.username = globalSpec.user.name;
  home.homeDirectory = "/home/${globalSpec.user.name}";

  home.packages = with pkgs; [
    wl-clipboard
  ];

  home.stateVersion = "24.11";

  # Let home Manager install and manage itself
  programs.home-manager.enable = true;
}
