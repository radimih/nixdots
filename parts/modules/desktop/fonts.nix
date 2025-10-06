{
  flake.modules.nixos.desktop =
    { pkgs, ... }:
    {
      fonts = {
        enableDefaultPackages = true;

        # Просмотр шрифтов в Kitty: kitten choose-fonts
        packages = with pkgs; [
          # https://www.nerdfonts.com/font-downloads
          nerd-fonts.iosevka
        ];
      };
    };
}
