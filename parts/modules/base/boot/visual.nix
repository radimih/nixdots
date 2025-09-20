{
  flake.modules.nixos.boot-visual =
    { pkgs, ...}:
    {
      boot.plymouth = {
        enable = true;
        theme = "catppuccin-macchiato";
        themePackages = [ pkgs.catppuccin-plymouth ];
        # theme = "nixos-bgrt";
        # themePackages = [ pkgs.nixos-bgrt-plymouth ];
      };
    };
}
