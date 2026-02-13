# Упрощенная и быстрая альтернатива find: https://github.com/sharkdp/fd
{
  flake.modules.homeManager.shell = {

    programs.fd = {
      enable = true;
      ignores = [
        # добавлены некоторые скрытые каталоги, чтобы они в любом случае
        # игнорировались, даже если команда fd запускается с ключом --hidden/-H
        ".direnv/"
        ".git/"
        "__pycache__/"
        "node_modules/"
        "venv/"
      ];
    };
  };
}
