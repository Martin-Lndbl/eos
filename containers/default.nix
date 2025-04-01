{ ... }:
{
  imports = [
    ./nginx
    ./mailserver
    ./trilium
  ];

  networking.nat = {
    enable = true;
    internalInterfaces = [ "ve-+" ];
    externalInterface = "enp0s6";
  };

  virtualisation.oci-containers.backend = "docker";
}
