#!/bin/bash

#
# A script that symlinks source files from monolithic to modular
#
# Author: Soren Sandmann (sandmann@redhat.com)
# 

#
# Things we would like to do
#
#	- Check that all the relevant files exist
#		- AUTHORS, autogen.sh, configure.ac, ...
#	- Check that we have actually linked everything
#		- if a file doesn't need to be linked, then it needs
#		  to be listed as "not-linked"
#	- Compute diffs between all the files (shouldn't be necessary)
#	- possibly check that files are listen in Makefile.am's
#	- Clean target directory of irrelevant files
#

function check_exist() {
    # Check whether $1 exists

    if [ ! -e $1 ] ; then
	error "$1 not found"
    fi
}

function delete_existing() {
    # Delete $2

    rm -f $2
}

function link_files() {
    # Link $1 to $2

    if [ ! -e $2 ] ; then
	ln -s $1 $2
    fi
}

function main() {
    check_args $1 $2

    run check_exist "Checking that the source files exist"
    run delete_existing "Deleting existing files"
    run link_files "Linking files"
}


#########
#
#	The proto module
#
#########

# Core protocol

function symlink_proto_core() {
    src_dir include
    dst_dir proto/X11

    action	ap_keysym.h	# not used anywhere
    action	DECkeysym.h
    action	HPkeysym.h	# not used anywhere
    action	keysymdef.h
    action	keysym.h
    action	Sunkeysym.h
    action	Xalloca.h
    action	Xarch.h
    action	Xatom.h
    action	Xdefs.h
    action	XF86keysym.h	# only used in server
    action	Xfuncproto.h
    action	Xfuncs.h
    action	X.h
    action	Xmd.h
    action	Xosdefs.h
    action	Xos.h
    action	Xos_r.h
    action	Xpoll.h
    action	Xproto.h
    action	Xprotostr.h
    action	Xthreads.h	# not used in server
    action	Xw32defs.h
    action	XWDFile.h
    action	Xwindows.h
    action	Xwinsock.h
}

# Extension protocols

function symlink_proto_bigreq() {
    src_dir include/extensions
    dst_dir proto/BigReqs

    action	bigreqstr.h
}

function symlink_proto_composite() {
    src_dir include/extensions
    dst_dir proto/Composite

    action	composite.h
    action	compositeproto.h
}

function symlink_proto_damage() {
    src_dir include/extensions
    dst_dir proto/Damage

    action	damageproto.h
    action	damagewire.h
}

function symlink_proto_dmx() {
    src_dir include/extensions
    dst_dir proto/DMX

    action	dmxext.h
    action	dmxproto.h
}

function symlink_proto_evie() {
    src_dir include/extensions
    dst_dir proto/EvIE

    action	Xevie.h
    action	Xeviestr.h
}

function symlink_proto_fixes() {
    src_dir include/extensions
    dst_dir proto/Fixes

    action	xfixesproto.h
    action	xfixeswire.h
}

function symlink_proto_fontcache() {
    src_dir include/extensions
    dst_dir proto/Fontcache

    action	fontcache.h
    action	fontcacheP.h
    action	fontcachstr.h
}

function symlink_proto_input() {
    src_dir include/extensions
    dst_dir proto/Input

    action	XI.h
    action	XInput.h
    action	XIproto.h
}

function symlink_proto_kb() {
    src_dir include/extensions
    dst_dir proto/KB

    action	XKBgeom.h
    action	XKB.h
    action	XKBproto.h
    action	XKBsrv.h
    action	XKBstr.h
}

function symlink_proto_panoramix() {
    src_dir include/extensions
    dst_dir proto/Panoramix

    action	panoramiXext.h
    action	panoramiXproto.h
    action	Xinerama.h	# not used in server
}

function symlink_proto_print() {
    src_dir include/extensions
    dst_dir proto/Print

    action	Print.h
    action	Printstr.h
}

function symlink_proto_randr() {
    src_dir include/extensions
    dst_dir proto/Randr

    action	randr.h
    action	randrproto.h
}

function symlink_proto_record() {
    src_dir include/extensions
    dst_dir proto/Record

    action	record.h
    action	recordstr.h
}

function symlink_proto_render() {
    src_dir include/extensions
    dst_dir proto/Render

    action	render.h
    action	renderproto.h
}

function symlink_proto_resource() {
    src_dir include/extensions
    dst_dir proto/Resource

    action	XRes.h		# only used by DMX example program in server
    action	XResproto.h
}

function symlink_proto_saver() {
    src_dir include/extensions
    dst_dir proto/SS

    action	saver.h
    action	saverproto.h
    action	scrnsaver.h	# not used in server
}

function symlink_proto_trap() {
    src_dir include/extensions
    dst_dir proto/Trap

    action	xtrapbits.h
    action	xtrapddmi.h	# only used in server
    action	xtrapdi.h
    action	xtrapemacros.h	# not used in server
    action	xtraplib.h	# not used in server
    action	xtraplibp.h	# not used in server
    action	xtrapproto.h	# only used in server
}

function symlink_proto_video() {
    src_dir include/extensions
    dst_dir proto/Video

    action	vldXvMC.h	# not used in server
    action	Xv.h
    action	Xvlib.h		# not used in server
    action	XvMC.h
    action	XvMClib.h	# not used in server
    action	XvMCproto.h
    action	Xvproto.h
}

function symlink_proto_xcmisc() {
    src_dir include/extensions
    dst_dir proto/XCMisc

    action	xcmiscstr.h
}

# should these be exploded into individual extension components?
function symlink_proto_xext() {
    src_dir include/extensions
    dst_dir proto/XExt

    action	dpms.h
    action	dpmsstr.h
    action	extutil.h
    action	lbxbuf.h	# not used in server
    action	lbxbufstr.h	# not used in server
    action	lbxdeltastr.h
    action	lbximage.h
    action	lbxopts.h
    action	lbxstr.h
    action	lbxzlib.h
    action	MITMisc.h
    action	mitmiscstr.h
    action	multibuf.h
    action	multibufst.h
    action	security.h
    action	securstr.h
    action	shape.h
    action	shapestr.h
    action	shmstr.h
    action	sync.h
    action	syncstr.h
    action	Xag.h
    action	Xagsrv.h	# only used in server
    action	Xagstr.h
    action	Xcup.h
    action	Xcupstr.h
    action	Xdbe.h		# not used in server
    action	Xdbeproto.h
    action	XEVI.h
    action	XEVIstr.h
    action	Xext.h
    action	XLbx.h
    action	XShm.h
    action	xtestext1.h
    action	XTest.h
    action	xteststr.h
}

function symlink_proto_xf86bigfont() {
    src_dir include/extensions
    dst_dir proto/XF86BigFont

    action	xf86bigfont.h
    action	xf86bigfstr.h
}

function symlink_proto_xf86dga() {
    src_dir include/extensions
    dst_dir proto/XF86DGA

    action	xf86dga1.h
    action	xf86dga1str.h
    action	xf86dga.h
    action	xf86dgastr.h
}

function symlink_proto_xf86misc() {
    src_dir include/extensions
    dst_dir proto/XF86Misc

    action	xf86misc.h
    action	xf86mscstr.h
}

function symlink_proto_xf86rush() {
    src_dir include/extensions
    dst_dir proto/XF86Rush

    action	xf86rush.h
    action	xf86rushstr.h
}

function symlink_proto_xf86vidmode() {
    src_dir include/extensions
    dst_dir proto/XF86VidMode

    action	xf86vmode.h
    action	xf86vmstr.h
}

function symlink_proto_fonts() {
    src_dir include/fonts
    dst_dir proto/Fonts

    action	font.h
    action	fontproto.h
    action	fontstruct.h
    action	FS.h		# not used in server
    action	fsmasks.h
    action	FSproto.h	# not used in server
}

function symlink_proto_gl() {
    src_dir include/GL
    dst_dir proto/GL

    action	glu.h		# not used in server
    action	glx.h
    action	glxint.h
    action	glxmd.h
    action	glxproto.h
    action	glxtokens.h
}

function symlink_proto() {
    # Core protocol
    symlink_proto_core

    # Extension protocols
    symlink_proto_bigreq
    symlink_proto_composite
    symlink_proto_damage
    symlink_proto_dmx
    symlink_proto_evie
    symlink_proto_fixes
    symlink_proto_fontcache
    symlink_proto_input
    symlink_proto_kb
    symlink_proto_panoramix
    symlink_proto_print
    symlink_proto_randr
    symlink_proto_record
    symlink_proto_render
    symlink_proto_resource
    symlink_proto_saver
    symlink_proto_trap
    symlink_proto_video
    symlink_proto_xcmisc
    symlink_proto_xext
    symlink_proto_xf86bigfont
    symlink_proto_xf86dga
    symlink_proto_xf86misc
    symlink_proto_xf86rush
    symlink_proto_xf86vidmode

    # Font protocols
    symlink_proto_fonts

    # GL protocols
    symlink_proto_gl
}

#########
#
#	The lib module
#
#########

function symlink_lib_dmx() {
    src_dir lib/dmx
    dst_dir lib/dmx/src

    action	dmx.c

    src_dir doc/man/DMX
    dst_dir lib/dmx/man

    action	DMXAddInput.man
    action	DMXAddScreen.man
    action	DMXChangeDesktopAttributes.man
    action	DMXChangeScreensAttributes.man
    action	DMXForceWindowCreation.man
    action	DMXGetDesktopAttributes.man
    action	DMXGetInputAttributes.man
    action	DMXGetInputCount.man
    action	DMXGetScreenAttributes.man
    action	DMXGetScreenCount.man
    action	DMXGetWindowAttributes.man
    action	DMX.man
    action	DMXQueryExtension.man
    action	DMXQueryVersion.man
    action	DMXRemoveInput.man
    action	DMXRemoveScreen.man
    action	DMXSync.man
}

function symlink_lib_composite() {
    src_dir lib/Xcomposite
    dst_dir lib/Xcomposite

    action	AUTHORS
    action	autogen.sh
    action	ChangeLog
    action	COPYING
    action	INSTALL
    action	NEWS
    action	README
    action	xcomposite.pc.in

    dst_dir lib/Xcomposite/include

    action	Xcomposite.h
    action	xcompositeint.h

    dst_dir lib/Xcomposite/src

    action	Xcomposite.c
}

function symlink_lib() {
    symlink_lib_dmx
    symlink_lib_composite
#    symlink_lib_damage
#    symlink_lib_fixes
#    symlink_lib_ice
#    symlink_lib_randr
#    symlink_lib_record
#    symlink_lib_render
#    symlink_lib_resource
#    symlink_lib_sm
#    symlink_lib_x11
#    symlink_lib_xau
#    symlink_lib_xaw
#    ...
}


#########
#
#	The app module
#
#########

function symlink_app_twm() {
    src_dir programs/twm
    dst_dir app/twm/src

    action	add_window.c
    action	add_window.h
    action	cursor.c
    action	deftwmrc.sed
    action	events.c
    action	events.h
    action	gc.c
    action	gc.h
    action	gram.y
    action	iconmgr.c
    action	iconmgr.h
    action	icons.c
    action	icons.h
    action	lex.l
    action	list.c
    action	list.h
    action	menus.c
    action	menus.h
    action	parse.c
    action	parse.h
    action	resize.c
    action	resize.h
    action	screen.h
    action	session.c
    action	session.h
    action	siconify.bm
    action	system.twmrc
    action	twm.c
    action	twm.h
    action	util.c
    action	util.h
    action	version.c
    action	version.h

    dst_dir app/twm/man

    action	twm.man

    src_dir programs/twm/sample-twmrc
    dst_dir app/twm/sample-twmrc

    action	jim.twmrc
    action	keith.twmrc
    action	lemke.twmrc
}

function symlink_app_xdpyinfo() {
    src_dir programs/xdpyinfo
    dst_dir app/xdpyinfo

    action	xdpyinfo.c
    action	xdpyinfo.man
}

function symlink_app() {
    symlink_app_twm
    symlink_app_xdpyinfo
#    ...
}


#########
#
#	The xserver module
#
#########

function symlink_xserver_dix() {
    src_dir programs/Xserver/dix
    dst_dir xserver/xorg/dix

    action	atom.c
    action	colormap.c
    action	cursor.c
    action	devices.c
    action	dispatch.c
    action	dispatch.h
    action	dixfonts.c
    action	dixutils.c
    action	events.c
    action	extension.c
    action	ffs.c
    action	gc.c
    action	globals.c
    action	glyphcurs.c
    action	grabs.c
    action	initatoms.c
    action	main.c
    action	pixmap.c
    action	privates.c
    action	property.c
    action	resource.c
    action	swaprep.c
    action	swapreq.c
    action	tables.c
    action	window.c
    action	xpstubs.c

    action	buildatoms
    action	BuiltInAtoms
    action	CHANGES
}

function symlink_xserver_include() {
    src_dir programs/Xserver/include
    dst_dir xserver/xorg/include

    action	bstore.h
    action	bstorestr.h
    action	closestr.h
    action	closure.h
    action	colormap.h
    action	colormapst.h
    action	cursor.h
    action	cursorstr.h
    action	dixevents.h
    action	dixfont.h
    action	dixfontstr.h
    action	dixgrabs.h
    action	dix.h
    action	dixstruct.h
    action	exevents.h
    action	extension.h
    action	extinit.h
    action	extnsionst.h
    action	gc.h
    action	gcstruct.h
    action	globals.h
    action	input.h
    action	inputstr.h
    action	misc.h
    action	miscstruct.h
    action	opaque.h
    action	os.h
    action	pixmap.h
    action	pixmapstr.h
    action	property.h
    action	propertyst.h
    action	region.h
    action	regionstr.h
    action	resource.h
    action	rgb.h
    action	screenint.h
    action	scrnintstr.h
    action	selection.h
    action	servermd.h
    action	site.h
    action	swaprep.h
    action	swapreq.h
    action	validate.h
    action	window.h
    action	windowstr.h
    action	XIstubs.h
}

function symlink_xserver() {
    symlink_xserver_dix
    symlink_xserver_include
#    ...
}


#########
#
#	The driver module
#
#########

function symlink_driver_ati() {
    src_dir programs/Xserver/hw/xfree86/drivers/ati
    dst_dir driver/xaa-ati/src

    action	atiaccel.c
    action	atiaccel.h
    action	atiadapter.c
    action	atiadapter.h
    action	atiadjust.c
    action	atiadjust.h
    action	atiaudio.c
    action	atiaudio.h
    action	atibank.c
    action	atibank.h
    action	atibus.c
    action	atibus.h
    action	ati.c
    action	atichip.c
    action	atichip.h
    action	aticlock.c
    action	aticlock.h
    action	aticonfig.c
    action	aticonfig.h
    action	aticonsole.c
    action	aticonsole.h
    action	aticrtc.h
    action	aticursor.c
    action	aticursor.h
    action	atidac.c
    action	atidac.h
    action	atidecoder.c
    action	atidecoder.h
    action	atidga.c
    action	atidga.h
    action	atidri.c
    action	atidri.h
    action	atidripriv.h
    action	atidsp.c
    action	atidsp.h
    action	atifillin.c
    action	atifillin.h
    action	ati.h
    action	atii2c.c
    action	atii2c.h
    action	atiident.c
    action	atiident.h
    action	atiio.h
    action	atiload.c
    action	atiload.h
    action	atilock.c
    action	atilock.h
    action	atimach64accel.c
    action	atimach64accel.h
    action	atimach64.c
    action	atimach64cursor.c
    action	atimach64cursor.h
    action	atimach64.h
    action	atimach64i2c.c
    action	atimach64i2c.h
    action	atimach64io.c
    action	atimach64io.h
    action	atimach64xv.c
    action	atimach64xv.h
    action	atimisc.c
    action	atimode.c
    action	atimode.h
    action	atimodule.c
    action	atimodule.h
    action	atimono.h
    action	atioption.c
    action	atioption.h
    action	atipreinit.c
    action	atipreinit.h
    action	atiprint.c
    action	atiprint.h
    action	atipriv.h
    action	atiprobe.c
    action	atiprobe.h
    action	atiregs.h
    action	atirgb514.c
    action	atirgb514.h
    action	atiscreen.c
    action	atiscreen.h
    action	atistruct.h
    action	atituner.c
    action	atituner.h
    action	atiutil.c
    action	atiutil.h
    action	ativalid.c
    action	ativalid.h
    action	ativersion.h
    action	ativga.c
    action	ativga.h
    action	ativgaio.c
    action	ativgaio.h
    action	atividmem.c
    action	atividmem.h
    action	atiwonder.c
    action	atiwonder.h
    action	atiwonderio.c
    action	atiwonderio.h
    action	atixv.c
    action	atixv.h
    action	generic_bus.h
    action	mach64_common.h
    action	mach64_dri.h
    action	mach64_sarea.h
    action	r128_accel.c
    action	r128_chipset.h
    action	r128_common.h
    action	r128_cursor.c
    action	r128_dga.c
    action	r128_dri.c
    action	r128_dri.h
    action	r128_dripriv.h
    action	r128_driver.c
    action	r128.h
    action	r128_misc.c
    action	r128_probe.c
    action	r128_probe.h
    action	r128_reg.h
    action	r128_sarea.h
    action	r128_version.h
    action	r128_video.c
    action	radeon_accel.c
    action	radeon_accelfuncs.c
    action	radeon_bios.c
    action	radeon_chipset.h
    action	radeon_common.h
    action	radeon_cursor.c
    action	radeon_dga.c
    action	radeon_dri.c
    action	radeon_dri.h
    action	radeon_dripriv.h
    action	radeon_driver.c
    action	radeon.h
    action	radeon_macros.h
    action	radeon_mergedfb.c
    action	radeon_mergedfb.h
    action	radeon_misc.c
    action	radeon_mm_i2c.c
    action	radeon_probe.c
    action	radeon_probe.h
    action	radeon_reg.h
    action	radeon_render.c
    action	radeon_sarea.h
    action	radeon_version.h
    action	radeon_video.c
    action	radeon_video.h
    action	radeon_vip.c
    action	theatre200.c
    action	theatre200.h
    action	theatre200_module.c
    action	theatre.c
    action	theatre_detect.c
    action	theatre_detect.h
    action	theatre_detect_module.c
    action	theatre.h
    action	theatre_module.c
    action	theatre_reg.h

    dst_dir driver/xaa-ati/man

    action	ati.man
    action	r128.man
    action	radeon.man
}

function symlink_driver_mouse() {
    src_dir programs/Xserver/hw/xfree86/input/mouse
    dst_dir driver/xf86input-mouse/src

    action	mouse.c
    action	mouse.h
    action	mousePriv.h
    action	pnp.c

    dst_dir driver/xf86input-mouse/man

    action	mouse.man
}

function symlink_driver() {
    symlink_driver_ati
    symlink_driver_mouse
#    symlink_driver_damage
#    symlink_driver_fixes
#    symlink_driver_ice
#    symlink_driver_randr
#    symlink_driver_record
#    symlink_driver_render
#    symlink_driver_resource
#    symlink_driver_sm
#    symlink_driver_x11
#    symlink_driver_xau
#    symlink_driver_xaw
#    ...
}


#########
#
#	The font module
#
#########

function symlink_font_100dpi() {
    src_dir fonts/bdf/100dpi
    dst_dir font/100dpi

    action	charB08.bdf
    action	charB10.bdf
    action	charB12.bdf
    action	charB14.bdf
    action	charB18.bdf
    action	charB24.bdf
    action	charBI08.bdf
    action	charBI10.bdf
    action	charBI12.bdf
    action	charBI14.bdf
    action	charBI18.bdf
    action	charBI24.bdf
    action	charI08.bdf
    action	charI10.bdf
    action	charI12.bdf
    action	charI14.bdf
    action	charI18.bdf
    action	charI24.bdf
    action	charR08.bdf
    action	charR10.bdf
    action	charR12.bdf
    action	charR14.bdf
    action	charR18.bdf
    action	charR24.bdf
    action	courB08.bdf
    action	courB08-L1.bdf
    action	courB10.bdf
    action	courB10-L1.bdf
    action	courB12.bdf
    action	courB12-L1.bdf
    action	courB14.bdf
    action	courB14-L1.bdf
    action	courB18.bdf
    action	courB18-L1.bdf
    action	courB24.bdf
    action	courB24-L1.bdf
    action	courBO08.bdf
    action	courBO08-L1.bdf
    action	courBO10.bdf
    action	courBO10-L1.bdf
    action	courBO12.bdf
    action	courBO12-L1.bdf
    action	courBO14.bdf
    action	courBO14-L1.bdf
    action	courBO18.bdf
    action	courBO18-L1.bdf
    action	courBO24.bdf
    action	courBO24-L1.bdf
    action	courO08.bdf
    action	courO08-L1.bdf
    action	courO10.bdf
    action	courO10-L1.bdf
    action	courO12.bdf
    action	courO12-L1.bdf
    action	courO14.bdf
    action	courO14-L1.bdf
    action	courO18.bdf
    action	courO18-L1.bdf
    action	courO24.bdf
    action	courO24-L1.bdf
    action	courR08.bdf
    action	courR08-L1.bdf
    action	courR10.bdf
    action	courR10-L1.bdf
    action	courR12.bdf
    action	courR12-L1.bdf
    action	courR14.bdf
    action	courR14-L1.bdf
    action	courR18.bdf
    action	courR18-L1.bdf
    action	courR24.bdf
    action	courR24-L1.bdf
    action	helvB08.bdf
    action	helvB08-L1.bdf
    action	helvB10.bdf
    action	helvB10-L1.bdf
    action	helvB12.bdf
    action	helvB12-L1.bdf
    action	helvB14.bdf
    action	helvB14-L1.bdf
    action	helvB18.bdf
    action	helvB18-L1.bdf
    action	helvB24.bdf
    action	helvB24-L1.bdf
    action	helvBO08.bdf
    action	helvBO08-L1.bdf
    action	helvBO10.bdf
    action	helvBO10-L1.bdf
    action	helvBO12.bdf
    action	helvBO12-L1.bdf
    action	helvBO14.bdf
    action	helvBO14-L1.bdf
    action	helvBO18.bdf
    action	helvBO18-L1.bdf
    action	helvBO24.bdf
    action	helvBO24-L1.bdf
    action	helvO08.bdf
    action	helvO08-L1.bdf
    action	helvO10.bdf
    action	helvO10-L1.bdf
    action	helvO12.bdf
    action	helvO12-L1.bdf
    action	helvO14.bdf
    action	helvO14-L1.bdf
    action	helvO18.bdf
    action	helvO18-L1.bdf
    action	helvO24.bdf
    action	helvO24-L1.bdf
    action	helvR08.bdf
    action	helvR08-L1.bdf
    action	helvR10.bdf
    action	helvR10-L1.bdf
    action	helvR12.bdf
    action	helvR12-L1.bdf
    action	helvR14.bdf
    action	helvR14-L1.bdf
    action	helvR18.bdf
    action	helvR18-L1.bdf
    action	helvR24.bdf
    action	helvR24-L1.bdf
    action	lubB08.bdf
    action	lubB08-L1.bdf
    action	lubB10.bdf
    action	lubB10-L1.bdf
    action	lubB12.bdf
    action	lubB12-L1.bdf
    action	lubB14.bdf
    action	lubB14-L1.bdf
    action	lubB18.bdf
    action	lubB18-L1.bdf
    action	lubB19.bdf
    action	lubB19-L1.bdf
    action	lubB24.bdf
    action	lubB24-L1.bdf
    action	lubBI08.bdf
    action	lubBI08-L1.bdf
    action	lubBI10.bdf
    action	lubBI10-L1.bdf
    action	lubBI12.bdf
    action	lubBI12-L1.bdf
    action	lubBI14.bdf
    action	lubBI14-L1.bdf
    action	lubBI18.bdf
    action	lubBI18-L1.bdf
    action	lubBI19.bdf
    action	lubBI19-L1.bdf
    action	lubBI24.bdf
    action	lubBI24-L1.bdf
    action	lubI08.bdf
    action	lubI08-L1.bdf
    action	lubI10.bdf
    action	lubI10-L1.bdf
    action	lubI12.bdf
    action	lubI12-L1.bdf
    action	lubI14.bdf
    action	lubI14-L1.bdf
    action	lubI18.bdf
    action	lubI18-L1.bdf
    action	lubI19.bdf
    action	lubI19-L1.bdf
    action	lubI24.bdf
    action	lubI24-L1.bdf
    action	luBIS08.bdf
    action	luBIS08-L1.bdf
    action	luBIS10.bdf
    action	luBIS10-L1.bdf
    action	luBIS12.bdf
    action	luBIS12-L1.bdf
    action	luBIS14.bdf
    action	luBIS14-L1.bdf
    action	luBIS18.bdf
    action	luBIS18-L1.bdf
    action	luBIS19.bdf
    action	luBIS19-L1.bdf
    action	luBIS24.bdf
    action	luBIS24-L1.bdf
    action	lubR08.bdf
    action	lubR08-L1.bdf
    action	lubR10.bdf
    action	lubR10-L1.bdf
    action	lubR12.bdf
    action	lubR12-L1.bdf
    action	lubR14.bdf
    action	lubR14-L1.bdf
    action	lubR18.bdf
    action	lubR18-L1.bdf
    action	lubR19.bdf
    action	lubR19-L1.bdf
    action	lubR24.bdf
    action	lubR24-L1.bdf
    action	luBS08.bdf
    action	luBS08-L1.bdf
    action	luBS10.bdf
    action	luBS10-L1.bdf
    action	luBS12.bdf
    action	luBS12-L1.bdf
    action	luBS14.bdf
    action	luBS14-L1.bdf
    action	luBS18.bdf
    action	luBS18-L1.bdf
    action	luBS19.bdf
    action	luBS19-L1.bdf
    action	luBS24.bdf
    action	luBS24-L1.bdf
    action	luIS08.bdf
    action	luIS08-L1.bdf
    action	luIS10.bdf
    action	luIS10-L1.bdf
    action	luIS12.bdf
    action	luIS12-L1.bdf
    action	luIS14.bdf
    action	luIS14-L1.bdf
    action	luIS18.bdf
    action	luIS18-L1.bdf
    action	luIS19.bdf
    action	luIS19-L1.bdf
    action	luIS24.bdf
    action	luIS24-L1.bdf
    action	luRS08.bdf
    action	luRS08-L1.bdf
    action	luRS10.bdf
    action	luRS10-L1.bdf
    action	luRS12.bdf
    action	luRS12-L1.bdf
    action	luRS14.bdf
    action	luRS14-L1.bdf
    action	luRS18.bdf
    action	luRS18-L1.bdf
    action	luRS19.bdf
    action	luRS19-L1.bdf
    action	luRS24.bdf
    action	luRS24-L1.bdf
    action	lutBS08.bdf
    action	lutBS08-L1.bdf
    action	lutBS10.bdf
    action	lutBS10-L1.bdf
    action	lutBS12.bdf
    action	lutBS12-L1.bdf
    action	lutBS14.bdf
    action	lutBS14-L1.bdf
    action	lutBS18.bdf
    action	lutBS18-L1.bdf
    action	lutBS19.bdf
    action	lutBS19-L1.bdf
    action	lutBS24.bdf
    action	lutBS24-L1.bdf
    action	lutRS08.bdf
    action	lutRS08-L1.bdf
    action	lutRS10.bdf
    action	lutRS10-L1.bdf
    action	lutRS12.bdf
    action	lutRS12-L1.bdf
    action	lutRS14.bdf
    action	lutRS14-L1.bdf
    action	lutRS18.bdf
    action	lutRS18-L1.bdf
    action	lutRS19.bdf
    action	lutRS19-L1.bdf
    action	lutRS24.bdf
    action	lutRS24-L1.bdf
    action	ncenB08.bdf
    action	ncenB08-L1.bdf
    action	ncenB10.bdf
    action	ncenB10-L1.bdf
    action	ncenB12.bdf
    action	ncenB12-L1.bdf
    action	ncenB14.bdf
    action	ncenB14-L1.bdf
    action	ncenB18.bdf
    action	ncenB18-L1.bdf
    action	ncenB24.bdf
    action	ncenB24-L1.bdf
    action	ncenBI08.bdf
    action	ncenBI08-L1.bdf
    action	ncenBI10.bdf
    action	ncenBI10-L1.bdf
    action	ncenBI12.bdf
    action	ncenBI12-L1.bdf
    action	ncenBI14.bdf
    action	ncenBI14-L1.bdf
    action	ncenBI18.bdf
    action	ncenBI18-L1.bdf
    action	ncenBI24.bdf
    action	ncenBI24-L1.bdf
    action	ncenI08.bdf
    action	ncenI08-L1.bdf
    action	ncenI10.bdf
    action	ncenI10-L1.bdf
    action	ncenI12.bdf
    action	ncenI12-L1.bdf
    action	ncenI14.bdf
    action	ncenI14-L1.bdf
    action	ncenI18.bdf
    action	ncenI18-L1.bdf
    action	ncenI24.bdf
    action	ncenI24-L1.bdf
    action	ncenR08.bdf
    action	ncenR08-L1.bdf
    action	ncenR10.bdf
    action	ncenR10-L1.bdf
    action	ncenR12.bdf
    action	ncenR12-L1.bdf
    action	ncenR14.bdf
    action	ncenR14-L1.bdf
    action	ncenR18.bdf
    action	ncenR18-L1.bdf
    action	ncenR24.bdf
    action	ncenR24-L1.bdf
    action	symb08.bdf
    action	symb10.bdf
    action	symb12.bdf
    action	symb14.bdf
    action	symb18.bdf
    action	symb24.bdf
    action	tech14.bdf
    action	techB14.bdf
    action	term14.bdf
    action	termB14.bdf
    action	timB08.bdf
    action	timB08-L1.bdf
    action	timB10.bdf
    action	timB10-L1.bdf
    action	timB12.bdf
    action	timB12-L1.bdf
    action	timB14.bdf
    action	timB14-L1.bdf
    action	timB18.bdf
    action	timB18-L1.bdf
    action	timB24.bdf
    action	timB24-L1.bdf
    action	timBI08.bdf
    action	timBI08-L1.bdf
    action	timBI10.bdf
    action	timBI10-L1.bdf
    action	timBI12.bdf
    action	timBI12-L1.bdf
    action	timBI14.bdf
    action	timBI14-L1.bdf
    action	timBI18.bdf
    action	timBI18-L1.bdf
    action	timBI24.bdf
    action	timBI24-L1.bdf
    action	timI08.bdf
    action	timI08-L1.bdf
    action	timI10.bdf
    action	timI10-L1.bdf
    action	timI12.bdf
    action	timI12-L1.bdf
    action	timI14.bdf
    action	timI14-L1.bdf
    action	timI18.bdf
    action	timI18-L1.bdf
    action	timI24.bdf
    action	timI24-L1.bdf
    action	timR08.bdf
    action	timR08-L1.bdf
    action	timR10.bdf
    action	timR10-L1.bdf
    action	timR12.bdf
    action	timR12-L1.bdf
    action	timR14.bdf
    action	timR14-L1.bdf
    action	timR18.bdf
    action	timR18-L1.bdf
    action	timR24.bdf
    action	timR24-L1.bdf
    action	UTB___10.bdf
    action	UTB___10-L1.bdf
    action	UTB___12.bdf
    action	UTB___12-L1.bdf
    action	UTB___14.bdf
    action	UTB___14-L1.bdf
    action	UTB___18.bdf
    action	UTB___18-L1.bdf
    action	UTB___24.bdf
    action	UTB___24-L1.bdf
    action	UTBI__10.bdf
    action	UTBI__10-L1.bdf
    action	UTBI__12.bdf
    action	UTBI__12-L1.bdf
    action	UTBI__14.bdf
    action	UTBI__14-L1.bdf
    action	UTBI__18.bdf
    action	UTBI__18-L1.bdf
    action	UTBI__24.bdf
    action	UTBI__24-L1.bdf
    action	UTI___10.bdf
    action	UTI___10-L1.bdf
    action	UTI___12.bdf
    action	UTI___12-L1.bdf
    action	UTI___14.bdf
    action	UTI___14-L1.bdf
    action	UTI___18.bdf
    action	UTI___18-L1.bdf
    action	UTI___24.bdf
    action	UTI___24-L1.bdf
    action	UTRG__10.bdf
    action	UTRG__10-L1.bdf
    action	UTRG__12.bdf
    action	UTRG__12-L1.bdf
    action	UTRG__14.bdf
    action	UTRG__14-L1.bdf
    action	UTRG__18.bdf
    action	UTRG__18-L1.bdf
    action	UTRG__24.bdf
    action	UTRG__24-L1.bdf

    action	fonts.alias

    action	LU_LEGALNOTICE
}

function symlink_font() {
    symlink_font_100dpi
#    symlink_font_75dpi
#    symlink_font_cyrillic
#    symlink_font_misc
#    symlink_font_CID
#    symlink_font_Ethiopic
#    symlink_font_Meltho
#    symlink_font_Speedo
#    symlink_font_TTF
#    symlink_font_Type1
#    symlink_font_encodings
#    symlink_font_util
}


#########
#
#	The doc module
#
#########

function symlink_doc_old() {
    src_dir doc/hardcopy
    dst_dir doc/old/hardcopy

    src_dir doc/hardcopy/BDF
    dst_dir doc/old/hardcopy/BDF

    action	bdf.PS.gz

    src_dir doc/hardcopy/CTEXT
    dst_dir doc/old/hardcopy/CTEXT

    action	ctext.PS.gz

    src_dir doc/hardcopy/FSProtocol
    dst_dir doc/old/hardcopy/FSProtocol

    action	fsproto.PS.gz

    src_dir doc/hardcopy/i18n
    dst_dir doc/old/hardcopy/i18n

    action	Framework.PS.gz
    action	LocaleDB.PS.gz
    action	Trans.PS.gz

    src_dir doc/hardcopy/ICCCM
    dst_dir doc/old/hardcopy/ICCCM

    action	icccm.PS.gz
    action	icccm.idx.PS.gz

    src_dir doc/hardcopy/ICE
    dst_dir doc/old/hardcopy/ICE

    action	ICElib.PS.gz
    action	ice.PS.gz

    src_dir doc/hardcopy/man
    dst_dir doc/old/hardcopy/man

    action	man.PS.gz

    src_dir doc/hardcopy/rstart
    dst_dir doc/old/hardcopy/rstart

    action	rstart.PS.gz

    src_dir doc/hardcopy/RX
    dst_dir doc/old/hardcopy/RX

    action	RX.PS.gz

    src_dir doc/hardcopy/saver
    dst_dir doc/old/hardcopy/saver

    action	saver.PS.gz

    src_dir doc/hardcopy/SM
    dst_dir doc/old/hardcopy/SM

    action	SMlib.PS.gz
    action	xsmp.PS.gz

    src_dir doc/hardcopy/X11
    dst_dir doc/old/hardcopy/X11

    action	xlib.PS.gz
    action	xlib.idx.PS.gz

    src_dir doc/hardcopy/Xaw
    dst_dir doc/old/hardcopy/Xaw

    action	widg.idx.PS.gz
    action	widgets.PS.gz

    src_dir doc/hardcopy/XDMCP
    dst_dir doc/old/hardcopy/XDMCP

    action	xdmcp.PS.gz

    src_dir doc/hardcopy/Xext
    dst_dir doc/old/hardcopy/Xext

    action	AppGroup.PS.gz
    action	DPMS.PS.gz
    action	DPMSLib.PS.gz
    action	bigreq.PS.gz
    action	buffer.PS.gz
    action	dbe.PS.gz
    action	dbelib.PS.gz
    action	evi.PS.gz
    action	lbx.PS.gz
    action	lbx.html
    action	lbxTOC.html
    action	lbxalg.PS.gz
    action	mit-shm.PS.gz
    action	record.PS.gz
    action	recordlib.PS.gz
    action	security.PS.gz
    action	shape.PS.gz
    action	shapelib.PS.gz
    action	sync.PS.gz
    action	synclib.PS.gz
    action	tog-cup.PS.gz
    action	xc-misc.PS.gz
    action	xtest.PS.gz
    action	xtestlib.PS.gz

    src_dir doc/hardcopy/xfs
    dst_dir doc/old/hardcopy/xfs

    action	design.PS.gz

    src_dir doc/hardcopy/Xi
    dst_dir doc/old/hardcopy/Xi

    action	lib.PS.gz
    action	port.PS.gz
    action	proto.PS.gz

    src_dir doc/hardcopy/XIM
    dst_dir doc/old/hardcopy/XIM

    action	xim.PS.gz

    src_dir doc/hardcopy/XKB
    dst_dir doc/old/hardcopy/XKB

    action	XKBlib.ps.gz
    action	XKBproto.ps.gz

    src_dir doc/hardcopy/XLFD
    dst_dir doc/old/hardcopy/XLFD

    action	xlfd.PS.gz

    src_dir doc/hardcopy/Xmu
    dst_dir doc/old/hardcopy/Xmu

    action	xmu.PS.gz

    src_dir doc/hardcopy/XPRINT
    dst_dir doc/old/hardcopy/XPRINT

    action	Xprint_FAQ.html
    action	Xprint_FAQ.txt
    action	Xprint_FAQ.xml
    action	Xprint_old_FAQ.txt
    action	docbook.css
    action	dtprint_fspec.PS.gz
    action	xp_library.PS.gz
    action	xp_proto.PS.gz

    src_dir doc/hardcopy/XProtocol
    dst_dir doc/old/hardcopy/XProtocol

    action	proto.PS.gz
    action	proto.idx.PS.gz

    src_dir doc/hardcopy/Xserver
    dst_dir doc/old/hardcopy/Xserver

    action	Xprt.PS.gz
    action	analysis.PS.gz
    action	appgroup.PS.gz
    action	ddx.PS.gz
    action	fontlib.PS.gz
    action	secint.PS.gz

    src_dir doc/hardcopy/Xt
    dst_dir doc/old/hardcopy/Xt

    action	intr.idx.PS.gz
    action	intrinsics.PS.gz

    src_dir doc/hardcopy/xterm
    dst_dir doc/old/hardcopy/xterm

    action	ctlseqs.PS.gz

    src_dir doc/hardcopy/xtrans
    dst_dir doc/old/hardcopy/xtrans

    action	Xtrans.PS.gz

    src_dir doc/hardcopy/Xv
    dst_dir doc/old/hardcopy/Xv

    action	video
    action	xv-protocol-v2.PS

    src_dir doc/man/general
    dst_dir doc/old/man/general

    action	Consortium.man
    action	security.man
    action	Standards.man
    action	X.man
    action	XOrgFoundation.man
    action	Xprint.man
    action	XProjectTeam.man

    # FIXME: other man pages should be moved to the appropriate library

    src_dir doc/misc
    dst_dir doc/old/misc

    action	xlogo.epsi

    src_dir doc/specs
    dst_dir doc/old/specs

    action	specindex.html

    src_dir doc/specs/BDF
    dst_dir doc/old/specs/BDF

    action	bdf.ms
    action	fig1.ps
    action	fig2.ps

    src_dir doc/specs/CTEXT
    dst_dir doc/old/specs/CTEXT

    action	ctext.tbl.ms

    src_dir doc/specs/FSProtocol
    dst_dir doc/old/specs/FSProtocol

    action	protocol.ms

    src_dir doc/specs/GL
    dst_dir doc/old/specs/GL

    action	libGL.txt

    src_dir doc/specs/i18n
    dst_dir doc/old/specs/i18n

    action	Framework.ms
    action	LocaleDB.ms
    action	Trans.ms

    src_dir doc/specs/ICCCM
    dst_dir doc/old/specs/ICCCM

    action	icccm.ms
    action	indexmacros.t

    src_dir doc/specs/ICE
    dst_dir doc/old/specs/ICE

    action	ICElib.ms
    action	ice.ms

    src_dir doc/specs/PM
    dst_dir doc/old/specs/PM

    action	PM_spec

    src_dir doc/specs/Randr
    dst_dir doc/old/specs/Randr

    action	protocol.txt

    src_dir doc/specs/Render
    dst_dir doc/old/specs/Render

    action	library
    action	protocol

    src_dir doc/specs/rstart
    dst_dir doc/old/specs/rstart

    action	fix.awk
    action	fix.nawk
    action	fix.sed
    action	rstart.ms
    action	rstartd.txt
    action	tmac.rfc

    src_dir doc/specs/RX
    dst_dir doc/old/specs/RX

    action	RX.mif

    src_dir doc/specs/saver
    dst_dir doc/old/specs/saver

    action	saver.ms

    src_dir doc/specs/SIAddresses
    dst_dir doc/old/specs/SIAddresses

    action	IPv6.txt
    action	README
    action	hostname.txt
    action	localuser.txt

    src_dir doc/specs/SM
    dst_dir doc/old/specs/SM

    action	SMlib.ms
    action	xsmp.ms

    src_dir doc/specs/X11
    dst_dir doc/old/specs/X11

    action	AppA
    action	AppB
    action	AppC
    action	AppD
    action	CH01
    action	CH02
    action	CH03
    action	CH04
    action	CH05
    action	CH06
    action	CH07
    action	CH08
    action	CH09
    action	CH10
    action	CH11
    action	CH12
    action	CH13
    action	CH14
    action	CH15
    action	CH16
    action	abstract.t
    action	credits.t
    action	glossary
    action	indexmacros.t
    action	postproc

    src_dir doc/specs/Xaw
    dst_dir doc/old/specs/Xaw

    action	AsciiSink
    action	AsciiSource
    action	AsciiText
    action	Box
    action	CH1
    action	CH2
    action	CH3.intro
    action	CH4.intro
    action	CH5.intro
    action	CH6.intro
    action	CH7.intro
    action	Command
    action	Dialog
    action	Form
    action	Grip
    action	Label
    action	List
    action	MenuButton
    action	Paned
    action	Panner
    action	Porthole
    action	Repeater
    action	Scrollbar
    action	Simple
    action	SimpleMenu
    action	Sme
    action	SmeBSB
    action	SmeLine
    action	StripChart
    action	TPage_Credits
    action	Template
    action	Text
    action	TextActions
    action	TextCustom
    action	TextFuncs
    action	TextSink
    action	TextSource
    action	Toggle
    action	Tree
    action	Viewport
    action	Xtk.widg.front
    action	Xtk.widgets
    action	block.awk
    action	fixindex.awk
    action	strings.mit
    action	strings.xaw
    action	widg.idxmac.t

    src_dir doc/specs/XDMCP
    dst_dir doc/old/specs/XDMCP

    action	xdmcp.ms

    src_dir doc/specs/Xext
    dst_dir doc/old/specs/Xext

    action	AppGroup.mif
    action	DPMS.ms
    action	DPMSLib.ms
    action	bigreq.ms
    action	buffer.ms
    action	dbe.tex
    action	dbelib.tex
    action	evi.ms
    action	lbx.book
    action	lbx.mif
    action	lbxalg.mif
    action	mit-shm.ms
    action	record.ms
    action	recordlib.ms
    action	security.tex
    action	shape.ms
    action	shapelib.ms
    action	sync.tex
    action	synclib.tex
    action	tog-cup.ms
    action	xc-misc.ms
    action	xtest.ms
    action	xtest1.info
    action	xtest1.mm
    action	xtestlib.ms

    src_dir doc/specs/xfs
    dst_dir doc/old/specs/xfs

    action	FSlib.doc
    action	design.ms

    src_dir doc/specs/Xi
    dst_dir doc/old/specs/Xi

    action	encoding.ms
    action	library.ms
    action	porting.ms
    action	protocol.ms

    src_dir doc/specs/XIM
    dst_dir doc/old/specs/XIM

    action	xim.ms

    src_dir doc/specs/XKB/Proto
    dst_dir doc/old/specs/XKB/Proto

    action	XKBproto.book
    action	dflttrns.fm5
    action	encoding.fm5
    action	keysyms.fm5
    action	protocol.fm5
    action	prototoc.doc
    action	title.fm5
    action	types.fm5

    src_dir doc/specs/XKB/XKBlib
    dst_dir doc/old/specs/XKB/XKBlib

    action	XKBlib.book
    action	allchaps.fm5
    action	allchaps.ix
    action	allchaps.lof
    action	allchaps.lot
    action	allchaps.ps
    action	allchaps.toc
    action	fonts.fm5
    action	title.fm5

    src_dir doc/specs/XLFD
    dst_dir doc/old/specs/XLFD

    action	xlfd.tbl.ms

    src_dir doc/specs/Xmu
    dst_dir doc/old/specs/Xmu

    action	Xmu.ms

    src_dir doc/specs/XPRINT
    dst_dir doc/old/specs/XPRINT

    action	xp_library.book
    action	xp_library.mif
    action	xp_libraryIX.doc
    action	xp_libraryTOC.doc
    action	xp_library_cov.mif
    action	xp_proto.book
    action	xp_proto.mif
    action	xp_protoIX.doc
    action	xp_protoTOC.doc
    action	xp_proto_cov.mif

    src_dir doc/specs/XProtocol
    dst_dir doc/old/specs/XProtocol

    action	X11.encoding
    action	X11.keysyms
    action	X11.protocol
    action	glossary
    action	indexmacros.t
    action	postproc

    src_dir doc/specs/Xserver
    dst_dir doc/old/specs/Xserver

    action	Xprt.book
    action	Xprt.mif
    action	XprtIX.doc
    action	XprtTOC.doc
    action	Xprt_cov.mif
    action	analysis.tex
    action	appgroup.ms
    action	ddx.tbl.ms
    action	fontlib.ms
    action	secint.tex

    src_dir doc/specs/Xt
    dst_dir doc/old/specs/Xt

    action	CH01
    action	CH02
    action	CH03
    action	CH04
    action	CH05
    action	CH06
    action	CH07
    action	CH08
    action	CH09
    action	CH10
    action	CH11
    action	CH12
    action	CH13
    action	Xtk.intr.front
    action	appA
    action	appB
    action	appC
    action	appD
    action	appE
    action	appF
    action	intr.idxmac.t
    action	postproc
    action	strings.mit

    src_dir doc/specs/xterm
    dst_dir doc/old/specs/xterm

    action	ctlseqs.ms

    src_dir doc/specs/xtrans
    dst_dir doc/old/specs/xtrans

    action	Xtrans.mm

    src_dir doc/specs/Xv
    dst_dir doc/old/specs/Xv

    action	xv-protocol-v2.txt

    src_dir doc/specs/XvMC
    dst_dir doc/old/specs/XvMC

    action	XvMC_API.txt

    src_dir doc/util
    dst_dir doc/old/util

    action	block.awk
    action	fixindex.awk
    action	indexmacros.t
    action	macros.t
}

function symlink_doc() {
    symlink_doc_old
#    symlink_doc_man
#    ...
}


#########
#
#	The util module
#
#########

function symlink_util_cf() {
    src_dir config/cf
    dst_dir util/cf

    action	Amoeba.cf
    action	apollo.cf
    action	bsd.cf
    action	bsdi.cf
    action	bsdiLib.rules
    action	bsdiLib.tmpl
    action	bsdLib.rules
    action	bsdLib.tmpl
    action	cde.rules
    action	cde.tmpl
    action	convex.cf
    action	cray.cf
    action	cross.def
    action	cross.rules
    action	cygwin.cf
    action	cygwin.rules
    action	cygwin.tmpl
    action	darwin.cf
    action	darwinLib.rules
    action	darwinLib.tmpl
    action	DGUX.cf
    action	dmx.cf
    action	DragonFly.cf
    action	FreeBSD.cf
    action	fujitsu.cf
    action	generic.cf
    action	gnu.cf
    action	gnuLib.rules
    action	gnuLib.tmpl
    action	hp.cf
    action	hpLib.rules
    action	hpLib.tmpl
    action	ibm.cf
    action	ibmLib.rules
    action	ibmLib.tmpl
    action	Imake.cf
    action	Imake.rules
    action	Imake.tmpl
    action	isc.cf
    action	Library.tmpl
    action	linux.cf
    action	lnxdoc.rules
    action	lnxdoc.tmpl
    action	lnxLib.rules
    action	lnxLib.tmpl
    action	luna.cf
    action	lynx.cf
    action	mach.cf
    action	macII.cf
    action	mingw.cf
    action	mingw.rules
    action	mingw.tmpl
    action	minix.cf
    action	Mips.cf
    action	Motif.rules
    action	Motif.tmpl
    action	moto.cf
    action	ncr.cf
    action	nec.cf
    action	necLib.rules
    action	necLib.tmpl
    action	NetBSD.cf
    action	noop.rules
    action	nto.cf
    action	nto.rules
    action	Oki.cf
    action	oldlib.rules
    action	OpenBSD.cf
    action	OpenBSDLib.rules
    action	OpenBSDLib.tmpl
    action	os2.cf
    action	os2def.db
    action	os2Lib.rules
    action	os2Lib.tmpl
    action	os2.rules
    action	osf1.cf
    action	osfLib.rules
    action	osfLib.tmpl
    action	pegasus.cf
    action	QNX4.cf
    action	QNX4.rules
    action	README
    action	sco5.cf
    action	sco.cf
    action	scoLib.rules
    action	sequent.cf
    action	sequentLib.rules
    action	ServerLib.tmpl
    action	Server.tmpl
    action	sgi.cf
    action	sgiLib.rules
    action	sgiLib.tmpl
    action	site.def
    action	site.sample
    action	sony.cf
    action	sun.cf
    action	sunLib.rules
    action	sunLib.tmpl
    action	sv3Lib.rules
    action	sv3Lib.tmpl
    action	sv4Lib.rules
    action	sv4Lib.tmpl
    action	svr3.cf
    action	svr4.cf
    action	Threads.tmpl
    action	ultrix.cf
    action	usl.cf
    action	Win32.cf
    action	Win32.rules
    action	WinLib.tmpl
    action	X11.rules
    action	X11.tmpl
    action	x386.cf
    action	xf86.rules
    action	xf86site.def
    action	xf86.tmpl
    action	xfree86.cf
    action	xorg.cf
    action	xorgsite.def
    action	xorg.tmpl
    action	xorgversion.def
    action	xprint_host.def
}

function symlink_util_imake() {
    src_dir config/imake
    dst_dir util/imake

    action	ccimake.c
    action	imake.c
    action	imake.man
    action	imakemdep.h
    action	imakesvc.cmd
    action	Makefile.ini
}

function symlink_util() {
    symlink_util_cf
    symlink_util_imake
#    ...
}


#########
#
#    Helper functions
#
#########

function error() {
	echo
	echo \ \ \ error:\ \ \ $1
	exit
}

# Function printing out what's going on
function run_module() {
    # $1 module
    # $2 explanation
    echo -n $EXPLANATION for $1 module ...\ 
    symlink_$1
    echo DONE
}

function run() {
    # $1 what to do
    # $2 explanation

    ACTION=$1 EXPLANATION=$2 run_module proto
    ACTION=$1 EXPLANATION=$2 run_module lib
    ACTION=$1 EXPLANATION=$2 run_module app
    ACTION=$1 EXPLANATION=$2 run_module xserver
    ACTION=$1 EXPLANATION=$2 run_module driver
    ACTION=$1 EXPLANATION=$2 run_module font
    ACTION=$1 EXPLANATION=$2 run_module doc
    ACTION=$1 EXPLANATION=$2 run_module util
}

function src_dir() {
    REAL_SRC_DIR=$SRC_DIR/$1
    if [ ! -d $REAL_SRC_DIR ] ; then
	error "Source directory $REAL_SRC_DIR does not exist"
    fi
}

function dst_dir() {
    REAL_DST_DIR=$DST_DIR/$1
    if [ ! -d $REAL_DST_DIR ] ; then
	error "Destination direcotry $REAL_DST_DIR does not exist"
    fi
}

function action() {
    if [ -z $2 ] ; then
	$ACTION	$REAL_SRC_DIR/$1	$REAL_DST_DIR/$1
    else
	$ACTION	$REAL_SRC_DIR/$1	$REAL_DST_DIR/$2
    fi
}

function usage() {
    echo symlink.sh src-dir dst-dir
    echo src-dir: the xc directory of the monolithic source tree
    echo dst-dir: the modular source tree containing proto, app, lib, ...
}

# Check commandline args
function check_args() {
    if [ -z $1 ] ; then
	echo Missing source dir
	usage
	exit
    fi

    if [ -z $2 ] ; then
	echo Missing destination dir
	usage
	exit
    fi
     
    if [ ! -d $1 ] ; then
	echo $1 is not a dir
	usage
	exit
    fi

    if [ ! -d $2 ] ; then
	echo $2 is not a dir
	usage
	exit
    fi

    if [ $1 = $2 ] ; then
	echo source and destination can\'t be the same
	usage
	exit
    fi

    D=`dirname "$relpath"`
    B=`basename "$relpath"`
    abspath="`cd \"$D\" 2>/dev/null && pwd || echo \"$D\"`/$B"

    SRC_DIR=`( cd $1 ; pwd )`
    DST_DIR=`(cd $2 ; pwd )`
}

main $1 $2
