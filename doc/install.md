# Установка системы на новый хост

## Шаг 1. Предварительная подготовка

1. Создать временный токен доступа к GitHub. Нужен будет для добавления в GitHub сгенерированного на новом хосте SSH-ключа пользователя:

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

## Шаг 2. Стандартная минимальная установка NixOS

1. Включить в UEFI BIOS режим **Secure Boot**

## Шаг 3. Настройка

1. Подключиться к сети **Wi-Fi**, если необходимо:

    ```bash
    nmcli device wifi connect 'ИМЯ СЕТИ' password 'ПАРОЛЬ'
    ```

1. Выполнить начальную подготовку (будет выполнен скрипт `starter.sh`):

    ```bash
    nix-shell https://github.com/radimih/nixdots/archive/main.tar.gz
    ```

1. Перейти в каталог с git-репозиторием конфигурации NixOS:

    ```bash
    cd 1git/personal/nixdots
    ```

1. Перешифровать секреты – расшифровать секреты мастер-ключом (будет запрошен пароль к ключу) и
   зашифровать их публичными SSH-ключами хоста и пользователя:

    ```bash
    nix run .#rekey
    ```

   На этом этапе будет автоматически создан файл `flake.lock`.

1. Подготовить git-репозиторий:

    ```bash
    git add --all
    git status
    ```

1. Пересобрать систему:

    ```bash
    sudo nixos-rebuild switch --flake .#ХОСТ
    ```

   Для генерации ключей Secure Boot и внедрения их в EFI компьютер будет автоматически
   перезагружен инструментом [Lanzaboote](https://github.com/nix-community/lanzaboote).

1. Проверить статус **Secure Boot**:

    ```bash
    sudo sbctl status
    ```

1. Перейти в каталог с git-репозиторием конфигурации NixOS:

    ```bash
    cd 1git/personal/nixdots
    ```

1. Внедрить в TPM2 пароль на шифрованный диск, чтобы не запрашивался при загрузке:

    ```bash
    nix run .#tpm2
    ```

    "под капотом" будет выполнена команда

    ```bash
    sudo systemd-cryptenroll \
      --wipe-slot=tpm2 \
      --tpm2-device=auto \
      --tpm2-pcrs=0+2+7+12 \
      /dev/disk/by-partlabel/root
    ```

    - [Platform Configuration Registers (PCRs)](https://wiki.archlinux.org/title/Trusted_Platform_Module#Accessing_PCR_registers)
    - [Linux TPM PCR Registry](https://uapi-group.org/specifications/specs/linux_tpm_pcr_registry/)
