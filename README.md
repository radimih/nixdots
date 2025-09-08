# nixdots

Конфигурация моих систем на базе [NixOS](https://nixos.org/).

- [flake-parts](https://github.com/hercules-ci/flake-parts)
- [The Dendritic Pattern](https://github.com/mightyiam/dendritic)

## TODO: Установка на новую систему

1. Выполнить начальную настройку с помощью [nixos-starter](https://github.com/radimih/nixos-starter)

1. Создать SecureBoot-ключи хоста и записать их в EFI-память:

    ```bash
    sudo nix-shell -p sbctl
    sbctl create-keys
    sbctl enroll-keys --microsoft
    sbctl status
    exit
    ```

    ВНИМАНИЕ! Не перегружать компьютер!

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

1. Проверить:

    ```bash
    sudo bootctl status
    sudo sbctl status
    sudo sbctl verify
    ```

1. Внедрить в TPM2 пароль на шифрованный диск, чтобы не запрашивался при загрузке:

    ```bash
    sudo systemd-cryptenroll --wipe-slot=tpm2 --tpm2-device=auto --tpm2-pcrs=0+2+7+12 /dev/disk/by-partlabel/root
    ```

    - [Platform Configuration Registers (PCRs)](https://wiki.archlinux.org/title/Trusted_Platform_Module#Accessing_PCR_registers)

## Draft: Принципы и архитектура

- При добавлении хоста не должен изменяться `flake.nix`

## Draft: Ограничения и допущения

- Конфигурации Home Manager обновляются при обновлении системы (`nixos-rebuild switch`)
