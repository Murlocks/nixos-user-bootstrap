{ config, lib, pkgs, ... }:

{
  imports = [
    ./modules
  ];

  nix = {
    extraOptions = ''
      gc-keep-outputs = true
      build-cache-failure = true
      auto-optimise-store = true
    '';

    useSandbox = true;

    gc = {
      automatic = true;
      dates = "daily";
      options = "--delete-older-than 30d"; # Is this enough?
    };
  };

  powerManagement.cpuFreqGovernor = lib.mkOverride 999 "performance";

  hardware = {
    opengl.driSupport32Bit = true; # for Wine
    pulseaudio = {
      enable = true;
      support32Bit = true; # for Wine
    };
  };

  time.timeZone = "US/East";

  security = {
    pam.services.su.requireWheel = true;

    hideProcessInformation = true;

    sudo.extraConfig = ''
      Defaults timestamp_timeout=0
      %wheel ALL=(root) NOPASSWD: ${config.system.build.nixos-rebuild}/bin/nixos-rebuild switch -k
      %wheel ALL=(root) NOPASSWD: ${config.system.build.nixos-rebuild}/bin/nixos-rebuild switch -k --upgrade
      %wheel ALL=(root) NOPASSWD: ${config.system.build.nixos-rebuild}/bin/nixos-rebuild boot -k
      %wheel ALL=(root) NOPASSWD: ${config.system.build.nixos-rebuild}/bin/nixos-rebuild boot -k --upgrade
      %wheel ALL=(root) NOPASSWD: ${config.nix.package.out}/bin/nix-collect-garbage -d
    '';
  };

  services = {
    xserver = {
      enable = true;
      layout = lib.mkDefault "us";
      xkbOptions = "caps:hyper,numpad:microsoft";

      desktopManager.xterm.enable = false;
      windowManager.bspwm.enable = true;
    };

    openssh = {
      enable = true;
      passwordAuthentication = false;
      challengeResponseAuthentication = false;
    };

    haveged.enable = true;

    smartd.enable = lib.mkDefault true;

    # Because of this insanity… → https://github.com/NixOS/nixpkgs/pull/16021
    logind.extraConfig = ''
      KillUserProcesses=yes
    '';

    journald.extraConfig = ''
      SystemMaxUse=200M
    '';
  };

  programs = {
    zsh = {
      enable = true;
      enableCompletion = true;
    };
    bash.enableCompletion = true;
  };

  environment.variables.PATH = [ "$HOME/.bin" ];

  environment.systemPackages = with pkgs; [
    # nixos-unstable.arping
    # nixos-unstable.preventGC
    bc
    bindfs
    calc
    daemonize
    ddrescue
    dos2unix
    easyrsa
    entr
    file
    gcc
    git
    gnumake
    hdparm
    htop
    hwinfo
    inetutils
    inotify-tools
    iotop
    iw
    jq
    libfaketime
    lm_sensors
    lshw
    lsof
    ltrace
    mkpasswd
    moreutils
    mtr
    ncdu
    netcat-openbsd
    nix-repl
    nmap
    openssl
    p7zip
    pciutils
    pv
    rxvt_unicode
    smartmontools
    socat
    sqlite-interactive
    st
    strace
    stress-ng
    tcpdump
    unzip
    usbutils
    vim
    wget
    which
    wirelesstools
    zip
  ];

  users = let

    # fix paths
    immutableDotfiles =  map (p: "${../../../dotfiles}/${p}");
    mutableDotfiles = u: map (p: "${u.home}/.dotfiles/dotfiles/${p}");

  in {

    mutableUsers = lib.mkDefault false;
    defaultUserShell = "/run/current-system/sw/bin/zsh";

    users = {

      root = {
        initialPassword = "password1";
        dotfiles.profiles = [ "bspwm" ];
      };

      murlocks = {
        initialPassword = "password1";
        isNormalUser = true;
        uid = 1337;
        description = "Rene Tianco";
        extraGroups = [ "wheel" ];
        dotfiles.profiles = [ "bspwm" "nixpkgs" ];
      };

    };
  };

  fonts = {
    enableGhostscriptFonts = true;
    fonts = with pkgs; [
      terminus_font
      unifont
      unifont_upper
      gohufont
      font-awesome-ttf
    ];
  };

  # Stability!
  system.autoUpgrade.enable = lib.mkDefault false;
}
