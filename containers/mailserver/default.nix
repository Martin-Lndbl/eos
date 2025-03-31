{ ... }:
{
  containers.mailserver = {
    autoStart = true;
    privateNetwork = true;
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
      { ... }:
      {
        mailserver = {
          enable = true;
          fqdn = "mail.lndbl.de";
          domains = [ "lndbl.de" ];

          # A list of all login accounts. To create the password hashes, use
          # nix-shell -p mkpasswd --run 'mkpasswd -sm bcrypt'
          loginAccounts = {
            "user1@example.com" = {
              hashedPasswordFile = "/a/file/containing/a/hashed/password";
              aliases = [ "postmaster@example.com" ];
            };
          };

          # Use Let's Encrypt certificates. Note that this needs to set up a stripped
          # down nginx and opens port 80.
          certificateScheme = "acme-nginx";
        };
        security.acme.acceptTerms = true;
        security.acme.defaults.email = "security@lndbl.de";
      };
  };
}
