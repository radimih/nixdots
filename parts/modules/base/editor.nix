{
  flake.modules.nixos.base = {

    programs.neovim = {
      defaultEditor = true;
      enable = true;
      vimAlias = true;
    };

    programs.nano.enable = false;
  };
}
