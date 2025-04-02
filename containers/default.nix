{ ... }:
{
  imports = [
    ./networking.nix
    ./mailserver
    ./trilium
  ];

  virtualisation.oci-containers.backend = "docker";
}
