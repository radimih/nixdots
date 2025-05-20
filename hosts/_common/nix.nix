{
  config,
  ...
}:

{
  nix.channel.enable = false;

  nix.settings = {
    auto-optimise-store = true;
    experimental-features = [
      "flakes"
      "nix-command"
      "pipe-operators"
    ];
    warn-dirty = false;
  };
}
