# Просмотр шрифтов в Kitty: kitten choose-fonts
{
  flake.modules.nixos.desktop =
    { pkgs, ... }:
    {
      fonts = {
        enableDefaultPackages = true;

        # Nerd Fonts: https://www.nerdfonts.com/font-downloads

        packages = with pkgs.nerd-fonts; [
          iosevka
          jetbrains-mono
          roboto-mono
        ];
      };
    };
}
