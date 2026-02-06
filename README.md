# nixdots

Конфигурация моих систем на базе [NixOS](https://nixos.org/).

[Установка на новый хост](doc/install.md)

## Draft: Принципы и архитектура

- [flake-parts](https://github.com/hercules-ci/flake-parts)
- [The Dendritic Pattern](https://github.com/mightyiam/dendritic)
- При добавлении хоста не должен изменяться `flake.nix`
- Конфигурации Home Manager обновляются при обновлении системы (`nixos-rebuild switch`)

## Draft: Структура каталогов

- `parts/modules/services` - сервисы, которые могут включаться на определённых хостах
