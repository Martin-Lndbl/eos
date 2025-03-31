{ ... }:
{
  containers.nginx = {
    autoStart = true;
    privateNetwork = true;
    hostAddress = "10.0.0.10";
    localAddress = "10.0.0.11";
    forwardPorts = [
      {
        hostPort = 80;
        containerPort = 80;
      }
      {
        hostPort = 443;
        containerPort = 443;
      }
    ];
    config =
      {
        lib,
        ...
      }:
      {
        services.nginx = {
          enable = true;
          virtualHosts = {
            "lndbl.de" = {
              addSSL = true;
              enableACME = true;
              locations."/" = {
                index = "index.html";
              };
            };
          };
        };

        security.acme.acceptTerms = true;
        security.acme.defaults.email = "acme@lndbl.de";

        services.resolved.enable = true;
        networking = {
          firewall = {
            enable = true;
            allowedTCPPorts = [
              80
              443
            ];
          };
          useHostResolvConf = lib.mkForce false;
        };

        system.stateVersion = "25.05";
      };
  };
}
