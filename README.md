# nixdots

Конфигурация моих систем на базе [NixOS](https://nixos.org/).

- [flake-parts](https://github.com/hercules-ci/flake-parts)
- [The Dendritic Pattern](https://github.com/mightyiam/dendritic)

## TODO: установка на новую систему

1. Создать временный токен доступа к GitHub для добавления ssh-ключа нового пользователя в GitHub:

    1. [github.com](https://github.com) → Профиль → `Settings`
    → `Developer Settings`
    → `Personal access tokens`
    → [`Tokens (classic)`](https://github.com/settings/tokens)
    → [`Generate new token (classic)`](https://github.com/settings/tokens/new)
       > Выбран вид токена **classic** только потому что он примерно в два раза
       > короче токена **fine-grained**
    1. Параметры токена:
        - Note: `nixdots-keys` (произвольное название)
        - Expiration: `7 days`
        - Scopes:
          - ☑ `repo`
          - ☑ `admin:org / read:org`
          - ☑ `admin:public_key`
          - ☑ `admin:ssh_signing_key`
    1. Сохранить токен удобным способом

1. Выполнить начальную подготовку:

    ```bash
    nix run github:radimih/nixdots#starter --no-write-lock-file --extra-experimental-features "flakes nix-command"
    ```

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
