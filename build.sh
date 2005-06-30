#!/bin/sh

build() {
    echo "Building $1 module component $2..."
    cd $1/$2

    # Use "sh autogen.sh" since some scripts are not executable in CVS
    sh autogen.sh --prefix=${PREFIX}
#    make
    make install
#    make clean
#    make dist
#    make distcheck

    cd ../..
}

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
    build proto XF86Misc
    build proto XF86Rush
    build proto XF86VidMode
}

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
    build lib XprintAppUtil
    build lib XprintUtil
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

build_app() {
    build
}

build_xserver() {
    build
}

build_driver() {
    build
}

build_font() {
    build font util
    build font adobe-100dpi
    build font adobe-75dpi
    build font adobe-utopia-100dpi
    build font adobe-utopia-75dpi
    build font adobe-utopia-type1
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
    build font schumacher-misc
    build font screen-cyrillic
    build font sony-misc
    build font sun-misc
    build font winitzki-cyrillic
    build font xfree86-type1
}

build_doc() {
    build
}

PREFIX=$1

if test "x${PREFIX}" == "x" ; then
    echo "Usage: $0 prefix"
    exit
fi

# Must create local aclocal dir or aclocal fails
ACLOCAL_LOCALDIR="${PREFIX}/share/aclocal"
mkdir -p ${ACLOCAL_LOCALDIR}

export PKG_CONFIG_PATH=${PREFIX}/lib/pkgconfig
export ACLOCAL="aclocal -I ${ACLOCAL_LOCALDIR}"

date

build_proto
build_lib
# build_app
# build_xserver
# build_driver
build_font
# build_doc

date
