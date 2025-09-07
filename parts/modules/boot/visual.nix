{
  flake.modules.nixos.boot-visual = {

    boot = {
      plymouth.enable = false;
    };
  };
}
