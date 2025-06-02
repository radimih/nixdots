{
  globalSpec,
  pkgs,
  ...
}:

{
  programs.fish = {
    enable = true;
    interactiveShellInit = ''
      set fish_greeting
      fish_vi_key_bindings
      set fish_cursor_default      block
      set fish_cursor_insert       line
      set fish_cursor_replace_one  underscore
      set fish_cursor_replace      underscore
      set fish_cursor_visual       block
      set fish_cursor_external     line
    '';
  };

  users = {
    defaultUserShell = pkgs.fish;
    users.${globalSpec.admin.name} = {
      description = globalSpec.admin.desc;
      isNormalUser = true;
      extraGroups = [
        "networkmanager"
        "wheel"
      ];
    };
  };
}
