{ ... }:
{

  security.acme.acceptTerms = true;

  users.users.nginx.extraGroups = [ "acme" ];

  services.nginx = {
    enable = true;
    virtualHosts = {
      "acmechallenge.lndbl.de" = {
        serverAliases = [
          "lndbl.de"
          "*.lndbl.de"
        ];
        locations."/.well-known/acme-challenge" = {
          root = "/var/lib/acme/.challenges";
        };
        locations."/" = {
          return = "301 https://$host$request_uri";
        };
      };
      "appflowy.lndbl.de" = {
        forceSSL = true;
        useACMEHost = "lndbl.de";
        locations."/".proxyPass = "trilium";
      };
      "lndbl.de" = {
        forceSSL = true;
        useACMEHost = "lndbl.de";
        locations."/".index = "index.html";
      };
    };
  };

  security.acme.defaults.email = "acmechallenge@lndbl.de";
  security.acme.defaults.webroot = "/var/lib/acme/.challenges";
  security.acme.defaults.group = "nginx";

  security.acme.certs = {
    "lndbl.de".extraDomainNames = [ "appflowy.lndbl.de" ];
    "mail.lndbl.de".reloadServices = [ "container@mailserver.service" ];
  };

  networking = {
    firewall = {
      enable = true;
      allowedTCPPorts = [
        80
        443
      ];
    };
  };
}
