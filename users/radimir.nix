{
  config,
  pkgs,
  globalSpec,
  inputs,
  ...
}:

{
  /*
    Нет необходимости устанавливать параметры home.username|homeDirectory, так как
    Home Manager в режиме NixOS-модуля устанавливает их автоматически:
    https://github.com/nix-community/home-manager/blob/master/nixos/common.nix#L49-L50
  */

  home.packages = with pkgs; [
    wl-clipboard
  ];

  home.stateVersion = globalSpec.stateVersion;

  # Let home Manager install and manage itself
  programs.home-manager.enable = true;
}
