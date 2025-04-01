{ ... }:
{
  virtualisation.oci-containers.containers."trilium" = {
    ports = [ "127.0.0.1:8080:8080" ];
    image = "zadam/trilium:0.63.7";
    hostname = "trilium";
    volumes = [
      "/home/mrtn/.local/share/trilium-data:/home/node/trilium-data"
    ];
  };
}
