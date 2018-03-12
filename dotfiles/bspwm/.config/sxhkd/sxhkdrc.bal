#######################################################
# BSPWM HOTKEYS
#######################################################


# GENERAL MANAGEMENT
# ------------------

## close the window
alt + w
	bspc window -c

## hide all the windows
alt + t
	bspc control --toggle-visibility


super + {h,l}
    bspc monitor -f {prev,next}



# DESKTOP HOTKEYS
# ---------------

## focus the selected desktop
alt + {1-9}
        bspc desktop -f ^{1-9}

## cycle through the desktops
alt + bracket{left,right}
	bspc desktop -f {prev,next}

## toggle window properties - floating and fullscreen
alt + {s,f,p,i,r}
	bspc window -t {floating,fullscreen,pseudo_tiled,sticky,private}






# WINDOW MANAGEMENT
# -----------------

## send the window to the given direction
super + shift + {h, j, k, l}
        bspc window -s {left,down,up,right}

## swap the selected window with the biggest window
alt + {h, j, k, l}
	bspc window -f {left,down,up,right,biggest}

## focus on the last focused window and desktop
alt + {Tab,grave}
	bspc {window,desktop} -f last

## define the area in which the next window should appear
alt + shift + {h, j, k, l}
	bspc window -p {left,down,up,right}

## send the window to the given desktop
# alt + ctrl + shift + {1-9}
#         bspc window -d ^{1-9}








# WINDOW SIZE MANAGEMENT
# ----------------------

## increase/decrease the size of the windows when multiple windows are present
ctrl + alt + {k,h,j,l}
	bspc window -e {up +10,right -10,up -10,right +10}

## increase/decrease the size of the windows when multiple windows are present
ctrl + alt + shift + {k,h,j,l}
	bspc window -e {down +10,left -10,down -10,left +10}

# make all windows occupy equal areas
alt + b
	bspc desktop -E










# MOUSE MANAGEMENT
# ----------------

## !move and resize windows
alt + button{1-3}
	bspc pointer -g {move,resize_side,resize_corner}

alt + !button{1-3}
        bspc pointer -t %i, %i

## !ungrab on key release - paired with the previous hotkey
alt + @button{1-3}
	bspc pointer -u




# MISCELLANEOUS
# -------------


# logout
super + alt + Escape
	pkill -x panel; \
        bspc quit

# ?
alt + {o,i}
	bspc control --record-history off; \
	bspc window {older,newer} -f; \
	bspc control --record-history on


# cancel the preselection
alt + ctrl + {_,shift + }space
	bspc {window -p cancel,desktop -c}


# focus the left-clicked window - unecessary
# ~button1
# 	bspc pointer -g focus

# make sxhkd reload its configuration files:
alt + Escape
	pkill -USR1 -x sxhkd


#######################################
# APPLICATION SHORTCUTS
#######################################


alt + Return
	urxvtc -cd $HOME

alt + space
	dmenu_run_custom

alt + v
    dmenuclip_wrapper

alt + c
    dmenu_calc

# super + Insert
#         bspc desktop -f ^6; \
#         clementine

# super + Home
#         bspc desktop -f ^7; \
#         anki

# super + Prior
#         bspc desktop -f ^7; \
#         uget-gtk

# super + Delete
#         lxtask

# super + End
#         bspc desktop -f ^3; \
#         bash -c 'GTK2_RC_FILES=/usr/share/themes/Industrial/gtk-2.0/gtkrc firefox'

# super + Next
#         bspc desktop -f ^4; \
#         bash -c 'GTK2_RC_FILES=/usr/share/themes/Industrial/gtk-2.0/gtkrc keepass'

# super + Scroll_Lock
#         bspc desktop -f ^5; \
#         stellarium
