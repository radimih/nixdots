# Universal Layout like the https://github.com/braindefender/universal-layout";
{
  flake.modules.nixos.universal-layout =
    { lib, ...}:
    {
      # TODO: названия раскладок через опции

      services.xserver.xkb = {
        layout = "En,Ru";
        extraLayouts = {
          En = {
            description = "English Universal Layout";
            languages = [ "eng" ];
            symbolsFile = ./universal-en.xkb;
          };
          Ru = {
            description = "Russian Universal Layout";
            languages = [ "rus" ];
            symbolsFile = ./universal-ru.xkb;
          };
        };
      };

      # Включить такую же раскладку и для текстовой консоли (/dev/ttyN)
      console.useXkbConfig = lib.mkForce true;
    };
}
