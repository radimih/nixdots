{
  flake.modules.nixos.base = {

    boot = {
      loader = {
        efi.canTouchEfiVariables = true;
        systemd-boot = {
          configurationLimit = 5;
          editor = false;
          enable = true;
        };
      };
    };
  };
}
