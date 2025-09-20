{
  flake.modules.nixos.boot-visual =
    { pkgs, ...}:
    {
      boot.plymouth = {
        enable = true;
        theme = "nixos-bgrt";
        themePackages = [ pkgs.nixos-bgrt-plymouth ];
      };
    };
}
