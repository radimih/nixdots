{
  flake.modules.nixos.vpn-it2g =
    { config, pkgs, secrets, ... }:
    {
      networking.networkmanager = {
        ensureProfiles = {
          profiles = {
            it2g = {
              # https://networkmanager.dev/docs/api/latest/nm-settings-nmcli.html
              connection = {
                autoconnect = "false";
                id = "it2g";
                type = "vpn";
              };
              ipv4 = { method = "auto"; };
              proxy = { };
              vpn = {
                ca = "${secrets}/it2g/vpn-ca.pem";
                challenge-response-flags = "2";
                cipher = "AES-256-CBC";
                compress = "lz4";
                connection-type = "password";
                dev = "tun";
                float = "yes";
                password-flags = "1";
                ping = "10";
                ping-restart = "120";
                proto-tcp = "yes";
                # remote = "185.118.64.210:11105";
                remote = secrets.it2g.vpn.server;
                remote-cert-tls = "server";
                service-type = "org.freedesktop.NetworkManager.openvpn";
                ta = "${secrets}/it2g/vpn-ta.pem";
                ta-dir = "1";
                user-name = secrets.it2g.vpn.user;
              };
            };
          };
        };

        plugins = [
          pkgs.networkmanager-openvpn
        ];
      };
    };

  flake.modules.homeManager.vpn-it2g =
    { config, pkgs, secrets, ... }:
    {
      services = {
        network-manager-applet.enable = true;
      };
    };
}
