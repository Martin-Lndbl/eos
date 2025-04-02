{ ... }:
{
  imports = [
    ./nginx.nix
  ];

  networking.nat = {
    enable = true;
    internalInterfaces = [ "ve-+" ];
    externalInterface = "enp0s6";
  };
  sops.defaultSopsFile = ../secrets/networking.yaml;
  sops.age.keyFile = "/var/lib/sops-nix/keys.txt";
  sops.age.sshKeyPaths = [ ];
  sops.secrets."example_key" = { };
}
