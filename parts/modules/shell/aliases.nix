# Shell-алиасы. Текущий список алиасов можно получить командой alias
{
  flake.modules.homeManager.shell = {

    # По-умолчанию для всех пользователей уже определены некоторые алиасы в исходниках NixOS:
    #
    #   environment.shellAliases = lib.mapAttrs (name: lib.mkDefault) {
    #     ls = "ls --color=tty";
    #     ll = "ls -l";
    #     l = "ls -alh";
    #   };
    #
    # https://github.com/NixOS/nixpkgs/blob/master/nixos/modules/config/shells-environment.nix
    #
    # Дополнительно, в Home Manager в programs.eza включена по-умолчанию shell-интеграция,
    # которая добавляет следующие алиасы:
    #
    #   ls = "eza";
    #   ll = "eza -l";
    #   la = "eza -a";
    #   lt = "eza --tree";
    #   lla = "eza -la";
    #
    # https://github.com/nix-community/home-manager/blob/master/modules/programs/eza.nix

    home.shellAliases = {
        cat = "bat";
        grep = "rg";
        lt = "eza --tree --level=2";
        tree = "eza --tree";
        yz = "yazi";
    };
  };
}
