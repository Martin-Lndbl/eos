{ ... }:
{
  imports = [
    ./mailserver
    ./trilium
  ];

  virtualisation.oci-containers.backend = "docker";
}
