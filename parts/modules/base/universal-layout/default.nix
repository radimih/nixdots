# Универсальная раскладка клавиатуры, похожая на https://github.com/braindefender/universal-layout
{
  flake.modules.nixos.base =
    { lib, ...}:
    {
      # TODO: названия раскладок через опции

      services.xserver.xkb = {
        layout = "En,Ru";
        extraLayouts = {
          En = {
            description = "English Universal";  # должно совпадать со значением name[Group1] из symbolsFile
            languages = [ "eng" ];
            symbolsFile = ./universal-en.xkb;
          };
          Ru = {
            description = "Russian Universal";  # должно совпадать со значением name[Group1] из symbolsFile
            languages = [ "rus" ];
            symbolsFile = ./universal-ru.xkb;
          };
        };
      };

      # Включить такую же раскладку и для текстовой консоли (/dev/ttyN)
      console.useXkbConfig = lib.mkForce true;
    };
}
