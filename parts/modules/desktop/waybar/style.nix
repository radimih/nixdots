# https://github.com/Alexays/Waybar/wiki/Styling
{
  flake.modules.nixos.desktop =
    { pkgs, ... }:
    {
      fonts = {
        packages = with pkgs; [
          # https://www.nerdfonts.com/font-downloads
          nerd-fonts.jetbrains-mono
        ];
      };
    };

  flake.modules.homeManager.waybar = {

    programs.waybar.style = ''
      * {
        font-family: "JetBrainsMonoNFM";
        font-size: 11pt;
      }
      window#waybar {
        background: #000000;
      }
      tooltip {
        background: alpha(#000000, 0.8);
      }
      #clock.msk {
        color: #707070;
      }
    '';

    stylix.targets.waybar.enable = false;
  };
}
