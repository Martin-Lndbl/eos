{ ... }:
{
  imports = [
    ./nginx.nix
    ./wireguard.nix
  ];

  networking.nat = {
    enable = true;
    internalInterfaces = [ "ve-+" ];
    externalInterface = "enp0s6";
  };
  sops.defaultSopsFile = ../secrets/networking.yaml;
  sops.age.keyFile = "/var/lib/sops-nix/keys.txt";
  sops.age.sshKeyPaths = [ ];
  sops.secrets."wg_server_private" = { };
  sops.secrets."wg_cronus_preshared" = { };
  sops.secrets."wg_winnb_preshared" = { };
}
