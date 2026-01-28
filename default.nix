# Для обеспечения выполнения команды nix-shell https://github.com/radimih/nixdots/archive/main.tar.gz
# на "голом" NixOS

{ pkgs ? import <nixpkgs> {} }:

pkgs.mkShellNoCC {

  packages = with pkgs; [
    gh
    git
    rlwrap  # для замены команды read, в которой не работает редактирование строки,
            # так как скрипт запускается в неинтерактивном варианте bash
  ];

  # Запустить скрипт starter.sh и сразу выйти из nix shell
  shellHook = builtins.readFile ./starter.sh + "\nexit 0";
}
