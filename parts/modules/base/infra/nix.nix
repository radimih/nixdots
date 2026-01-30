# https://nix.dev/manual/nix/stable/command-ref/conf-file.html
{
  flake.modules.nixos.base =
    { pkgs, ...}:
    {
      # Для работы flakes нужен git
      environment.systemPackages = [ pkgs.git ];

      # Отключить использование каналов
      nix.channel.enable = false;

      # Включить автоматическую сборку мусора в Nix Store. Будут созданы systemd-юниты nix-gc.timer
      # и nix-gc.service, который под капотом вызывает утилиту nix-collect-garbage ${nix.gc.options}
      nix.gc = {
        automatic = true;
        dates = "weekly";
        options = "--delete-older-than 7d";
        persistent = true;
        randomizedDelaySec = "15min";  # не запускать сразу, если компьютер был долго выключен
      };

      # Установить самые низкие приоритеты для сервиса сборки мусора в Nix Store (nix-gc.service)
      systemd.services.nix-gc.serviceConfig = {
        CPUSchedulingPolicy = "idle";
        IOSchedulingClass = "idle";
      };

      nix.settings = {

        # Включить автоматическое обнаружение в /nix/store файлов с идентичным содержимым и заменять
        # их жёсткими ссылками на одну копию
        auto-optimise-store = true;

        # Тайм-аут (в секундах) для установки соединений с binary cache substituter.
        # Значение по-умолчанию - 0 (отсутствие ограничений)
	      connect-timeout = 5;

        # Отключить все глобальные flake registry (https://channels.nixos.org/flake-registry.json).
        # Останется только один системный nixpkgs, привязанный к inputs.nixpkgs (nix registry list)
        flake-registry = "";

        experimental-features = [
          "flakes"
          "nix-command"
          "pipe-operators"
        ];

        # Включить сборку мусора во время выполнения nixos-rebuild / nix build. Сборка включается
        # когда свободного места на диске становится меньше min-free байт и будет выполняться пока
        # не станет доступно max-free байт. По-умолчанию max-free равен бесконечности, то есть
        # будет удалён весь мусор
	      min-free = 5 * 1024 * 1024 * 1024;  # 5 Gb

        substituters = [
          "https://mirror.yandex.ru/nixos"
          "https://nix-community.cachix.org"
        ];

        trusted-public-keys = [
          "nix-community.cachix.org-1:mB9FSh9qf2dCimDSUo8Zy7bkq5CX+/rkCWyvRCYg3Fs="
        ];

        # Количество секунд, в течение которых загруженный tar-архив считается актуальным
	      tarball-ttl = 24 * 60 * 60;  # 24 часа

        trusted-users = [
          "@wheel"
        ];

        # Использовать XDG-based каталоги для хранения служебной информации
        # (вместо каталогов $HOME/.nix-* использовать $HOME/.local/state/nix)
        # https://nix.dev/manual/nix/latest/command-ref/conf-file#conf-use-xdg-base-directories
	      use-xdg-base-directories = true;

        warn-dirty = false;
      };

      # Даже при отключенных каналах (nix.channel.enable = false) остаются файлы, связанные
      # с каналами (см. описание опции nix.channel.enable). Чтобы команда nixos-rebuild switch
      # перестала выводить об этом предупреждающие сообщения, необходимо удалить эти файлы

      system.activationScripts = {
        rmChannels = ''
          rm -rf /nix/var/nix/profiles/per-user/root/channels
          rm -rf /root/.nix-channels
          rm -rf /root/.nix-defexpr/channels
        '';
      };

      system.userActivationScripts = {
        rmChannels = ''
          rm -rf $HOME/.nix-defexpr/channels
        '';
      };

      # Удалить неиспользуемую при use-xdg-base-directories = true символическую ссылку
      # https://nix.dev/manual/nix/latest/command-ref/files/profiles#user-profile-link

      system.userActivationScripts = {
        rmOldProfileSymLink = ''
          rm -rf $HOME/.nix-profile
        '';
      };
    };
}
