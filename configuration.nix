{ config, lib, pkgs, ... }:

{
  imports =
    [
      ./hardware-configuration.nix
    ];

  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  networking.hostName = "eos";
  # networking.networkmanager.enable = true;  # Easiest to use and most distros use this by default.

  # time.timeZone = "Europe/Amsterdam";

  # Select internationalisation properties.
  # i18n.defaultLocale = "en_US.UTF-8";
  # console = {
  #   font = "Lat2-Terminus16";
  #   keyMap = "us";
  #   useXkbConfig = true; # use xkb.options in tty.
  # };

  # Enable the X11 windowing system.
  # services.xserver.enable = true;

  # Configure keymap in X11
  # services.xserver.xkb.layout = "us";
  # services.xserver.xkb.options = "eurosign:e,caps:escape";

  users.users.mrtn = {
    isNormalUser = true;
    extraGroups = [ "wheel" ];
    packages = with pkgs; [ ];
   };

   environment.systemPackages = with pkgs; [
     vim
     git
   ];

  services.openssh.enable = true;
  users.users.root.openssh.authorizedKeys.keys = [
    "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIGLDbWHI/PLBf0hiS0wbHz0ppO/h177fSuRsoZRAq/VD mrtn@mrtnnix-nb"
  ];
  users.users.mrtn.openssh.authorizedKeys.keys = [
    "ecdsa-sha2-nistp521 AAAAE2VjZHNhLXNoYTItbmlzdHA1MjEAAAAIbmlzdHA1MjEAAACFBABCmZLhiHvPWTbyaInI0XBqpbHi5OUdymVr42r2ganFA/7eGfsTi4BN5heBmPkHlay5g/Pl1I0YYJsEF1tdIffqtAGn8riy6BK8cJ76ABl8ZSPQdoVlOuncXzn32BrjJ2kr9BAfCV21WeC2SfpCRYj3sCWZFA2PknSoEfh0kzOTEW22Vg== mrtn@nix-nb"
  ];

  nix.settings.experimental-features = [ "nix-command" "flakes" ];

  # Open ports in the firewall.
  # networking.firewall.allowedTCPPorts = [ ... ];
  # networking.firewall.allowedUDPPorts = [ ... ];
  # Or disable the firewall altogether.
  # networking.firewall.enable = false;

  # Copy the NixOS configuration file and link it from the resulting system
  # (/run/current-system/configuration.nix). This is useful in case you
  # accidentally delete configuration.nix.
  # system.copySystemConfiguration = true;

  system.stateVersion = "25.05";
}

