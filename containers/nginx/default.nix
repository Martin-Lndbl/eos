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
    bindMounts."/var/lib/acme".isReadOnly = false;

    config =
      {
        lib,
        ...
      }:
      {
        security.acme.acceptTerms = true;
        security.acme.defaults.email = "admin+acme@lndbl.de";

        users.users.nginx.extraGroups = [ "acme" ];

        services.nginx = {
          enable = true;
          virtualHosts = {
            "acmechallenge.lndbl.de" = {
              serverAliases = [ "*.lndbl.de" ];
              locations."/.well-known/acme-challenge" = {
                root = "/var/lib/acme/.challenges";
              };
              locations."/" = {
                return = "301 https://$host$request_uri";
              };
            };
            "foo.lndbl.de" = {
              forceSSL = true;
              useACMEHost = "foo.lndbl.de";
              locations."/".index = "index.html";
            };
          };
        };

        security.acme.certs = {
          "foo.lndbl.de" = {
            webroot = "/var/lib/acme/.challenges";
            email = "foo@lndbl.de";
            group = "nginx";
            # extraDomainNames = [ "mail.lndbl.de" ];
          };
          "mail.lndbl.de" = {
            webroot = "/var/lib/acme/.challenges";
            email = "mail@lndbl.de";
            group = "nginx";
          };
        };

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
