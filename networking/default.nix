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
}
