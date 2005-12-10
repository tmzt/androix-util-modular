#!/bin/sh

# global environment variables you may set:
# CACHE: absolute path to a global autoconf cache
# QUIET: hush the configure script noise
# CONFFLAGS: flags to pass to all configure scripts

failed() {
    if test x"$NOQUIT" = x1; then
	echo "***** $1 failed on $2/$3"
    else
	exit 1
    fi
}

build() {
    test "$USEMODULEDIRS" = "yes" && cd $1

    TARBALL=`ls -1rt $2-*.tar.$COMPRESSION 2> /dev/null | tail -1`

    if test x"$TARBALL" = x; then
	echo "WARNING: $2 does not exist -- skipping"
	test "$USEMODULEDIRS" = "yes" && cd ..
	return
    fi
    TARDIR=`echo $TARBALL | sed "s,.tar.$COMPRESSION,,"`

    echo "Building $1 module component $TARDIR..."

    case $COMPRESSION in
	bz2)
	    tar xjf $TARBALL
	    break;;
	gz)
	    tar xvf $TARBALL
	    break;;
    esac

    cd $TARDIR

    if test "$1" = "xserver" && test "$2" = "xorg-server" && test -n "$MESAPATH"; then
	MESA=-"-with-mesa-source=${MESAPATH}"
    else
	MESA=
    fi

    sh configure --prefix=${PREFIX} ${MESA} ${QUIET:+--quiet} \
        ${CACHE:+--cache-file=}${CACHE} ${CONFFLAGS} || failed configure $1 $2
    make || failed make $1 $2
    if test x"$CLEAN" = x1; then
	make clean || failed clean $1 $2
    fi
    if test x"$DIST" = x1; then
	make dist || failed dist $1 $2
    fi
    if test x"$DISTCHECK" = x1; then
	make distcheck || failed distcheck $1 $2
    fi
    $SUDO env LD_LIBRARY_PATH=$LD_LIBRARY_PATH make install || \
	failed install $1 $2

    cd ..
    test "$USEMODULEDIRS" = "yes" && cd ..
}

# protocol headers have no build order dependencies
build_proto() {
    build proto applewmproto
    build proto bigreqsproto
    build proto compositeproto
    build proto damageproto
    build proto dmxproto
    build proto evieext
    build proto fixesproto
    build proto fontcacheproto
    build proto fontsproto
    build proto glproto
    build proto inputproto
    build proto kbproto
    build proto printproto
    build proto randrproto
    build proto recordproto
    build proto renderproto
    build proto resourceproto
    build proto scrnsaverproto
    build proto trapproto
    build proto videoproto
    build proto windowswmproto
    build proto xcmiscproto
    build proto xextproto
    build proto xf86bigfontproto
    build proto xf86dgaproto
    build proto xf86driproto
    build proto xf86miscproto
    build proto xf86rushproto
    build proto xf86vidmodeproto
    build proto xineramaproto
    build proto xproto
    build proto xproxymanagementprotocol
}

# bitmaps is needed for building apps, so has to be done separately first
# cursors depends on apps/xcursorgen
# xkbdata depends on apps/xkbcomp
build_data() {
#    build data xbitmaps
    build data xcursor-themes
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
    build lib libXau
    build lib libXdmcp
    build lib libX11
    build lib libXext
    build lib libAppleWM
    build lib libWindowsWM
    build lib libdmx
    build lib libfontenc
    build lib libFS
    build lib libICE
    build lib liblbxutil
    build lib liboldX
    build lib libSM
    build lib libXt
    build lib libXmu
    build lib libXpm
    build lib libXp
    build lib libXaw
    build lib libXfixes
    build lib libXcomposite
    build lib libXrender
    build lib libXdamage
    build lib libXcursor
    build lib libXevie
    build lib libXfont
    build lib libXfontcache
    build lib libXft
    build lib libXi
    build lib libXinerama
    build lib libxkbfile
    build lib libxkbui
    build lib libXprintUtil
    build lib libXprintAppUtil
    build lib libXrandr
    build lib libXres
    build lib libXScrnSaver
    build lib libXTrap
    build lib libXtst
    build lib libXv
    build lib libXvMC
    build lib libXxf86dga
    build lib libXxf86misc
    build lib libXxf86vm
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
    build app mkcfm
    build app mkfontdir
    build app mkfontscale
    build app oclock
    build app pclcomp
    build app proxymngr
    build app rgb
    build app rstart
    build app scripts
    build app sessreg
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
    build app xdriinfo
    build app xedit
    build app xev
    build app xeyes
    build app xf86dga
    build app xfd
    build app xfindproxy
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
    build app xrx
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
    build xserver xorg-server
}

build_driver_input() {

    HOST_OS=`uname -s`

    # Some drivers are only buildable on some OS'es
    case $HOST_OS in
	Linux)
	    build driver xf86-input-aiptek
	    build driver xf86-input-evdev
	    build driver xf86-input-ur98
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
	    build driver xf86-video-v4l
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
    build driver xf86-video-glide
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
    build font font-util
    build font encodings
    build font font-adobe-100dpi
    build font font-adobe-75dpi
    build font font-adobe-utopia-100dpi
    build font font-adobe-utopia-75dpi
    build font font-adobe-utopia-type1
    build font font-arabic-misc
    build font font-bh-100dpi
    build font font-bh-75dpi
    build font font-bh-lucidatypewriter-100dpi
    build font font-bh-lucidatypewriter-75dpi
    build font font-bh-ttf
    build font font-bh-type1
    build font font-bitstream-100dpi
    build font font-bitstream-75dpi
    build font font-bitstream-speedo
    build font font-bitstream-type1
    build font font-cronyx-cyrillic
    build font font-cursor-misc
    build font font-daewoo-misc
    build font font-dec-misc
    build font font-ibm-type1
    build font font-isas-misc
    build font font-jis-misc
    build font font-micro-misc
    build font font-misc-cyrillic
    build font font-misc-ethiopic
    build font font-misc-meltho
    build font font-misc-misc
    build font font-mutt-misc
    build font font-schumacher-misc
    build font font-screen-cyrillic
    build font font-sony-misc
    build font font-sun-misc
    build font font-winitzki-cyrillic
    build font font-xfree86-type1
    build font font-alias
}

# makedepend requires xproto
build_util() {
    build util xorg-cf-files
    build util imake
    build util makedepend
    build util xmkmf
    build util gccmakedep
    build util lndir
}

# xorg-docs requires xorg-sgml-doctools
build_doc() {
    build doc xorg-sgml-doctools
    build doc xorg-docs
}

usage() {
    echo "Usage: $0 [options] prefix"
    echo "  where options are:"
    echo "  -d : run make distcheck in addition to others"
    echo "  -D : run make dist in addition to others"
    echo "  -c : run make clean in addition to others"
    echo "  -m path-to-mesa-sources-for-xserver : full path to Mesa sources"
    echo "  -n : do not quit after error; just print error message"
    echo "  -s sudo-command : sudo command to use"
    echo "  -bz2 : use tarballs with bzip2 compression (default)"
    echo "  -gz : use tarballs with gzip compression"
    echo "  -e : build from witin the 'everything' dir instead of module dirs"
}

# Initialize defaults
COMPRESSION=bz2
USEMODULEDIRS=yes

# Process command line args
while test $# != 0
do
    case $1 in
    -s)
	shift
	SUDO=$1
	;;
    -m)
	shift
	MESAPATH=$1
	;;
    -n)
	NOQUIT=1
	;;
    -d)
	DISTCHECK=1
	;;
    -D)
	DIST=1
	;;
    -c)
	CLEAN=1
	;;
    -bz2)
	COMPRESSION=bz2
	;;
    -gz)
	COMPRESSION=gz
	;;
    -e)
	USEMODULEDIRS=no
	;;
    *)
	PREFIX=$1
	;;
    esac

    shift
done

if test x"${PREFIX}" = x ; then
    usage
    exit
fi

# Must create local aclocal dir or aclocal fails
ACLOCAL_LOCALDIR="${DESTDIR}${PREFIX}/share/aclocal"
$SUDO mkdir -p ${ACLOCAL_LOCALDIR}

# The following is required to make aclocal find our .m4 macros
if test x"$ACLOCAL" = x; then
    ACLOCAL="aclocal -I ${ACLOCAL_LOCALDIR}"
else
    ACLOCAL="${ACLOCAL} -I ${ACLOCAL_LOCALDIR}"
fi
export ACLOCAL

# The following is required to make pkg-config find our .pc metadata files
if test x"$PKG_CONFIG_PATH" = x; then
    PKG_CONFIG_PATH=${DESTDIR}${PREFIX}/lib/pkgconfig
else
    PKG_CONFIG_PATH=${DESTDIR}${PREFIX}/lib/pkgconfig:${PKG_CONFIG_PATH}
fi
export PKG_CONFIG_PATH

# Set the library path so that locally built libs will be found by apps
if test x"$LD_LIBRARY_PATH" = x; then
    LD_LIBRARY_PATH=${DESTDIR}${PREFIX}/lib
else
    LD_LIBRARY_PATH=${DESTDIR}${PREFIX}/lib:${LD_LIBRARY_PATH}
fi
export LD_LIBRARY_PATH

# Set the path so that locally built apps will be found and used
if test x"$PATH" = x; then
    PATH=${DESTDIR}${PREFIX}/bin
else
    PATH=${DESTDIR}${PREFIX}/bin:${PATH}
fi
export PATH

# Set the default font path for xserver/xorg unless it's already set
if test x"$FONTPATH" = x; then
    FONTPATH="${PREFIX}/lib/X11/fonts/misc/,${PREFIX}/lib/X11/fonts/Type1/,${PREFIX}/lib/X11/fonts/75dpi/,${PREFIX}/lib/X11/fonts/100dpi/,${PREFIX}/lib/X11/fonts/cyrillic/,${PREFIX}/lib/X11/fonts/TTF/"
    export FONTPATH
fi

# Create the log file directory
$SUDO mkdir -p ${DESTDIR}${PREFIX}/var/log

date

# We must install the global macros before anything else
build util util-macros

build_doc
build_proto
build_lib
build data xbitmaps
build_app
build_xserver
build_driver
build_data
build_font
build_util

date
