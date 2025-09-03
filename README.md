# nixdots

Конфигурация моих систем на базе [NixOS](https://nixos.org/).

- [flake-parts](https://github.com/hercules-ci/flake-parts)
- [The Dendritic Pattern](https://github.com/mightyiam/dendritic)

## TODO: Установка на новую систему

1. Склонировать данный репозиторий на только что установленную систему:

    ```bash
    nix-shell -p git --run "git clone https://github.com/radimih/nixdots.git"
    ```

## Draft: Принципы и архитектура

- При добавлении хоста не должен изменяться `flake.nix`

## Draft: Ограничения и допущения

- Конфигурации Home Manager обновляются при обновлении системы (`nixos-rebuild switch`)
