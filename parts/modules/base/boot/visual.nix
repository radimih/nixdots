{
  # https://github.com/adi1090x/plymouth-themes
  # Список тем: https://github.com/NixOS/nixpkgs/blob/nixos-unstable/pkgs/by-name/ad/adi1090x-plymouth-themes/shas.nix

  flake.modules.nixos.boot-visual-adi1090x =
    { pkgs, ...}:
    {
      boot.plymouth =
      let
        theme = "circle_hud";
      in
      {
        enable = true;
        inherit theme;
        themePackages = [ (pkgs.adi1090x-plymouth-themes.override {selected_themes = [theme];}) ];
      };
    };

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
