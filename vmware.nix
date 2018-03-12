{ config, lib, pkgs, ... }:

{
  imports = [
    ./modules
    ./user.nix
    ./hardware-configuration.nix
  ];

  boot = {
    loader = {
      grub.enable = true;
      grub.version = 2;
      grub.device = "/dev/sda"
    };
  };

  security.rngd.enable = false;

  time.timeZone = "US/East";

  services.vmwareGuest.enable = true;

  system.stateVersion = "17.09";
}
