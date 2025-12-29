# https://github.com/oddlama/agenix-rekey
{
  inputs,
  self,
  ...
}:
{
  imports = [
    # flake-parts.agenix-rekey: https://flake.parts/options/agenix-rekey.html
    inputs.agenix-rekey.flakeModule
  ];

  # flake.agenix-rekey = inputs.agenix-rekey.configure {
  #   userFlake = self;
  #   inherit (self) nixosConfigurations;
  # };
}
