#!/bin/sh

# global environment variables you may set:
# CACHE: absolute path to a global autoconf cache
# QUIET: hush the configure script noise

build() {
    echo "Building $1 module component $2..."
    cd $1/$2

    # Use "sh autogen.sh" since some scripts are not executable in CVS
    sh autogen.sh --prefix=${PREFIX} ${QUIET:+--quiet} \
        ${CACHE:+--cache-file=}${CACHE} || exit 1
    make || exit 1
    $SUDO env LD_LIBRARY_PATH=$LD_LIBRARY_PATH make install || exit 1
#    make clean || exit 1
#    make dist || exit 1
#    make distcheck || exit 1

    cd ../..
}

# protocol headers have no build order dependencies
build_proto() {
    build proto BigReqs
    build proto Composite
    build proto Damage
    build proto DMX
    build proto EvIE
    build proto Fixes
    build proto Fontcache
    build proto Fonts
    build proto GL
    build proto Input
    build proto KB
    build proto PM
    build proto Print
    build proto Randr
    build proto Record
    build proto Render
    build proto Resource
    build proto ScrnSaver
    build proto Trap
    build proto Video
    build proto X11
    build proto XCMisc
    build proto XExt
    build proto XF86BigFont
    build proto XF86DGA
    build proto XF86DRI
    build proto XF86Misc
    build proto XF86Rush
    build proto XF86VidMode
    build proto Xinerama
}

# bitmaps is needed for building apps, so has to be done separately first
# cursors depends on apps/xcursorgen
# xkbdata depends on apps/xkbcomp
build_data() {
#    build data bitmaps
    build data cursors
    build data xkbdata
}

# All protocol modules must be installed before the libs (okay, that's an
# overstatement, but all protocol modules should be installed anyway)
#
# the libraries have a dependency order:
# xtrans, Xau, Xdmcp before anything else
# fontenc before Xfont
# ICE before SM
# X11 before Xext
# (X11 and SM) before Xt
# Xt before Xmu and Xpm
# Xext before any other extension library
# Xfixes before Xcomposite
# Xp before XprintUtil before XprintAppUtil
build_lib() {
    build lib xtrans
    build lib Xau
    build lib Xdmcp
    build lib X11
    build lib Xext
    build lib dmx
    build lib fontenc
    build lib FS
    build lib ICE
    build lib lbxutil
    build lib oldX
    build lib SM
    build lib Xt
    build lib Xmu
    build lib Xpm
    build lib Xp
    build lib Xaw
    build lib Xfixes
    build lib Xcomposite
    build lib Xrender
    build lib Xdamage
    build lib Xcursor
    build lib Xevie
    build lib Xfont
    build lib Xfontcache
    build lib Xft
    build lib Xi
    build lib Xinerama
    build lib xkbfile
    build lib xkbui
    build lib XprintUtil
    build lib XprintAppUtil
    build lib Xrandr
    build lib XRes
    build lib XScrnSaver
    build lib XTrap
    build lib Xtst
    build lib Xv
    build lib XvMC
    build lib Xxf86dga
    build lib Xxf86misc
    build lib Xxf86vm
}

# Most apps depend at least on libX11.
#
# bdftopcf depends on libXfont
# mkfontscale depends on libfontenc and libfreetype
# mkfontdir depends on mkfontscale
#
# TODO: detailed breakdown of which apps require which libs
build_app() {
    build app appres
    build app bdftopcf
    build app beforelight
    build app bitmap
    build app editres
    build app fonttosfnt
    build app fslsfonts
    build app fstobdf
    build app iceauth
    build app ico
    build app lbxproxy
    build app listres
    build app luit
    build app mkfontdir
    build app mkfontscale
    build app oclock
    build app pclcomp
    build app proxymngr
    build app rgb
    build app rstart
    build app scripts
    build app setxkbmap
    build app showfont
    build app smproxy
    build app twm
    build app viewres
    build app x11perf
    build app xauth
    build app xbiff
    build app xcalc
    build app xclipboard
    build app xclock
    build app xcmsdb
    build app xconsole
    build app xcursorgen
    build app xdbedizzy
    build app xditview
    build app xdm
    build app xdpyinfo
    build app xedit
    build app xev
    build app xeyes
    build app xf86dga
    build app xfd
    build app xfontsel
    build app xfs
    build app xfsinfo
    build app xfwp
    build app xgamma
    build app xgc
    build app xhost
    build app xinit
    build app xkbcomp
    build app xkbevd
    build app xkbprint
    build app xkbutils
    build app xkill
    build app xload
    build app xlogo
    build app xlsatoms
    build app xlsclients
    build app xlsfonts
    build app xmag
    build app xman
    build app xmessage
    build app xmh
    build app xmodmap
    build app xmore
    build app xphelloworld
    build app xplsprinters
    build app xpr
    build app xprehashprinterlist
    build app xprop
    build app xrandr
    build app xrdb
    build app xrefresh
    build app xset
    build app xsetmode
    build app xsetpointer
    build app xsetroot
    build app xsm
    build app xstdcmap
    build app xtrap
    build app xvidtune
    build app xvinfo
    build app xwd
    build app xwininfo
    build app xwud
}

# The server requires at least the following libraries:
# Xfont, Xau, Xdmcp
build_xserver() {
    build xserver xorg
}

build_driver_input() {

    HOST_OS=`uname -s`

    # Some drivers are only buildable on some OS'es
    case $HOST_OS in
	Linux)
	    build driver xf86-input-aiptek
	    build driver xf86-input-evdev
# not built in monolith, doesn't build for lots of systems
#	    build driver xf86-input-ur98
	    ;;
	*)
	    ;;
    esac

    build driver xf86-input-acecad
    build driver xf86-input-calcomp
    build driver xf86-input-citron
    build driver xf86-input-digitaledge
    build driver xf86-input-dmc
    build driver xf86-input-dynapro
    build driver xf86-input-elo2300
    build driver xf86-input-elographics
    build driver xf86-input-fpit
    build driver xf86-input-hyperpen
    build driver xf86-input-jamstudio
    build driver xf86-input-joystick
    build driver xf86-input-keyboard
    build driver xf86-input-magellan
    build driver xf86-input-magictouch
    build driver xf86-input-microtouch
    build driver xf86-input-mouse
    build driver xf86-input-mutouch
    build driver xf86-input-palmax
    build driver xf86-input-penmount
    build driver xf86-input-sample
    build driver xf86-input-spaceorb
    build driver xf86-input-summa
    build driver xf86-input-tek4957
    build driver xf86-input-void
}

build_driver_video() {

    HOST_OS=`uname -s`

    # Some drivers are only buildable on some OS'es
    case $HOST_OS in
	*BSD* | *bsd*)
	    build driver xf86-video-wsfb
	    build driver xf86-video-sunffb
	    ;;
	*Linux*)
	    build driver xf86-video-sisusb
	    build driver xf86-video-sunffb
	    ;;
	*)
	    ;;
    esac

    build driver xf86-video-apm
    build driver xf86-video-ark
    build driver xf86-video-ati
    build driver xf86-video-chips
    build driver xf86-video-cirrus
    build driver xf86-video-cyrix
    build driver xf86-video-dummy
    build driver xf86-video-fbdev
#    build driver xf86-video-glide
    build driver xf86-video-glint
    build driver xf86-video-i128
    build driver xf86-video-i740
    build driver xf86-video-i810
    build driver xf86-video-imstt
    build driver xf86-video-mga
    build driver xf86-video-neomagic
    build driver xf86-video-newport
    build driver xf86-video-nsc
    build driver xf86-video-nv
    build driver xf86-video-rendition
    build driver xf86-video-s3
    build driver xf86-video-s3virge
    build driver xf86-video-savage
    build driver xf86-video-siliconmotion
    build driver xf86-video-sis
    build driver xf86-video-sunbw2
    build driver xf86-video-suncg14
    build driver xf86-video-suncg3
    build driver xf86-video-suncg6
    build driver xf86-video-sunleo
    build driver xf86-video-suntcx
    build driver xf86-video-tdfx
    build driver xf86-video-tga
    build driver xf86-video-trident
    build driver xf86-video-tseng
    build driver xf86-video-vesa
    build driver xf86-video-vga
    build driver xf86-video-via
    build driver xf86-video-vmware
    build driver xf86-video-voodoo
}

# The server must be built before the drivers
build_driver() {
    build_driver_input
    build_driver_video
}

# All fonts require mkfontscale and mkfontdir to be available
#
# The following fonts require bdftopcf to be available:
#   adobe-100dpi, adobe-75dpi, adobe-utopia-100dpi, adobe-utopia-75dpi,
#   arabic-misc, bh-100dpi, bh-75dpi, bh-lucidatypewriter-100dpi,
#   bh-lucidatypewriter-75dpi, bitstream-100dpi, bitstream-75dpi,
#   cronyx-cyrillic, cursor-misc, daewoo-misc, dec-misc, isas-misc,
#   jis-misc, micro-misc, misc-cyrillic, misc-misc, mutt-misc,
#   schumacher-misc, screen-cyrillic, sony-misc, sun-misc and
#   winitzki-cyrillic
#
# Within the font module, the util component must be built before the
# following fonts:
#   adobe-100dpi, adobe-75dpi, adobe-utopia-100dpi, adobe-utopia-75dpi,
#   bh-100dpi, bh-75dpi, bh-lucidatypewriter-100dpi, bh-lucidatypewriter-75dpi,
#   misc-misc and schumacher-misc
#
# The alias component is recommended to be installed after the other fonts
# since the fonts.alias files reference specific fonts installed from the
# other font components
build_font() {
    build font util
    build font adobe-100dpi
    build font adobe-75dpi
    build font adobe-utopia-100dpi
    build font adobe-utopia-75dpi
    build font adobe-utopia-type1
    build font arabic-misc
    build font bh-100dpi
    build font bh-75dpi
    build font bh-lucidatypewriter-100dpi
    build font bh-lucidatypewriter-75dpi
    build font bh-ttf
    build font bh-type1
    build font bitstream-100dpi
    build font bitstream-75dpi
    build font bitstream-type1
    build font cronyx-cyrillic
    build font cursor-misc
    build font daewoo-misc
    build font dec-misc
    build font ibm-type1
    build font isas-misc
    build font jis-misc
    build font micro-misc
    build font misc-cyrillic
    build font misc-misc
    build font mutt-misc
    build font schumacher-misc
    build font screen-cyrillic
    build font sony-misc
    build font sun-misc
    build font winitzki-cyrillic
    build font xfree86-type1
    build font alias
}

# TODO
build_doc() {
    build
}

PREFIX=$1
SUDO=$2

if test "x${PREFIX}" = "x" ; then
    echo "Usage: $0 prefix [sudo command]"
    exit
fi

# Must create local aclocal dir or aclocal fails
ACLOCAL_LOCALDIR="${PREFIX}/share/aclocal"
$SUDO mkdir -p ${ACLOCAL_LOCALDIR}

# The following is required to make aclocal find our .m4 macros
if [ x"$ACLOCAL" = x ] ; then
    ACLOCAL="aclocal -I ${ACLOCAL_LOCALDIR}"
else
    ACLOCAL="${ACLOCAL} -I ${ACLOCAL_LOCALDIR}"
fi
export ACLOCAL

# The following is required to make pkg-config find our .pc metadata files
if [ x"$PKG_CONFIG_PATH" = x ] ; then
    PKG_CONFIG_PATH=${PREFIX}/lib/pkgconfig
else
    PKG_CONFIG_PATH=${PREFIX}/lib/pkgconfig:${PKG_CONFIG_PATH}
fi
export PKG_CONFIG_PATH

# Set the library path so that locally built libs will be found by apps
if [ x"$LD_LIBRARY_PATH" = x ] ; then
    LD_LIBRARY_PATH=${PREFIX}/lib
else
    LD_LIBRARY_PATH=${PREFIX}/lib:${LD_LIBRARY_PATH}
fi
export LD_LIBRARY_PATH

# Set the path so that locally built apps will be found and used
if [ x"$PATH" = x ] ; then
    PATH=${PREFIX}/bin
else
    PATH=${PREFIX}/bin:${PATH}
fi
export PATH

# Set the default font path for xserver/xorg unless it's already set
if [ x"$FONTPATH" = x ] ; then
    FONTPATH="${PREFIX}/lib/X11/fonts/misc/,${PREFIX}/lib/X11/fonts/Type1/,${PREFIX}/lib/X11/fonts/75dpi/,${PREFIX}/lib/X11/fonts/100dpi/,${PREFIX}/lib/X11/fonts/cyrillic/,${PREFIX}/lib/X11/fonts/TTF/"
    export FONTPATH
fi

# Create the log file directory
$SUDO mkdir -p ${PREFIX}/var/log

date

# We must install the global macros before anything else
build util macros

build_proto
build_lib
build data bitmaps
build_app
build_xserver
build_driver
build_data
build_font
# build_doc

date
