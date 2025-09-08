{
  flake.modules.nixos.boot = {

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
