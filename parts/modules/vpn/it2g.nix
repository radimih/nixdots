{
  flake.modules.nixos.vpn-it2g =
    { config, pkgs, secrets, ... }:
    {
      age.secrets = {
        it2g-vpn-ca.rekeyFile ="${secrets}/it2g/vpn-ca.pem.age";
        it2g-vpn-ta.rekeyFile ="${secrets}/it2g/vpn-ta.pem.age";
      };

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
                ca = config.age.secrets.it2g-vpn-ca.path;
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
                remote = secrets.it2g.vpn.server;
                remote-cert-tls = "server";
                service-type = "org.freedesktop.NetworkManager.openvpn";
                ta = config.age.secrets.it2g-vpn-ta.path;
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
