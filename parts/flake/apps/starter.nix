{
  perSystem =
    { pkgs, ... }:
    {
      apps.starter = {
        meta.description = "Hello";
        type = "app";
        program = pkgs.writeShellApplication {
          name = "starter";
          runtimeInputs = with pkgs; [
            gh
            git
          ];
          text = ''
            gh --version
          '';
        };
      };
    };
}
