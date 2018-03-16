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

  services = {
	vmwareGuest.enable = true;
	xserver.resolutions = [ {x = 1920; y = 1200;} {x = 1920; y = 1080;} ];
	xserver.videoDrivers = [ "vmware" ];
};

}
