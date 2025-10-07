# Просмотр шрифтов в Kitty: kitten choose-fonts
{
  flake.modules.nixos.desktop =
    { pkgs, ... }:
    {
      fonts = {
        enableDefaultPackages = true;

        # Nerd Fonts: https://www.nerdfonts.com/font-downloads

        packages = with pkgs.nerd-fonts; [
          iosevka         # IosevkaNF[M][{-Thin|-ExtraLight|-Light|-Medium|-SemiBold|-Bold}]
          jetbrains-mono  # JetBrainsMonoNF[M][{-Thin|-ExtraLight|-Light|-Medium|-SemiBold|-Bold}]
          roboto-mono     # RobotoMonoNF[M]{-Th|-Lt|-Rg|-Md}
        ];
      };
    };
}
