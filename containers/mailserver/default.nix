{ inputs, ... }:
{
  containers.mailserver = {
    autoStart = false;
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
            "ocid1.user.oc1..aaaaaaaas7jey2sgksb3usvd2dtl5hxfjapaufz7h5e4j5wez4vpjywtryeq@ocid1.tenancy.oc1..aaaaaaaap74ers5bdscen43xaqmd6evzacmakqyxoys2z4odtuiuvhmsci6q.u4.com" =
              {
                hashedPassword = "$2b$05$5raDCpds3jxlg6haxM.gEeyW021RjzC8ng4m4wUJL1Kvywk834MOG";
                aliases = [ "smtp.email.eu-frankfurt-1.oci.oraclecloud.com" ];
              };
          };
          certificateScheme = "acme";
        };
        services.postfix = {
          relayHost = "smtp.email.eu-frankfurt-1.oci.oraclecloud.com";
          relayPort = 587;
        };

        security.acme.acceptTerms = true;
        security.acme.defaults.email = "acme@lndbl.de";
        security.acme.defaults.webroot = "/var/lib/acme/.challenges";

        system.stateVersion = "25.05";
      };
  };
}
