# Настройка Vaultix на уровне flake: https://milieuim.github.io/vaultix/flake-module.html
{
  inputs,
  ...
}:
{
  imports = [ inputs.vaultix.flakeModules.default ];

  flake.vaultix = {
    # extraRecipients = [ ];                 # default, optional
    # cache = "./secrets/cache";             # default, optional
    # defaultSecretDirectory = "./secrets";  # default, optional
    # nodes = self.nixosConfigurations;      # default, optional
    # extraPackages = [ ];                   # default, optional
    # pinentryPackage = null;                # default, optional

    # identity = inputs.self + "/secrets/master-key.age";
    identity = inputs.self + "/secrets/trial.key.age";
  };
}
