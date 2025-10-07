# Universal Layout like the https://github.com/braindefender/universal-layout
{
  flake.modules.nixos.service-universal-layout =
    { lib, ...}:
    {
      # TODO: названия раскладок через опции

      services.xserver.xkb = {
        layout = "en1,ru1";
        extraLayouts = {
          en1 = {
            description = "en1";
            languages = [ "eng" ];
            symbolsFile = ./universal-en.xkb;
          };
          ru1 = {
            description = "ru1";
            languages = [ "rus" ];
            symbolsFile = ./universal-ru.xkb;
          };
        };
      };

      # Включить такую же раскладку и для текстовой консоли (/dev/ttyN)
      console.useXkbConfig = lib.mkForce true;
    };
}
