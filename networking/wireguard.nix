{
  pkgs,
  config,
  lib,
  ...
}:
let
  wireguardInterface = "wg0";
  externalInterface = "enp0s6";
  wgPort = 51820;
in
{
  boot.kernel.sysctl = lib.mkForce {
    "net.ipv4.conf.all.forwarding" = lib.mkOverride 98 true;
    "net.ipv4.conf.default.forwarding" = lib.mkOverride 98 true;
  };

  networking.firewall = {
    allowedTCPPorts = [ 53 ];
    allowedUDPPorts = [
      53
      51820
    ];
  };

  services.dnsmasq = {
    enable = true;
    settings = {
      interface = wireguardInterface;
      server = [
        "8.8.8.8"
        "8.8.4.4"
      ];
    };
  };

  networking.wg-quick.interfaces = {
    "${wireguardInterface}" = {
      address = [ "10.10.0.1/24" ];
      listenPort = wgPort;

      postUp = ''
        ${pkgs.iptables}/bin/iptables -A FORWARD -i ${wireguardInterface} -j ACCEPT
        ${pkgs.iptables}/bin/iptables -t nat -A POSTROUTING -s 10.10.0.1/24 -o ${externalInterface} -j MASQUERADE
      '';

      preDown = ''
        ${pkgs.iptables}/bin/iptables -D FORWARD -i ${wireguardInterface} -j ACCEPT
        ${pkgs.iptables}/bin/iptables -t nat -D POSTROUTING -s 10.10.0.1/24 -o ${externalInterface} -j MASQUERADE
      '';
      privateKeyFile = config.sops.secrets.wg_server_private.path;

      peers = [
        {
          # cronus
          publicKey = "gA6teDhs2Q5+yH/xJeDP8s9najOVE8WErVxW2rPYFCE=";
          allowedIPs = [ "10.10.0.2/32" ];
          presharedKeyFile = config.sops.secrets.wg_cronus_preshared.path;
        }
        {
          # win-nb
          publicKey = "f1r5FX59cVWUNLxy2SohMxaALkPV849o5p+TAL/zqgo=";
          allowedIPs = [ "10.10.0.3/32" ];
          presharedKeyFile = config.sops.secrets.wg_winnb_preshared.path;
        }
      ];
    };
  };
  networking.networkmanager.dns = "systemd-resolved";
  services.resolved.enable = true;
}
