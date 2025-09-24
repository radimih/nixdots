{
  flake.modules.nixos.desktop =
    { pkgs, ... }:
    {
      fonts = {
        enableDefaultPackages = true;

        packages = with pkgs; [
          # https://www.nerdfonts.com/font-downloads
          nerd-fonts.iosevka
        ];
      };
    };
}
