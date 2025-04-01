{ inputs, ... }:
{
  containers.mailserver = {
    autoStart = true;
    privateNetwork = true;
    hostAddress = "10.0.0.20";
    localAddress = "10.0.0.21";
    forwardPorts = [
      { hostPort = 25; }
      { hostPort = 143; }
      { hostPort = 465; }
      { hostPort = 587; }
      { hostPort = 993; }
    ];
    bindMounts."/var/lib/acme".isReadOnly = true;

    config =
      { ... }:
      {
        imports = [ inputs.mailserver.nixosModule ];
        mailserver = {
          enable = true;
          fqdn = "mail.lndbl.de";
          domains = [ "lndbl.de" ];

          # nix-shell -p mkpasswd --run 'mkpasswd -sm bcrypt'
          loginAccounts = {
            "martin@lndbl.de" = {
              hashedPassword = "$2b$05$yQxecWYH.GJ2m0W2QBharOU4qhiTEJyWI.LGnc83CpINdMOExcGMG";
              aliases = [ ];
              catchAll = [ "lndbl.de" ];
            };
          };

          certificateScheme = "acme";
        };

        security.acme.acceptTerms = true;
        security.acme.defaults.email = "acme@lndbl.de";
        security.acme.defaults.webroot = "/var/lib/acme/.challenges";

        system.stateVersion = "25.05";
      };
  };
}
