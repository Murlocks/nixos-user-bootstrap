{ config, lib, pkgs, ... }:

{
  imports = [
    ./modules
    ./base.nix
    ./hardware-configuration.nix
  ];

  # created by initial nixos config generation
  #############################################
  # boot.loader.grub.enable = true;
  # boot.loader.grub.version = 2;
  boot.loader.grub.device = "/dev/sda";

  security.rngd.enable = false;

  services.vmwareGuest.enable = true;
}
