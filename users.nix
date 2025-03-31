{ ... }:
{
  users.users.mrtn = {
    isNormalUser = true;
    extraGroups = [ "wheel" ];
  };
  users.users.mrtn.openssh.authorizedKeys.keys = [
    "ecdsa-sha2-nistp521 AAAAE2VjZHNhLXNoYTItbmlzdHA1MjEAAAAIbmlzdHA1MjEAAACFBABCmZLhiHvPWTbyaInI0XBqpbHi5OUdymVr42r2ganFA/7eGfsTi4BN5heBmPkHlay5g/Pl1I0YYJsEF1tdIffqtAGn8riy6BK8cJ76ABl8ZSPQdoVlOuncXzn32BrjJ2kr9BAfCV21WeC2SfpCRYj3sCWZFA2PknSoEfh0kzOTEW22Vg== mrtn@nix-nb"
    "ecdsa-sha2-nistp521 AAAAE2VjZHNhLXNoYTItbmlzdHA1MjEAAAAIbmlzdHA1MjEAAACFBACZkmXdEDbg/5gtbANAYQfSaFKEluiGuQpa6MCA+msQIx2lr/1M7+Lmcf3sWG3kYyYJZFZ+6+sUmUFqgeJWN6jOogGSfK/OEyY/zKdrIqcSIsvoHREhG/10VXSbGWv+MS9FjxuT4AO40FLRF5pq8cGQgUcm3khAknF4yQ6TtJQyxU4OOw== mrtn@cronus"
  ];
}
