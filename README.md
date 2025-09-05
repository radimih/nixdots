# nixdots

Конфигурация моих систем на базе [NixOS](https://nixos.org/).

- [flake-parts](https://github.com/hercules-ci/flake-parts)
- [The Dendritic Pattern](https://github.com/mightyiam/dendritic)

## TODO: Установка на новую систему

1. Выполнить

    ```bash
    sudo nix run nixpkgs#sbctl create-keys
    ```

1. Склонировать данный репозиторий на только что установленную систему:

    ```bash
    git clone https://github.com/radimih/nixdots.git
    cd nixdots
    ```

1. Выполнить:

    ```bash
    sudo nixos-rebuild switch --flake .
    ```

1. Проверить что EFI-образы теперь подписаны:

    ```bash
    sudo sbctl verify
    ```

1. Перезагрузиться

1. Записать ключи хоста в EFI:

    ```bash
    sudo sbctl enroll-keys --microsoft
    ```

1. Перезагрузиться

1. Проверить:

    ```bash
    sudo bootctl status
    sudo sbctl status
    sudo sbctl verify
    ```

## Draft: Принципы и архитектура

- При добавлении хоста не должен изменяться `flake.nix`

## Draft: Ограничения и допущения

- Конфигурации Home Manager обновляются при обновлении системы (`nixos-rebuild switch`)
