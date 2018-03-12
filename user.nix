{ config, lib, pkgs, ... }:

{
  imports = [
    ./modules
    ./common.nix
  ];

  nix = {
    trustedBinaryCaches = [
      http://hydra.nixos.org
    ];

    binaryCachePublicKeys = [
      "hydra.nixos.org-1:CNHJZBh9K4tP3EKF6FkkgeVYsS3ohTl+oS0Qa8bezVs="
    ];
  };

  powerManagement.cpuFreqGovernor = lib.mkOverride 999 "performance";

  hardware = {
    opengl.driSupport32Bit = true; # for Wine
    pulseaudio = {
      enable = true;
      support32Bit = true; # for Wine
    };
  };

  services = {
    openssh = {
      enable = true;
      passwordAuthentication = false;
      challengeResponseAuthentication = false;
    };

    xserver = {
      enable = true;
      layout = lib.mkDefault "en";
      xkbOptions = "caps:hyper,numpad:microsoft";
      synaptics = {
        enable = lib.mkDefault true;
        twoFingerScroll = true;
        tapButtons = true;
        fingersMap = [1 3 2];
      };

      displayManager.lightdm = {
        enable = true;
        greeters.gtk = {
          theme.package = pkgs.breeze-gtk;
          theme.name = "Breeze";
          # No way to choose hicolor as a fallback. ⇒ https://github.com/NixOS/nixpkgs/issues/30694
          #iconTheme.package = pkgs.breeze-icons;
          #iconTheme.name = "breeze";
        };
      };
      desktopManager.xterm.enable = false;
      windowManager.bspwm.enable = true;
    };
  };

  environment.systemPackages = with pkgs; [
    (lowPrio gnupg1compat)
    (lowPrio stdmanpages)
    (wine.override { pulseaudioSupport = true; })
    arandr
    aspell
    aspellDicts.en
    audacity
    calibre
    cdparanoia
    cdrkit
    cloc
    cool-retro-term
    duplicity
    dvdauthor
    evince
    exiv2
    faad2
    ffmpeg-full
    flac
    gimp
    gitAndTools.gitRemoteGcrypt
    gitstats
    gnupg
    gocr
    gpac
    gparted
    graphicsmagick
    gtk2  # Why? Icon cache! See #20874.
    handbrake
    imagemagick
    imgurbash2
    indent
    inkscape
    jhead
    lame
    libjpeg
    libnotify
    man_db
    manpages
    mpv
    nix-prefetch-scripts
    # nixos-unstable.awf
    # nixos-unstable.catdocx
    # nixos-unstable.devede
    # nixos-unstable.octave
    # nixos-unstable.xpad
    # nixos-unstable.youtube-dl
    normalize
    ntfs3g
    oathToolkit
    odt2txt
    pass
    pavucontrol
    pcmanfm
    pdfgrep
    pdfshuffler
    pinentry
    poppler_utils
    posix_man_pages
    powertop
    python34Packages.livestreamer
    rfkill
    ripgrep
    rtmpdump
    samba
    scantailor
    shared_mime_info
    shellcheck
    shntool
    silver-searcher
    simple-scan
    sox
    stdman
    tesseract
    timidity
    transmission_gtk
    unclutter
    # unfree.nixos-unstable.geekbench
    utox
    winetricks
    wmctrl
    wrk
    x264
    xarchiver
    xautolock
    xbanish
    xcape
    xclip
    xdo
    xdotool
    xorg.xbacklight
    xorg.xdpyinfo
    xorg.xev
    xorg.xhost
    xorg.xmodmap
    xrandr-invert-colors
    xsane
    xsel
    xtitle
  ];

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

  users = let

    immutableDotfiles =  map (p: "${../../../dotfiles}/${p}");
    mutableDotfiles = u: map (p: "${u.home}/.dotfiles/dotfiles/${p}");

  in {

    extraUsers.murlocks = {
      initialPassword = "password1";
      isNormalUser = true;
      uid = 1337;
      description = "Rene Tianco";
      extraGroups = [ "wheel" ];
      dotfiles = immutableDotfiles [ "bspwm" ];
      packages = with pkgs; [
        # Per user packages
      ];
    };

  };

}
