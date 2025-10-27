{
  perSystem =
    { pkgs, ... }:
    {
      apps.starter = {
        meta.description = "Hello";
        type = "app";
        program = pkgs.writeShellApplication {
          name = "starter.sh";
          runtimeInputs = with pkgs; [
            gh
            git
          ];
          text = builtins.readFile ./starter.sh;
        };
      };
    };
}
