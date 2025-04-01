{ ... }:
{

  security.acme.acceptTerms = true;

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
      reloadServices = [ "container@mailserver.service" ];
    };
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
