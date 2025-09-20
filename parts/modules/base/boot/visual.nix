{
  # https://github.com/catppuccin/plymouth
  flake.modules.nixos.boot-visual-catppuccin =
    { pkgs, ...}:
    {
      boot.plymouth = {
        enable = true;
        theme = "catppuccin-macchiato";  # latte, frappe, macchiato, mocha
        themePackages = [ pkgs.catppuccin-plymouth ];
      };
    };

  # Медленное вращение чуть увеличенного чёрно-белого логотипа NixOS
  flake.modules.nixos.boot-visual-nixos-rotate =
    { pkgs, ...}:
    {
      boot.plymouth = {
        enable = true;
        theme = "nixos-bgrt";
        themePackages = [ pkgs.nixos-bgrt-plymouth ];
      };
    };
}
