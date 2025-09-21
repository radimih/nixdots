{
  flake.modules.nixos.desktop =
    { pkgs, ... }:
    {
      fonts = {
        # FontConfig нужен только для X11
        fontconfig.enable = false;

        packages = with pkgs; [
          # https://www.nerdfonts.com/font-downloads
          nerd-fonts.iosevka
        ];
      };
    };
}
