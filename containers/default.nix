{ ... }:
{
  imports = [
    ./nginx
    ./mailserver
  ];

  networking.nat = {
    enable = true;
    internalInterfaces = [ "ve-+" ];
    externalInterface = "enp0s6";
  };
}
