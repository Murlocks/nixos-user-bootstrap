{ config, lib, pkgs, ... }:

{
  imports = [
    ./modules
    ./common.nix
    ./hardware-configuration.nix
  ];

  boot.loader.grub.enable = true;
  boot.loader.grub.version = 2;
  boot.loader.grub.device = "/dev/sda";

  security.rngd.enable = false;

  time.timeZone = "US/East";

  services.vmwareGuest.enable = true;

  system.stateVersion = "17.09";
}
