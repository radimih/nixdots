{
  inputs,
  lib,
  pkgs,
  ...
}:

{
  # Для работы flakes нужен git
  environment.systemPackages = [ pkgs.git ];

  nix.channel.enable = false;

  # Закрепить в registry (nix registry list) все inputs, в том числе nixpkgs.
  # Чтобы при выполнении, например, команды nix run nixpkgs#пакет каждый раз
  # не загружалась и не оценивалась новая версия nixpkgs
  nix.registry = inputs |> lib.mapAttrs (_: value: { flake = value; });

  nix.settings = {
    auto-optimise-store = true;
    experimental-features = [
      "flakes"
      "nix-command"
      "pipe-operators"
    ];
    warn-dirty = false;
  };

  nixpkgs.config.allowUnfree = true;
}
