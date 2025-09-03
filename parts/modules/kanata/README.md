# NixOS-модуль `kanata`

Переопределение поведения некоторых клавиш с помощью [kanata](https://github.com/jtroo/kanata)
([Kanata Configuration Guide](https://jtroo.github.io/config.html)):

| Клавиша       | Однократное нажатие         | На удержании
|:-------------:|:---------------------------:|:------------:
| `CapsLock`    | `ESC`                       | `h`, `j`, `k`, `l` - как в Vim
| `Left Shift`  | `Ctrl + Shift + Meta + F11` | `Left Shift`
| `Right Shift` | `Ctrl + Shift + Meta + F12` | `Right Shift`
| `Space`       | `Space`                     | `Right Alt` (`AltGr`)

Плюс, реализован режим [Home Row Mods](https://precondition.github.io/home-row-mods).

Чтобы принудительно завершить сервис `kanata` необходимо нажать комбинацию `Left Ctrl + Space + ESC`.
