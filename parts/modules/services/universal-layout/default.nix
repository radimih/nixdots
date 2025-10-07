# Universal Layout like the https://github.com/braindefender/universal-layout
{
  flake.modules.nixos.service-universal-layout =
    { lib, ...}:
    {
      # TODO: названия раскладок через опции

      services.xserver.xkb = {
        layout = "En,Ru";
        extraLayouts = {
          En = {
            description = "en";
            languages = [ "eng" ];
            symbolsFile = ./universal-en.xkb;
          };
          Ru = {
            description = "ru";
            languages = [ "rus" ];
            symbolsFile = ./universal-ru.xkb;
          };
        };
      };

      # Включить такую же раскладку и для текстовой консоли (/dev/ttyN)
      console.useXkbConfig = lib.mkForce true;
    };
}
