{ ... }:
{
  virtualisation.docker.enable = true;
  # virtualisation.oci-containers.backend = "docker";
  # virtualisation.oci-containers.containers."trilium" = {
  #   autoStart = true;
  #   image = "triliumnext/notes:v0.90.4";
  #   hostname = "trilium";
  #   volumes = [
  #     "/home/mrtn/.local/share/trilium-data:/home/node/trilium-data"
  #   ];
  #   extraOptions = [ "--network=net_trilium" ];
  # };
}
