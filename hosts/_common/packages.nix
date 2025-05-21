{
  pkgs,
  ...
}:

{
  environment.systemPackages = with pkgs; [
    fish
    git
    vim
  ];
}
