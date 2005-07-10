#!/bin/sh

# global environment variables you may set:
# CACHE: absolute path to a global autoconf cache
# QUIET: hush the configure script noise

build() {
    echo "Building $1 module component $2..."
    cd $1/$2

    # Use "sh autogen.sh" since some scripts are not executable in CVS
    sh autogen.sh --prefix=${PREFIX} ${QUIET:+--quiet} \
        ${CACHE:+--cache-file=}${CACHE}
#    make
    make install
#    make clean
#    make dist
#    make distcheck

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
    build proto Panoramix
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
#    build lib Xcomposite
    build lib Xrender
    build lib Xfixes
    build lib Xdamage
    build lib Xcursor
    build lib Xevie
    build lib Xfont
    build lib Xfontcache
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
    build app bdftopcf
    build app mkfontscale
    build app mkfontdir
}

# The server requires at least the following libraries:
# Xfont, Xau, Xdmcp
build_xserver() {
    build
}

# The server must be built before the drivers
build_driver() {
    build
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
}

# TODO
build_doc() {
    build
}

PREFIX=$1

if test "x${PREFIX}" = "x" ; then
    echo "Usage: $0 prefix"
    exit
fi

# Must create local aclocal dir or aclocal fails
ACLOCAL_LOCALDIR="${PREFIX}/share/aclocal"
mkdir -p ${ACLOCAL_LOCALDIR}

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

date

build_proto
build_lib
build_app
# build_xserver
# build_driver
build_font
# build_doc

date
