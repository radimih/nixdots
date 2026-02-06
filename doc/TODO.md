# Запланированные работы

## Донастройка TMP2-based LUKS auto-unlock

Чел **oddlama** в своей статье [Bypassing disk encryption on systems with automatic TPM2 unlock](https://oddlama.org/blog/bypassing-disk-encryption-with-tpm2-unlock/)
продемонстрировал как можно обойти защиту, если используются только PCR'ы 0, 2, 7, 12.

И предложил дополнительно использовать **PCR 15**.

Совместно с **patrick** реализовал в NixOS формирование значения для PCR 15 и его сравнение на этапе
загрузки:

- модуль [ensure-pcr.nix](https://forge.lel.lol/patrick/nix-config/src/branch/master/modules/ensure-pcr.nix)
- [пример](https://forge.lel.lol/patrick/nix-config/src/branch/master/hosts/patricknix/fs.nix)
  использования параметра `systemIdentity`.

Минусы:

- в git необходимо коммитить эталонное значение PCR 15
- как-то завязан на порядке определения дисков

### Дискуссия [A Modern and Secure Desktop Setup](https://discourse.nixos.org/t/a-modern-and-secure-desktop-setup/41154)

Чел **ElvishJerricco** в своём [сообщении](https://discourse.nixos.org/t/a-modern-and-secure-desktop-setup/41154/17)
предложил свой способ использования **PCR 15**.

Чел **LRFLEW** в [сообщении](https://discourse.nixos.org/t/a-modern-and-secure-desktop-setup/41154/41)
написал инструкцию по использованию **PCR 15**.

### Дополнительно

В [tpm-decrypt.nix](https://github.com/lovesegfault/nix-config/blob/master/configurations/nixos/hegel/tpm-decrypt.nix)
в dotfiles какого-то чела _очень интересные и основательные комментарии_. Он использует только `7+15` PCRs.

Можно почитать более современную, но короткую дискуссию
[Any risks on this time to use tpm2 pcr 0+2+7 to unlock](https://discourse.nixos.org/t/any-risks-on-this-time-to-use-tpm2-pcr-0-2-7-to-unlock/73354).

### Ссылки

- [Platform Configuration Registers (PCRs)](https://wiki.archlinux.org/title/Trusted_Platform_Module#Accessing_PCR_registers)
- [Linux TPM PCR Registry](https://uapi-group.org/specifications/specs/linux_tpm_pcr_registry/)

## Под вопросом

- Сервис [angrr](https://github.com/linyinfeng/angrr) - Auto Nix GC Root Retention
  ([options](https://search.nixos.org/options?channel=unstable&query=services.angrr))
- [FirewallD](https://firewalld.org/), a firewall daemon with D-Bus interface providing a dynamic firewall.
  Available as [services.firewalld](https://search.nixos.org/options?channel=unstable&query=services.firewalld)
  and a [networking.firewall.backend](https://search.nixos.org/options?channel=unstable&query=networking.firewall.backend)
- [gtklock](https://github.com/jovanlanik/gtklock), a GTK-based lockscreen for Wayland.
  Available as [programs.gtklock](https://search.nixos.org/options?channel=unstable&query=programs.gtklock)
