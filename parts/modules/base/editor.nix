{
  flake.modules.nixos.base = {

    programs.neovim = {
      defaultEditor = true;
      enable = true;
      vimAlias = true;
      withPython3 = false;
      withRuby = false;
    };

    programs.nano.enable = false;
  };
}
