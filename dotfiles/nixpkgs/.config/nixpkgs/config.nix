{
  packageOverrides = pkgs: with pkgs; {

    usrPkgs = pkgs.buildEnv {
      name = "usr-pkgs";
      pathsToLink = [ "/share" "/bin" ];

      paths = [
        # (wine.override { pulseaudioSupport = true; })
        # nixos-unstable.awf
        # nixos-unstable.catdocx
        # nixos-unstable.octave
        # nixos-unstable.xpad
        # nixos-unstable.youtube-dl
        # unfree.nixos-unstable.geekbench
        # winetricks
        (lowPrio gnupg1compat)
        (lowPrio stdmanpages)
        arandr
        aspell
        aspellDicts.en
        audacity
        calibre
        cloc
        duplicity
        exiv2
        faad2
        ffmpeg-full
        flac
        gitAndTools.gitRemoteGcrypt
        gitstats
        gnupg
        gocr
        gpac
        gparted
        graphicsmagick
        imagemagick
        imgurbash2
        indent
        jhead
        lame
        libjpeg
        libnotify
        man_db
        manpages
        mpv
        mupdf
        nix-prefetch-scripts
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
        unclutter
        utox
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
    };
  };
}
