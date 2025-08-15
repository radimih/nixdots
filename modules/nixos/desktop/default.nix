{
  config,
  inputs,
  lib,
  pkgs,
  ...
}:

let
  cfg = config.modules.desktop;
in
{
  imports = [
    inputs.niri.nixosModules.niri
  ];

  options.modules.desktop = {

    enable = lib.mkEnableOption "System components of desktop environment";

  };

  config = lib.mkIf cfg.enable {

    environment.systemPackages = with pkgs; [
      alacritty
      fuzzel
      waybar
    ];

    services.displayManager.ly = {
      enable = true;
      settings = {
        animation = "matrix";
        clock = "%d.%m.%Y %T";
        vi_mode = true;
      };
      # TODO: попробовать новый параметр: https://github.com/NixOS/nixpkgs/commit/17260c31264ea0de35594e9bb28770972cdb74d0
      # x11Support = false;
    };

    programs.niri = {
      enable = true;
      package = pkgs.niri;
    };

  };
}
