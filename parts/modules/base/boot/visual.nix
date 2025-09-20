{
  flake.modules.nixos.boot-visual =
    { pkgs, ...}:
    {
      boot.plymouth = {
        enable = true;
        theme = "matrix";
        themePackages = [ pkgs.plymouth-matrix-theme ];
        # theme = "nixos-bgrt";
        # themePackages = [ pkgs.nixos-bgrt-plymouth ];
      };
    };
}
