#!/bin/sh

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
#	- possibly check that files are listet in Makefile.am's
#	- Clean target directory of irrelevant files
#

check_destinations () {
    # don't do anything - we are relying on the side
    # effect of dst_dir
    true
}

check_exist() {
    # Check whether $1 exists

    if [ ! -e $1 ] ; then
	error "$1 not found"
    fi

    if [ -d $1 ] ; then
	error "$1 is a directory"
    fi

}

delete_existing() {
    # Delete $2

    rm -f $2
}

link_files() {
    # Link $1 to $2

    if [ ! -e $2 ] ; then
	ln -s $1 $2
    fi
}

run_symlink() {
    run check_destinations "Creating destination directories"
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

symlink_proto_core() {
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
    action	Xpoll.h.in
    action	Xproto.h
    action	Xprotostr.h
    action	Xthreads.h	# not used in server
    action	Xw32defs.h
    action	XWDFile.h
    action	Xwindows.h
    action	Xwinsock.h
}

# Extension protocols

symlink_proto_applewm() {
    src_dir lib/apple
    dst_dir proto/AppleWM

    action      applewm.h
    action      applewmstr.h
}

symlink_proto_bigreq() {
    src_dir include/extensions
    dst_dir proto/BigReqs

    action	bigreqstr.h
}

symlink_proto_composite() {
    src_dir include/extensions
    dst_dir proto/Composite

    action	composite.h
    action	compositeproto.h
}

symlink_proto_damage() {
    src_dir include/extensions
    dst_dir proto/Damage

    action	damageproto.h
    action	damagewire.h
}

symlink_proto_dmx() {
    src_dir include/extensions
    dst_dir proto/DMX

    action	dmxext.h
    action	dmxproto.h
}

symlink_proto_evie() {
    src_dir include/extensions
    dst_dir proto/EvIE

    action	Xeviestr.h
}

symlink_proto_fixes() {
    src_dir include/extensions
    dst_dir proto/Fixes

    action	xfixesproto.h
    action	xfixeswire.h
}

symlink_proto_fontcache() {
    src_dir include/extensions
    dst_dir proto/Fontcache

    action	fontcache.h
    action	fontcacheP.h
    action	fontcachstr.h
}

symlink_proto_input() {
    src_dir include/extensions
    dst_dir proto/Input

    action	XI.h
    action	XInput.h
    action	XIproto.h
}

symlink_proto_kb() {
    src_dir include/extensions
    dst_dir proto/KB

    action	XKBgeom.h
    action	XKB.h
    action	XKBproto.h
    action	XKBsrv.h
    action	XKBstr.h
}

symlink_proto_xinerama() {
    src_dir include/extensions
    dst_dir proto/Xinerama

    action	panoramiXext.h
    action	panoramiXproto.h
    action	Xinerama.h	# not used in server
}

symlink_proto_pm() {
    src_dir programs/proxymngr
    dst_dir proto/PM

    action	PM.h
    action	PMproto.h
}

symlink_proto_print() {
    src_dir include/extensions
    dst_dir proto/Print

    action	Print.h
    action	Printstr.h
}

symlink_proto_randr() {
    src_dir include/extensions
    dst_dir proto/Randr

    action	randr.h
    action	randrproto.h
}

symlink_proto_record() {
    src_dir include/extensions
    dst_dir proto/Record

    action	record.h
    action	recordstr.h
}

symlink_proto_render() {
    src_dir include/extensions
    dst_dir proto/Render

    action	render.h
    action	renderproto.h
}

symlink_proto_resource() {
    src_dir include/extensions
    dst_dir proto/Resource

    action	XResproto.h
}

symlink_proto_saver() {
    src_dir include/extensions
    dst_dir proto/ScrnSaver

    action	saver.h
    action	saverproto.h
    action	scrnsaver.h	# not used in server
}

symlink_proto_trap() {
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

symlink_proto_video() {
    src_dir include/extensions
    dst_dir proto/Video

    action	vldXvMC.h	# not used in server
    action	Xv.h
    action	Xvproto.h
    action	XvMC.h
    action	XvMCproto.h
}

symlink_proto_windowswm() {
    src_dir lib/windows
    dst_dir proto/WindowsWM

    action      windowswm.h
    action      windowswmstr.h
}

symlink_proto_xcmisc() {
    src_dir include/extensions
    dst_dir proto/XCMisc

    action	xcmiscstr.h
}

# should these be exploded into individual extension components?
symlink_proto_xext() {
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

symlink_proto_xf86bigfont() {
    src_dir include/extensions
    dst_dir proto/XF86BigFont

    action	xf86bigfont.h
    action	xf86bigfstr.h
}

symlink_proto_xf86dga() {
    src_dir include/extensions
    dst_dir proto/XF86DGA

    action	xf86dga1.h
    action	xf86dga1str.h
    action	xf86dga.h
    action	xf86dgastr.h
}

symlink_proto_xf86dri() {
    src_dir extras/Mesa/src/glx/x11
    dst_dir proto/XF86DRI

    action xf86dri.h
    action xf86dristr.h
}

symlink_proto_xf86misc() {
    src_dir include/extensions
    dst_dir proto/XF86Misc

    action	xf86misc.h
    action	xf86mscstr.h
}

symlink_proto_xf86rush() {
    src_dir include/extensions
    dst_dir proto/XF86Rush

    action	xf86rush.h
    action	xf86rushstr.h
}

symlink_proto_xf86vidmode() {
    src_dir include/extensions
    dst_dir proto/XF86VidMode

    action	xf86vmode.h
    action	xf86vmstr.h
}

symlink_proto_fonts() {
    src_dir include/fonts
    dst_dir proto/Fonts

    action	font.h
    action	fontproto.h
    action	fontstruct.h
    action	FS.h		# not used in server
    action	fsmasks.h
    action	FSproto.h	# not used in server
}

symlink_proto_gl() {
    src_dir include/GL
    dst_dir proto/GL

    action	glxint.h
    action	glxmd.h
    action	glxproto.h
    action	glxtokens.h

    src_dir extras/Mesa/include/GL/internal

    action	glcore.h
}

symlink_proto() {
    # Core protocol
    symlink_proto_core

    # Extension protocols
    symlink_proto_applewm
    symlink_proto_bigreq
    symlink_proto_composite
    symlink_proto_damage
    symlink_proto_dmx
    symlink_proto_evie
    symlink_proto_fixes
    symlink_proto_fontcache
    symlink_proto_input
    symlink_proto_kb
    symlink_proto_pm
    symlink_proto_print
    symlink_proto_randr
    symlink_proto_record
    symlink_proto_render
    symlink_proto_resource
    symlink_proto_saver
    symlink_proto_trap
    symlink_proto_video
    symlink_proto_windowswm
    symlink_proto_xcmisc
    symlink_proto_xext
    symlink_proto_xf86bigfont
    symlink_proto_xf86dga
    symlink_proto_xf86dri
    symlink_proto_xf86misc
    symlink_proto_xf86rush
    symlink_proto_xf86vidmode
    symlink_proto_xinerama

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

symlink_lib_applewm() {
    src_dir lib/apple
    dst_dir lib/AppleWM/src

    action      applewm.c
    
    dst_dir lib/AppleWM/man

    action      AppleWM.man AppleWM.3
}

symlink_lib_dmx() {
    src_dir lib/dmx
    dst_dir lib/dmx/src

    action	dmx.c

    src_dir doc/man/DMX
    dst_dir lib/dmx/man

    action	DMXAddInput.man			DMXAddInput.3
    action	DMXAddScreen.man		DMXAddScreen.3
    action	DMXChangeDesktopAttributes.man	DMXChangeDesktopAttributes.3
    action	DMXChangeScreensAttributes.man	DMXChangeScreensAttributes.3
    action	DMXForceWindowCreation.man	DMXForceWindowCreation.3
    action	DMXGetDesktopAttributes.man	DMXGetDesktopAttributes.3
    action	DMXGetInputAttributes.man	DMXGetInputAttributes.3
    action	DMXGetInputCount.man		DMXGetInputCount.3
    action	DMXGetScreenAttributes.man	DMXGetScreenAttributes.3
    action	DMXGetScreenCount.man		DMXGetScreenCount.3
    action	DMXGetWindowAttributes.man	DMXGetWindowAttributes.3
    action	DMX.man				DMX.3
    action	DMXQueryExtension.man		DMXQueryExtension.3
    action	DMXQueryVersion.man		DMXQueryVersion.3
    action	DMXRemoveInput.man		DMXRemoveInput.3
    action	DMXRemoveScreen.man		DMXRemoveScreen.3
    action	DMXSync.man			DMXSync.3
}

symlink_lib_composite() {
    src_dir lib/Xcomposite
    dst_dir lib/Xcomposite

    dst_dir lib/Xcomposite/include/X11/extensions

    action	Xcomposite.h

    dst_dir lib/Xcomposite/src

    action	xcompositeint.h
    action	Xcomposite.c
}

symlink_lib_damage() {
    src_dir lib/Xdamage
    dst_dir lib/Xdamage

    dst_dir	lib/Xdamage/include/X11/extensions

    action	Xdamage.h

    dst_dir	lib/Xdamage/src

    action	xdamageint.h
    action	Xdamage.c
}

symlink_lib_evie() {
    src_dir include/extensions
    dst_dir lib/Xevie/include/X11/extensions

    action	Xevie.h

    src_dir lib/Xevie
    dst_dir lib/Xevie

    action	AUTHORS
    action	xevie.pc.in

    dst_dir lib/Xevie/src

    action	Xevie.c

    dst_dir lib/Xevie/man

    action	Xevie.man
}

symlink_lib_fixes() {
    src_dir lib/Xfixes
    dst_dir lib/Xfixes

    dst_dir lib/Xfixes/src

    action	Cursor.c
    action	Region.c
    action	SaveSet.c
    action	Selection.c
    action	Xfixes.c
    action	Xfixesint.h

    dst_dir lib/Xfixes/include/X11/extensions
    
    action	Xfixes.h

    dst_dir lib/Xfixes/man

    action	Xfixes.man	Xfixes.3
}

symlink_lib_xau() {
    src_dir lib/Xau
    dst_dir lib/Xau

    action	README

    action	AuDispose.c
    action	AuFileName.c
    action	AuGetAddr.c
    action	AuGetBest.c
    action	AuLock.c
    action	AuRead.c
    action	Autest.c
    action	AuUnlock.c
    action	AuWrite.c
    action	k5encode.c

    dst_dir lib/Xau/include/X11

    action	Xauth.h

    src_dir doc/man/Xau
    dst_dir lib/Xau

    action	Xau.man
}

symlink_lib_xtrans() {
    src_dir lib/xtrans
    dst_dir lib/xtrans

    action	transport.c
    action	Xtrans.c
    action	Xtransdnet.c
    action	Xtrans.h
    action	Xtransint.h
    action	Xtranslcl.c
    action	Xtransos2.c
    action	Xtranssock.c
    action	Xtranstli.c
    action	Xtransutil.c
}

symlink_lib_xdmcp() {
    src_dir lib/Xdmcp
    dst_dir lib/Xdmcp

    action	Wrap.h

    action	A8Eq.c
    action	AA16.c
    action	AA32.c
    action	AA8.c
    action	Alloc.c
    action	AofA8.c
    action	CA8.c
    action	CmpKey.c
    action	DA16.c
    action	DA32.c
    action	DA8.c
    action	DAofA8.c
    action	DecKey.c
    action	Fill.c
    action	Flush.c
    action	GenKey.c
    action	IncKey.c
    action	RA16.c
    action	RA32.c
    action	RA8.c
    action	RaA16.c
    action	RaA32.c
    action	RaA8.c
    action	RaAoA8.c
    action	RAofA8.c
    action	RC16.c
    action	RC32.c
    action	RC8.c
    action	RHead.c
    action	RR.c
    action	Unwrap.c
    action	WA16.c
    action	WA32.c
    action	WA8.c
    action	WAofA8.c
    action	WC16.c
    action	WC32.c
    action	WC8.c
    action	Whead.c
    action	Wrap.c
    action	Wraphelp.c

    action	Wraphelp.README.crypto

    dst_dir lib/Xdmcp/include/X11

    action	Xdmcp.h
}

symlink_lib_xext() {
    src_dir lib/Xext
    dst_dir lib/Xext/src

    action	DPMS.c
    action	extutil.c
    action	globals.c
    action	MITMisc.c
    action	XAppgroup.c
    action	Xcup.c
    action	Xdbe.c
    action	XEVI.c
    action	XLbx.c
    action	XMultibuf.c
    action	XSecurity.c
    action	XShape.c
    action	XShm.c
    action	XSync.c
    action	XTestExt1.c

    src_dir doc/man/Xext
    dst_dir lib/Xext/man

    action      DPMSCapable.man
    action      DPMSDisable.man
    action      DPMSEnable.man
    action      DPMSForceLevel.man
    action      DPMSGetTimeouts.man
    action      DPMSGetVersion.man
    action      DPMSInfo.man
    action      DPMSQueryExtension.man
    action      DPMSSetTimeouts.man
    action	XcupGetReservedColormapEntries.man
    action	XcupQueryVersion.man
    action	XcupStoreColors.man
    action	Xevi.man
    action	Xmbuf.man
    action	XShape.man

    src_dir doc/man/Xext/dbe

    action	DBE.man
    action	XdbeAllo.man	XdbeAllocateBackBufferName.man
    action	XdbeBegi.man	XdbeBeginIdiom.man
    action	XdbeEndI.man	XdbeEndIdiom.man
    action	XdbeDeal.man	XdbeDeallocateBackBufferName.man
    action	XdbeFree.man	XdbeFreeVisualInfo.man
    action	XdbeQuer.man	XdbeQueryExtension.man
    action	XdbeSwap.man	XdbeSwapBuffers.man
    action	XdbeGetB.man	XdbeGetBackBufferAttributes.man
    action	XdbeGetV.man	XdbeGetVisualInfo.man
} 

symlink_lib_x11() {
    src_dir lib/X11

    # public .h files
    dst_dir lib/X11/include/X11

    action	cursorfont.h
    action	Xregion.h
    action	Xcms.h
    action	XKBlib.h
    action	Xlib.h
    action	Xlibint.h
    action	Xlocale.h
    action	Xresource.h
    action	Xutil.h
    action	ImUtil.h

    dst_dir lib/X11/src

    # internal .h files
    action	Cmap.h
    action	Cr.h
    action	Key.h
    action	locking.h
    action	poly.h
    action	Xatomtype.h
    action	Xintatom.h
    action	Xintconn.h
    action	XomGeneric.h
    action	Xresinternal.h
    action	XrmI.h

    # Misc
   
    action	XKeysymDB
    action	XErrorDB
    
    # source .c files

    action	AllCells.c
    action	AllowEv.c
    action	AllPlanes.c
    action	AutoRep.c
    action	Backgnd.c
    action	BdrWidth.c
    action	Bell.c
    action	Border.c
    action	ChAccCon.c
    action	ChActPGb.c
    action	ChClMode.c
    action	ChCmap.c
    action	ChGC.c
    action	ChKeyCon.c
    action	ChkIfEv.c
    action	ChkMaskEv.c
    action	ChkTypEv.c
    action	ChkTypWEv.c
    action	ChkWinEv.c
    action	ChPntCon.c
    action	ChProp.c
    action	ChSaveSet.c
    action	ChWAttrs.c
    action	ChWindow.c
    action	CirWin.c
    action	CirWinDn.c
    action	CirWinUp.c
    action	ClDisplay.c
    action	ClearArea.c
    action	Clear.c
    action	ConfWind.c
    action	ConnDis.c
    action	Context.c
    action	ConvSel.c
    action	CopyArea.c
    action	CopyCmap.c
    action	CopyGC.c
    action	CopyPlane.c
    action	CrBFData.c
    action	CrCmap.c
    action	CrCursor.c
    action	CrGC.c
    action	CrGlCur.c
    action	CrPFBData.c
    action	CrPixmap.c
    action	CrWindow.c
    action	Cursor.c
    action	DefCursor.c
    action	DelProp.c
    action	Depths.c
    action	DestSubs.c
    action	DestWind.c
    action	DisName.c
    action	DrArc.c
    action	DrArcs.c
    action	DrLine.c
    action	DrLines.c
    action	DrPoint.c
    action	DrPoints.c
    action	DrRect.c
    action	DrRects.c
    action	DrSegs.c
    action	ErrDes.c
    action	ErrHndlr.c
    action	evtomask.c
    action	EvToWire.c
    action	FetchName.c
    action	FillArc.c
    action	FillArcs.c
    action	FillPoly.c
    action	FillRct.c
    action	FillRcts.c
    action	FilterEv.c
    action	Flush.c
    action	Font.c
    action	FontInfo.c
    action	FontNames.c
    action	FreeCmap.c
    action	FreeCols.c
    action	FreeCurs.c
    action	FreeEData.c
    action	FreeGC.c
    action	FreePix.c
    action	FSSaver.c
    action	FSWrap.c
    action	GCMisc.c
    action	Geom.c
    action	GetAtomNm.c
    action	GetColor.c
    action	GetDflt.c
    action	GetFPath.c
    action	GetFProp.c
    action	GetGCVals.c
    action	GetGeom.c
    action	GetHColor.c
    action	GetHints.c
    action	GetIFocus.c
    action	GetImage.c
    action	GetKCnt.c
    action	GetMoEv.c
    action	GetNrmHint.c
    action	GetPCnt.c
    action	GetPntMap.c
    action	GetProp.c
    action	GetRGBCMap.c
    action	GetSOwner.c
    action	GetSSaver.c
    action	GetStCmap.c
    action	GetTxtProp.c
    action	GetWAttrs.c
    action	GetWMCMapW.c
    action	GetWMProto.c
    action	globals.c
    action	GrButton.c
    action	GrKeybd.c
    action	GrKey.c
    action	GrPointer.c
    action	GrServer.c
    action	Host.c
    action	Iconify.c
    action	IfEvent.c
    action	imConv.c
    action	ImText16.c
    action	ImText.c
    action	ImUtil.c
    action	InitExt.c
    action	InsCmap.c
    action	IntAtom.c
    action	KeyBind.c
    action	KeysymStr.c
    action	KillCl.c
    action	LiHosts.c
    action	LiICmaps.c
    action	LiProps.c
    action	ListExt.c
    action	LoadFont.c
    action	LockDis.c
    action	locking.c
    action	LookupCol.c
    action	LowerWin.c
    action	Macros.c
    action	MapRaised.c
    action	MapSubs.c
    action	MapWindow.c
    action	MaskEvent.c
    action	Misc.c
    action	ModMap.c
    action	MoveWin.c
    action	NextEvent.c
    action	OCWrap.c
    action	OMWrap.c
    action	OpenDis.c
    action	os2Stubs.c
    action	ParseCmd.c
    action	ParseCol.c
    action	ParseGeom.c
    action	PeekEvent.c
    action	PeekIfEv.c
    action	Pending.c
    action	PixFormats.c
    action	PmapBgnd.c
    action	PmapBord.c
    action	PolyReg.c
    action	PolyTxt16.c
    action	PolyTxt.c
    action	PropAlloc.c
    action	PutBEvent.c
    action	PutImage.c
    action	Quarks.c
    action	QuBest.c
    action	QuColor.c
    action	QuColors.c
    action	QuCurShp.c
    action	QuExt.c
    action	QuKeybd.c
    action	QuPntr.c
    action	QuStipShp.c
    action	QuTextE16.c
    action	QuTextExt.c
    action	QuTileShp.c
    action	QuTree.c
    action	RaiseWin.c
    action	RdBitF.c
    action	RecolorC.c
    action	ReconfWin.c
    action	ReconfWM.c
    action	Region.c
    action	RegstFlt.c
    action	RepWindow.c
    action	RestackWs.c
    action	RotProp.c
    action	ScrResStr.c
    action	SelInput.c
    action	SendEvent.c
    action	SetBack.c
    action	SetClMask.c
    action	SetClOrig.c
    action	SetCRects.c
    action	SetDashes.c
    action	SetFont.c
    action	SetFore.c
    action	SetFPath.c
    action	SetFunc.c
    action	SetHints.c
    action	SetIFocus.c
    action	SetLocale.c
    action	SetLStyle.c
    action	SetNrmHint.c
    action	SetPMask.c
    action	SetPntMap.c
    action	SetRGBCMap.c
    action	SetSOwner.c
    action	SetSSaver.c
    action	SetState.c
    action	SetStCmap.c
    action	SetStip.c
    action	SetTile.c
    action	SetTSOrig.c
    action	SetTxtProp.c
    action	SetWMCMapW.c
    action	SetWMProto.c
    action	StBytes.c
    action	StColor.c
    action	StColors.c
    action	StName.c
    action	StNColor.c
    action	StrKeysym.c
    action	StrToText.c
    action	Sync.c
    action	Synchro.c
    action	Text16.c
    action	Text.c
    action	TextExt16.c
    action	TextExt.c
    action	TextToStr.c
    action	TrCoords.c
    action	udcInf.c
    action	UIThrStubs.c
    action	UndefCurs.c
    action	UngrabBut.c
    action	UngrabKbd.c
    action	UngrabKey.c
    action	UngrabPtr.c
    action	UngrabSvr.c
    action	UninsCmap.c
    action	UnldFont.c
    action	UnmapSubs.c
    action	UnmapWin.c
    action	VisUtil.c
    action	WarpPtr.c
    action	Window.c
    action	WinEvent.c
    action	Withdraw.c
    action	WMGeom.c
    action	WMProps.c
    action	WrBitF.c
    action	XlibAsync.c
    action	XlibInt.c
    action	Xrm.c

    # XCMS files
    dst_dir lib/X11/src/xcms

    action	AddDIC.c
    action	AddSF.c
    action	CCC.c
    action	cmsAllCol.c
    action	cmsAllNCol.c
    action	cmsCmap.c
    action	cmsColNm.c
    action	cmsGlobls.c
    action	cmsInt.c
    action	cmsLkCol.c
    action	cmsMath.c
    action	cmsProp.c
    action	cmsTrig.c
    action	CvCols.c
    action	CvColW.c
    action	Cv.h
    action	HVC.c
    action	HVCGcC.c
    action	HVCGcV.c
    action	HVCGcVC.c
    action	HVCMnV.c
    action	HVCMxC.c
    action	HVCMxV.c
    action	HVCMxVC.c
    action	HVCMxVs.c
    action	HVCWpAj.c
    action	IdOfPr.c
    action	Lab.c
    action	LabGcC.c
    action	LabGcL.c
    action	LabGcLC.c
    action	LabMnL.c
    action	LabMxC.c
    action	LabMxL.c
    action	LabMxLC.c
    action	LabWpAj.c
    action	LRGB.c
    action	Luv.c
    action	LuvGcC.c
    action	LuvGcL.c
    action	LuvGcLC.c
    action	LuvMnL.c
    action	LuvMxC.c
    action	LuvMxL.c
    action	LuvMxLC.c
    action	LuvWpAj.c
    action	OfCCC.c
    action	PrOfId.c
    action	QBlack.c
    action	QBlue.c
    action	QGreen.c
    action	QRed.c
    action	QuCol.c
    action	QuCols.c
    action	QWhite.c
    action	SetCCC.c
    action	SetGetCols.c
    action	StCol.c
    action	StCols.c
    action	UNDEFINED.c
    action	uvY.c
    action	Xcmsint.h
    action	XRGB.c
    action	xyY.c
    action	XYZ.c
    action	Xcms.txt

    # XKB files
    dst_dir lib/X11/src/xkb

    action	XKBAlloc.c
    action	XKBBell.c
    action	XKBBind.c
    action	XKB.c
    action	XKBCompat.c
    action	XKBCtrls.c
    action	XKBCvt.c
    action	XKBExtDev.c
    action	XKBGAlloc.c
    action	XKBGeom.c
    action	XKBGetByName.c
    action	XKBGetMap.c
    action	XKBleds.c
    action	XKBlibint.h
    action	XKBList.c
    action	XKBMAlloc.c
    action	XKBMisc.c
    action	XKBNames.c
    action	XKBRdBuf.c
    action	XKBSetGeom.c
    action	XKBSetMap.c
    action	XKBUse.c
    
    # Xlib I18n files

    dst_dir lib/X11/src/xlibi18n
    
    action	ICWrap.c
    action	imKStoUCS.c
    action	IMWrap.c
    action	lcCharSet.c
    action	lcConv.c
    action	lcCT.c
    action	lcDB.c
    action	lcDynamic.c
    action	lcFile.c
    action	lcGeneric.c
    action	lcInit.c
    action	lcPrTxt.c
    action	lcPublic.c
    action	lcPubWrap.c
    action	lcRM.c
    action	lcStd.c
    action	lcTxtPr.c
    action	lcUTF8.c
    action	lcUtil.c
    action	lcWrap.c
    action	mbWMProps.c
    action	mbWrap.c
    action	utf8WMProps.c
    action	utf8Wrap.c
    action	wcWrap.c
    action	Xaixlcint.h
    action	XDefaultIMIF.c
    action	XDefaultOMIF.c
    action	XimImSw.h
    action	Ximint.h
    action	XimintL.h
    action	XimintP.h
    action	XimProto.h
    action	XimThai.h
    action	XimTrans.h
    action	XimTrInt.h
    action	XimTrX.h
    action	XlcDL.c
    action	XlcGeneric.h
    action	Xlcint.h
    action	XlcPubI.h
    action	XlcPublic.h
    action	XlcSL.c
    
    # XIMPC input method files

    dst_dir lib/X11/modules/im/ximcp

    action	imCallbk.c
    action	imDefFlt.c
    action	imDefIc.c
    action	imDefIm.c
    action	imDefLkup.c
    action	imDispch.c
    action	imEvToWire.c
    action	imExten.c
    action	imImSw.c
    action	imInsClbk.c
    action	imInt.c
    action	imLcFlt.c
    action	imLcGIc.c
    action	imLcIc.c
    action	imLcIm.c
    action	imLcLkup.c
    action	imLcPrs.c
    action	imLcSIc.c
    action	imRmAttr.c
    action	imRm.c
    action	imThaiFlt.c
    action	imThaiIc.c
    action	imThaiIm.c
    action	imTrans.c
    action	imTransR.c
    action	imTrX.c

    # default lc files

    dst_dir lib/X11/modules/lc/def
    
    action	lcDefConv.c
    
    # generic lc files
    
    dst_dir lib/X11/modules/lc/gen
    
    action	lcGenConv.c

    # UTF-8 lc files
    
    dst_dir lib/X11/modules/lc/Utf8
    
    action	lcUTF8Load.c

    # Xlocale lc files
    
    dst_dir lib/X11/modules/lc/xlocale
    
    action	lcEuc.c
    action	lcJis.c
    action	lcSjis.c
    
    # Generic output method files

    dst_dir lib/X11/modules/om/generic
    
    action	omDefault.c
    action	omGeneric.c
    action	omImText.c
    action	omText.c
    action	omTextEsc.c
    action	omTextExt.c
    action	omTextPer.c
    action	omXChar.c
    
    # man pages

    src_dir doc/man/X11
    dst_dir lib/X11/man

    action	AllPlanes.man	AllPlanes.man
    action	BlkPScrn.man	BlackPixelOfScreen.man
    action	Dis3C.man	DisplayOfCCC.man
    action	ImageOrd.man	ImageByteOrder.man
    action	IsCKey.man	IsCursorKey.man
    action	XACHints.man	XAllocClassHint.man
    action	XAIcSize.man	XAllocIconSize.man
    action	XASCmap.man	XAllocStandardColormap.man
    action	XASHints.man	XAllocSizeHints.man
    action	XAWMHints.man	XAllocWMHints.man
    action	XAddHost.man	XAddHost.man
    action	XAllColor.man	XAllocColor.man
    action	XAllEvnt.man	XAllowEvents.man
    action	XAnyEvent.man	XAnyEvent.man
    action	XButEvent.man	XButtonEvent.man
    action	XCKCntrl.man	XChangeKeyboardControl.man
    action	XCKMping.man	XChangeKeyboardMapping.man
    action	XCMEvent.man	XClientMessageEvent.man
    action	XCPCntrl.man	XChangePointerControl.man
    action	XCSSet.man	XChangeSaveSet.man
    action	XCWAttrib.man	XChangeWindowAttributes.man
    action	XCWEvent.man	XCreateWindowEvent.man
    action	XCirEvent.man	XCirculateEvent.man
    action	XCirREven.man	XCirculateRequestEvent.man
    action	XClrArea.man	XClearArea.man
    action	XCmpEvent.man	XColormapEvent.man
    action	XConEvent.man	XConfigureEvent.man
    action	XConREven.man	XConfigureRequestEvent.man
    action	XConfWin.man	XConfigureWindow.man
    action	XCopyArea.man	XCopyArea.man
    action	XCreCmap.man	XCreateColormap.man
    action	XCreFCur.man	XCreateFontCursor.man
    action	XCreFSet.man	XCreateFontSet.man
    action	XCreGC.man	XCreateGC.man
    action	XCreIC.man	XCreateIC.man
    action	XCreImage.man	XInitImage.man
    action	XCreOC.man	XCreateOC.man
    action	XCrePmap.man	XCreatePixmap.man
    action	XCreReg.man	XCreateRegion.man
    action	XCreWin.man	XCreateWindow.man
    action	XCroEvent.man	XCrossingEvent.man
    action	XDWEvent.man	XDestroyWindowEvent.man
    action	XDefCur.man	XDefineCursor.man
    action	XDesWin.man	XDestroyWindow.man
    action	XDrArc.man	XDrawArc.man
    action	XDrIStr.man	XDrawImageString.man
    action	XDrLine.man	XDrawLine.man
    action	XDrPoint.man	XDrawPoint.man
    action	XDrRect.man	XDrawRectangle.man
    action	XDrString.man	XDrawString.man
    action	XDrText.man	XDrawText.man
    action	XERegion.man	XEmptyRegion.man
    action	XEnumDB.man	XrmEnumerateDatabase.man
    action	XEofFSet.man	XExtentsOfFontSet.man
    action	XErrEvent.man	XErrorEvent.man
    action	XExpEvent.man	XExposeEvent.man
    action	XFCEvent.man	XFocusChangeEvent.man
    action	XFEvent.man	XFilterEvent.man
    action	XFSExt.man	XFontSetExtents.man
    action	XFillRect.man	XFillRectangle.man
    action	XFlush.man	XFlush.man
    action	XFofFSet.man	XFontsOfFontSet.man
    action	XFree.man	XFree.man
    action	XGEEvent.man	XGraphicsExposeEvent.man
    action	XGEvent.man	XGravityEvent.man
    action	XGFDBase.man	XrmGetFileDatabase.man
    action	XGetRes.man	XrmGetResource.man
    action	XGetVInfo.man	XGetVisualInfo.man
    action	XGetWAttr.man	XGetWindowAttributes.man
    action	XGetWProp.man	XGetWindowProperty.man
    action	XGrButton.man	XGrabButton.man
    action	XGrKey.man	XGrabKey.man
    action	XGrKeybrd.man	XGrabKeyboard.man
    action	XGrPntr.man	XGrabPointer.man
    action	XGrServer.man	XGrabServer.man
    action	XIcWin.man	XIconifyWindow.man
    action	XIfEvent.man	XIfEvent.man
    action	XInitial.man	XrmInitialize.man
    action	XInstCmap.man	XInstallColormap.man
    action	XIntConn.man	XAddConnectionWatch.man
    action	XInterReg.man	XIntersectRegion.man
    action	XInternA.man	XInternAtom.man
    action	XKMapEven.man	XKeymapEvent.man
    action	XListFont.man	XListFonts.man
    action	XLoadFont.man	XLoadFont.man
    action	XLookKsym.man	XLookupKeysym.man
    action	XMDBases.man	XrmMergeDatabases.man
    action	XMEvent.man	XMapEvent.man
    action	XMREvent.man	XMapRequestEvent.man
    action	XMapWin.man	XMapWindow.man
    action	XNEvent.man	XNextEvent.man
    action	XNoOp.man	XNoOp.man
    action	XOpDsply.man	XOpenDisplay.man
    action	XOpenIM.man	XOpenIM.man
    action	XOpenOM.man	XOpenOM.man
    action	XPEvent.man	XPropertyEvent.man
    action	XParGeom.man	XParseGeometry.man
    action	XPolyReg.man	XPolygonRegion.man
    action	XPutBEvnt.man	XPutBackEvent.man
    action	XPutImage.man	XPutImage.man
    action	XPutRes.man	XrmPutResource.man
    action	XQBSize.man	XQueryBestSize.man
    action	XQColor.man	XQueryColor.man
    action	XQExtension.man	XQueryExtension.man
    action	XQPointer.man	XQueryPointer.man
    action	XQTree.man	XQueryTree.man
    action	XREvent.man	XReparentEvent.man
    action	XRMStr.man	XResourceManagerString.man
    action	XRREvent.man	XResizeRequestEvent.man
    action	XRaiseWin.man	XRaiseWindow.man
    action	XReadBF.man	XReadBitmapFile.man
    action	XRecCur.man	XRecolorCursor.man
    action	XReparWin.man	XReparentWindow.man
    action	XSCEvent.man	XSelectionClearEvent.man
    action	XSContext.man	XSaveContext.man
    action	XSEvent.man	XSelectionEvent.man
    action	XSICFoc.man	XSetICFocus.man
    action	XSICVals.man	XSetICValues.man
    action	XSInput.man	XSelectInput.man
    action	XSLTTProp.man	XStringListToTextProperty.man
    action	XSREvent.man	XSelectionRequestEvent.man
    action	XSeArcMod.man	XSetArcMode.man
    action	XSeClipO.man	XSetClipOrigin.man
    action	XSeClosDM.man	XSetCloseDownMode.man
    action	XSeCmd.man	XSetCommand.man
    action	XSeErrHan.man	XSetErrorHandler.man
    action	XSeEvent.man	XSendEvent.man
    action	XSeFillS.man	XSetFillStyle.man
    action	XSeFont.man	XSetFont.man
    action	XSeFontP.man	XSetFontPath.man
    action	XSeInFoc.man	XSetInputFocus.man
    action	XSeLAttr.man	XSetLineAttributes.man
    action	XSePMap.man	XSetPointerMapping.man
    action	XSeScSav.man	XSetScreenSaver.man
    action	XSeSelOwn.man	XSetSelectionOwner.man
    action	XSeState.man	XSetState.man
    action	XSeTFHint.man	XSetTransientForHint.man
    action	XSeTProp.man	XSetTextProperty.man
    action	XSeTile.man	XSetTile.man
    action	XSeWMCMac.man	XSetWMClientMachine.man
    action	XSeWMCWin.man	XSetWMColormapWindows.man
    action	XSeWMINam.man	XSetWMIconName.man
    action	XSeWMName.man	XSetWMName.man
    action	XSeWMProp.man	XSetWMProperties.man
    action	XSeWMProt.man	XSetWMProtocols.man
    action	XStBytes.man	XStoreBytes.man
    action	XStColors.man	XStoreColors.man
    action	XStTKsym.man	XStringToKeysym.man
    action	XSupLoc.man	XSupportsLocale.man
    action	XSync.man	XSynchronize.man
    action	XTLTTProp.man	XmbTextListToTextProperty.man
    action	XTextExt.man	XTextExtents.man
    action	XTextWid.man	XTextWidth.man
    action	XThreads.man	XInitThreads.man
    action	XTranWCo.man	XTranslateCoordinates.man
    action	XUQuark.man	XrmUniqueQuark.man
    action	XUmapEven.man	XUnmapEvent.man
    action	XUnmapWin.man	XUnmapWindow.man
    action	XVCNList.man	XVaCreateNestedList.man
    action	XVEvent.man	XVisibilityEvent.man
    action	XWarpPntr.man	XWarpPointer.man
    action	Xcms3CoC.man	XcmsCCCOfColormap.man
    action	XcmsAClr.man	XcmsAllocColor.man
    action	XcmsCClrs.man	XcmsConvertColors.man
    action	XcmsClr.man	XcmsColor.man
    action	XcmsCre3C.man	XcmsCreateCCC.man
    action	XcmsD3C.man	XcmsDefaultCCC.man
    action	XcmsLaQMC.man	XcmsCIELabQueryMaxC.man
    action	XcmsLuQMC.man	XcmsCIELuvQueryMaxC.man
    action	XcmsQBlk.man	XcmsQueryBlack.man
    action	XcmsQClr.man	XcmsQueryColor.man
    action	XcmsSClr.man	XcmsStoreColor.man
    action	XcmsSWP.man	XcmsSetWhitePoint.man
    action	XcmsTQMC.man	XcmsTekHVCQueryMaxC.man
    action	XmbDIStr.man	XmbDrawImageString.man
    action	XmbDStr.man	XmbDrawString.man
    action	XmbDTxt.man	XmbDrawText.man
    action	XmbLStr.man	XmbLookupString.man
    action	XmbRIC.man	XmbResetIC.man
    action	XmbTEsc.man	XmbTextEscapement.man
    action	XmbTExt.man	XmbTextExtents.man
    action	XmbTPCEx.man	XmbTextPerCharExtents.man

    # src/util

    src_dir lib/X11/util
    dst_dir lib/X11/src/util

    action	makekeys.c
    action	mkks.sh

    #---------------------
    #
    #  NLS
    #
    #---------------------

    src_dir nls
    dst_dir lib/X11/nls

    action	compose.dir	compose.dir.pre
    action	locale.dir	locale.dir.pre
    action	locale.alias	locale.alias.pre

    # armscii-8
    dst_dir lib/X11/nls/armscii-8
    src_dir nls/XLC_LOCALE
    action		armscii-8		XLC_LOCALE.pre
    src_dir nls/XI18N_OBJS
    action		armscii-8		XI18N_OBJS
    src_dir nls/Compose
    action		armscii-8		Compose.pre

    # C
    dst_dir lib/X11/nls/C
    src_dir nls/XLC_LOCALE
    action		C			XLC_LOCALE.pre
    src_dir nls/XI18N_OBJS
    action		C			XI18N_OBJS
    #src_dir nls/Compose
    #action		C			Compose.pre

    # el_GR.UTF-8
    dst_dir lib/X11/nls/el_GR.UTF-8
    src_dir nls/Compose
    action	el_GR.UTF-8			Compose.pre

    # en_US.UTF-8
    dst_dir lib/X11/nls/en_US.UTF-8
    src_dir nls/XLC_LOCALE
    action		en_US.UTF-8		XLC_LOCALE.pre
    src_dir nls/XI18N_OBJS
    action		en_US.UTF-8		XI18N_OBJS
    src_dir nls/Compose
    action		en_US.UTF-8		Compose.pre

    # georgian-academy
    dst_dir lib/X11/nls/georgian-academy
    src_dir nls/XLC_LOCALE
    action		georgian-academy	XLC_LOCALE.pre
    src_dir nls/XI18N_OBJS
    action		georgian-academy	XI18N_OBJS
    src_dir nls/Compose
    action		georgian-academy	Compose.pre

    # georgian-ps
    dst_dir lib/X11/nls/georgian-ps
    src_dir nls/XLC_LOCALE
    action		georgian-ps		XLC_LOCALE.pre
    src_dir nls/XI18N_OBJS
    action		georgian-ps		XI18N_OBJS
    src_dir nls/Compose
    action		georgian-ps		Compose.pre

    # ibm-cp1133
    dst_dir lib/X11/nls/ibm-cp1133
    src_dir nls/XLC_LOCALE
    action		ibm-cp1133		XLC_LOCALE.pre
    src_dir nls/XI18N_OBJS
    action		ibm-cp1133		XI18N_OBJS
    src_dir nls/Compose
    action		ibm-cp1133		Compose.pre

    # iscii-dev
    dst_dir lib/X11/nls/iscii-dev
    src_dir nls/XLC_LOCALE
    action		iscii-dev		XLC_LOCALE.pre
    src_dir nls/XI18N_OBJS
    action		iscii-dev		XI18N_OBJS
    #src_dir nls/Compose
    #action		iscii-dev		Compose.pre

    # isiri-3342
    dst_dir lib/X11/nls/isiri-3342
    src_dir nls/XLC_LOCALE
    action		isiri-3342		XLC_LOCALE.pre
    src_dir nls/XI18N_OBJS
    action		isiri-3342		XI18N_OBJS
    #src_dir nls/Compose
    #action		isiri-3342		Compose.pre

    # iso8859-1
    dst_dir lib/X11/nls/iso8859-1
    src_dir nls/XLC_LOCALE
    action		iso8859-1		XLC_LOCALE.pre
    src_dir nls/XI18N_OBJS
    action		iso8859-1		XI18N_OBJS
    src_dir nls/Compose
    action		iso8859-1		Compose.pre

    # iso8859-10
    dst_dir lib/X11/nls/iso8859-10
    src_dir nls/XLC_LOCALE
    action		iso8859-10		XLC_LOCALE.pre
    src_dir nls/XI18N_OBJS
    action		iso8859-10		XI18N_OBJS
    src_dir nls/Compose
    action		iso8859-10		Compose.pre

    # iso8859-11
    dst_dir lib/X11/nls/iso8859-11
    src_dir nls/XLC_LOCALE
    action		iso8859-11		XLC_LOCALE.pre
    src_dir nls/XI18N_OBJS
    action		iso8859-11		XI18N_OBJS
    #src_dir nls/Compose
    #action		iso8859-11		Compose.pre

    # iso8859-13
    dst_dir lib/X11/nls/iso8859-13
    src_dir nls/XLC_LOCALE
    action		iso8859-13		XLC_LOCALE.pre
    src_dir nls/XI18N_OBJS
    action		iso8859-13		XI18N_OBJS
    src_dir nls/Compose
    action		iso8859-13		Compose.pre

    # iso8859-14
    dst_dir lib/X11/nls/iso8859-14
    src_dir nls/XLC_LOCALE
    action		iso8859-14		XLC_LOCALE.pre
    src_dir nls/XI18N_OBJS
    action		iso8859-14		XI18N_OBJS
    src_dir nls/Compose
    action		iso8859-14		Compose.pre

    # iso8859-15
    dst_dir lib/X11/nls/iso8859-15
    src_dir nls/XLC_LOCALE
    action		iso8859-15		XLC_LOCALE.pre
    src_dir nls/XI18N_OBJS
    action		iso8859-15		XI18N_OBJS
    src_dir nls/Compose
    action		iso8859-15		Compose.pre

    # iso8859-2
    dst_dir lib/X11/nls/iso8859-2
    src_dir nls/XLC_LOCALE
    action		iso8859-2		XLC_LOCALE.pre
    src_dir nls/XI18N_OBJS
    action		iso8859-2		XI18N_OBJS
    src_dir nls/Compose
    action		iso8859-2		Compose.pre

    # iso8859-3
    dst_dir lib/X11/nls/iso8859-3
    src_dir nls/XLC_LOCALE
    action		iso8859-3		XLC_LOCALE.pre
    src_dir nls/XI18N_OBJS
    action		iso8859-3		XI18N_OBJS
    src_dir nls/Compose
    action		iso8859-3		Compose.pre

    # iso8859-4
    dst_dir lib/X11/nls/iso8859-4
    src_dir nls/XLC_LOCALE
    action		iso8859-4		XLC_LOCALE.pre
    src_dir nls/XI18N_OBJS
    action		iso8859-4		XI18N_OBJS
    src_dir nls/Compose
    action		iso8859-4		Compose.pre

    # iso8859-5
    dst_dir lib/X11/nls/iso8859-5
    src_dir nls/XLC_LOCALE
    action		iso8859-5		XLC_LOCALE.pre
    src_dir nls/XI18N_OBJS
    action		iso8859-5		XI18N_OBJS
    src_dir nls/Compose
    action		iso8859-5		Compose.pre

    # iso8859-6
    dst_dir lib/X11/nls/iso8859-6
    src_dir nls/XLC_LOCALE
    action		iso8859-6		XLC_LOCALE.pre
    src_dir nls/XI18N_OBJS
    action		iso8859-6		XI18N_OBJS
    src_dir nls/Compose
    action		iso8859-6		Compose.pre

    # iso8859-7
    dst_dir lib/X11/nls/iso8859-7
    src_dir nls/XLC_LOCALE
    action		iso8859-7		XLC_LOCALE.pre
    src_dir nls/XI18N_OBJS
    action		iso8859-7		XI18N_OBJS
    src_dir nls/Compose
    action		iso8859-7		Compose.pre

    # iso8859-8
    dst_dir lib/X11/nls/iso8859-8
    src_dir nls/XLC_LOCALE
    action		iso8859-8		XLC_LOCALE.pre
    src_dir nls/XI18N_OBJS
    action		iso8859-8		XI18N_OBJS
    src_dir nls/Compose
    action		iso8859-8		Compose.pre

    # iso8859-9
    dst_dir lib/X11/nls/iso8859-9
    src_dir nls/XLC_LOCALE
    action		iso8859-9		XLC_LOCALE.pre
    src_dir nls/XI18N_OBJS
    action		iso8859-9		XI18N_OBJS
    src_dir nls/Compose
    action		iso8859-9		Compose.pre

    # iso8859-9e
    dst_dir lib/X11/nls/iso8859-9e
    src_dir nls/XLC_LOCALE
    action		iso8859-9e		XLC_LOCALE.pre
    src_dir nls/XI18N_OBJS
    action		iso8859-9e		XI18N_OBJS
    src_dir nls/Compose
    action		iso8859-9e		Compose.pre

    # ja
    dst_dir lib/X11/nls/ja
    src_dir nls/XLC_LOCALE
    action		ja			XLC_LOCALE.pre
    src_dir nls/XI18N_OBJS
    action		ja			XI18N_OBJS
    src_dir nls/Compose
    action		ja			Compose.pre

    # ja.JIS
    dst_dir lib/X11/nls/ja.JIS
    src_dir nls/XLC_LOCALE
    action		ja.JIS			XLC_LOCALE.pre
    src_dir nls/XI18N_OBJS
    action		ja.JIS			XI18N_OBJS
    src_dir nls/Compose
    action		ja.JIS			Compose.pre

    # ja_JP.UTF-8
    dst_dir lib/X11/nls/ja_JP.UTF-8
    src_dir nls/XLC_LOCALE
    action		ja_JP.UTF-8		XLC_LOCALE.pre
    src_dir nls/XI18N_OBJS
    action		ja_JP.UTF-8		XI18N_OBJS
    #src_dir nls/Compose
    #action		ja_JP.UTF-8		Compose.pre

    # ja.S90
    dst_dir lib/X11/nls/ja.S90
    src_dir nls/XLC_LOCALE
    action		ja.S90			XLC_LOCALE.pre
    src_dir nls/XI18N_OBJS
    action		ja.S90			XI18N_OBJS
    #src_dir nls/Compose
    #action		ja.S90			Compose.pre

    # ja.SJIS
    dst_dir lib/X11/nls/ja.SJIS
    src_dir nls/XLC_LOCALE
    action		ja.SJIS			XLC_LOCALE.pre
    src_dir nls/XI18N_OBJS
    action		ja.SJIS			XI18N_OBJS
    src_dir nls/Compose
    action		ja.SJIS			Compose.pre

    # ja.U90
    dst_dir lib/X11/nls/ja.U90
    src_dir nls/XLC_LOCALE
    action		ja.U90			XLC_LOCALE.pre
    src_dir nls/XI18N_OBJS
    action		ja.U90			XI18N_OBJS
    #src_dir nls/Compose
    #action		ja.U90			Compose.pre

    # ko
    dst_dir lib/X11/nls/ko
    src_dir nls/XLC_LOCALE
    action		ko			XLC_LOCALE.pre
    src_dir nls/XI18N_OBJS
    action		ko			XI18N_OBJS
    src_dir nls/Compose
    action		ko			Compose.pre

    # koi8-c
    dst_dir lib/X11/nls/koi8-c
    src_dir nls/XLC_LOCALE
    action		koi8-c			XLC_LOCALE.pre
    src_dir nls/XI18N_OBJS
    action		koi8-c			XI18N_OBJS
    src_dir nls/Compose
    action		koi8-c			Compose.pre

    # koi8-r
    dst_dir lib/X11/nls/koi8-r
    src_dir nls/XLC_LOCALE
    action		koi8-r			XLC_LOCALE.pre
    src_dir nls/XI18N_OBJS
    action		koi8-r			XI18N_OBJS
    src_dir nls/Compose
    action		koi8-r			Compose.pre

    # koi8-u
    dst_dir lib/X11/nls/koi8-u
    src_dir nls/XLC_LOCALE
    action		koi8-u			XLC_LOCALE.pre
    src_dir nls/XI18N_OBJS
    action		koi8-u			XI18N_OBJS
    src_dir nls/Compose
    action		koi8-u			Compose.pre

    # ko_KR.UTF-8
    dst_dir lib/X11/nls/ko_KR.UTF-8
    src_dir nls/XLC_LOCALE
    action		ko_KR.UTF-8		XLC_LOCALE.pre
    src_dir nls/XI18N_OBJS
    action		ko_KR.UTF-8		XI18N_OBJS
    #src_dir nls/Compose
    #action		ko_KR.UTF-8		Compose.pre

    # microsoft-cp1251
    dst_dir lib/X11/nls/microsoft-cp1251
    src_dir nls/XLC_LOCALE
    action		microsoft-cp1251	XLC_LOCALE.pre
    src_dir nls/XI18N_OBJS
    action		microsoft-cp1251	XI18N_OBJS
    #src_dir nls/Compose
    #action		microsoft-cp1251	Compose.pre

    # microsoft-cp1255
    dst_dir lib/X11/nls/microsoft-cp1255
    src_dir nls/XLC_LOCALE
    action		microsoft-cp1255	XLC_LOCALE.pre
    src_dir nls/XI18N_OBJS
    action		microsoft-cp1255	XI18N_OBJS
    #src_dir nls/Compose
    #action		microsoft-cp1255	Compose.pre

    # microsoft-cp1256
    dst_dir lib/X11/nls/microsoft-cp1256
    src_dir nls/XLC_LOCALE
    action		microsoft-cp1256	XLC_LOCALE.pre
    src_dir nls/XI18N_OBJS
    action		microsoft-cp1256	XI18N_OBJS
    #src_dir nls/Compose
    #action		microsoft-cp1256	Compose.pre

    # mulelao-1
    dst_dir lib/X11/nls/mulelao-1
    src_dir nls/XLC_LOCALE
    action		mulelao-1		XLC_LOCALE.pre
    src_dir nls/XI18N_OBJS
    action		mulelao-1		XI18N_OBJS
    src_dir nls/Compose
    action		mulelao-1		Compose.pre

    # nokhchi-1
    dst_dir lib/X11/nls/nokhchi-1
    src_dir nls/XLC_LOCALE
    action		nokhchi-1		XLC_LOCALE.pre
    src_dir nls/XI18N_OBJS
    action		nokhchi-1		XI18N_OBJS
    #src_dir nls/Compose
    #action		nokhchi-1		Compose.pre

    # pt_BR.UTF-8
    dst_dir lib/X11/nls/pt_BR.UTF-8
    src_dir nls/XLC_LOCALE
    action		pt_BR.UTF-8		XLC_LOCALE.pre
    src_dir nls/XI18N_OBJS
    action		pt_BR.UTF-8		XI18N_OBJS
    src_dir nls/Compose
    action		pt_BR.UTF-8		Compose.pre

    # tatar-cyr
    dst_dir lib/X11/nls/tatar-cyr
    src_dir nls/XLC_LOCALE
    action		tatar-cyr		XLC_LOCALE.pre
    src_dir nls/XI18N_OBJS
    action		tatar-cyr		XI18N_OBJS
    #src_dir nls/Compose
    #action		tatar-cyr		Compose.pre

    # th_TH
    dst_dir lib/X11/nls/th_TH
    src_dir nls/XLC_LOCALE
    action		th_TH			XLC_LOCALE.pre
    src_dir nls/XI18N_OBJS
    action		th_TH			XI18N_OBJS
    #src_dir nls/Compose
    #action		th_TH			Compose.pre

    # th_TH.UTF-8
    dst_dir lib/X11/nls/th_TH.UTF-8
    src_dir nls/XLC_LOCALE
    action		th_TH.UTF-8		XLC_LOCALE.pre
    src_dir nls/XI18N_OBJS
    action		th_TH.UTF-8		XI18N_OBJS
    #src_dir nls/Compose
    #action		th_TH.UTF-8		Compose.pre

    # tscii-0
    dst_dir lib/X11/nls/tscii-0
    src_dir nls/XLC_LOCALE
    action		tscii-0			XLC_LOCALE.pre
    src_dir nls/XI18N_OBJS
    action		tscii-0			XI18N_OBJS
    #src_dir nls/Compose
    #action		tscii-0			Compose.pre

    # vi_VN.tcvn
    dst_dir lib/X11/nls/vi_VN.tcvn
    src_dir nls/XLC_LOCALE
    action		vi_VN.tcvn		XLC_LOCALE.pre
    src_dir nls/XI18N_OBJS
    action		vi_VN.tcvn		XI18N_OBJS
    src_dir nls/Compose
    action		vi_VN.tcvn		Compose.pre

    # vi_VN.viscii
    dst_dir lib/X11/nls/vi_VN.viscii
    src_dir nls/XLC_LOCALE
    action		vi_VN.viscii		XLC_LOCALE.pre
    src_dir nls/XI18N_OBJS
    action		vi_VN.viscii		XI18N_OBJS
    src_dir nls/Compose
    action		vi_VN.viscii		Compose.pre

    # zh_CN
    dst_dir lib/X11/nls/zh_CN
    src_dir nls/XLC_LOCALE
    action		zh_CN			XLC_LOCALE.pre
    src_dir nls/XI18N_OBJS
    action		zh_CN			XI18N_OBJS
    # src_dir nls/Compose
    # action		zh_CN			Compose.pre

    # zh_CN.gb18030
    dst_dir lib/X11/nls/zh_CN.gb18030
    src_dir nls/XLC_LOCALE
    action		zh_CN.gb18030		XLC_LOCALE.pre
    src_dir nls/XI18N_OBJS
    action		zh_CN.gb18030		XI18N_OBJS
    src_dir nls/Compose
    action		zh_CN.gb18030		Compose.pre

    # zh_CN.gbk
    dst_dir lib/X11/nls/zh_CN.gbk
    src_dir nls/XLC_LOCALE
    action		zh_CN.gbk		XLC_LOCALE.pre
    src_dir nls/XI18N_OBJS
    action		zh_CN.gbk		XI18N_OBJS
    src_dir nls/Compose
    action		zh_CN.gbk		Compose.pre

    # zh_CN.UTF-8
    dst_dir lib/X11/nls/zh_CN.UTF-8
    src_dir nls/XLC_LOCALE
    action		zh_CN.UTF-8		XLC_LOCALE.pre
    src_dir nls/XI18N_OBJS
    action		zh_CN.UTF-8		XI18N_OBJS
    #src_dir nls/Compose
    #action		zh_CN.UTF-8		Compose.pre

    # zh_HK.big5
    dst_dir lib/X11/nls/zh_HK.big5
    src_dir nls/XLC_LOCALE
    action		zh_HK.big5		XLC_LOCALE.pre
    src_dir nls/XI18N_OBJS
    action		zh_HK.big5		XI18N_OBJS
    src_dir nls/Compose
    action		zh_HK.big5		Compose.pre

    # zh_HK.big5hkscs
    dst_dir lib/X11/nls/zh_HK.big5hkscs
    src_dir nls/XLC_LOCALE
    action		zh_HK.big5hkscs		XLC_LOCALE.pre
    src_dir nls/XI18N_OBJS
    action		zh_HK.big5hkscs		XI18N_OBJS
    src_dir nls/Compose
    action		zh_HK.big5hkscs		Compose.pre

    # zh_HK.UTF-8
    dst_dir lib/X11/nls/zh_HK.UTF-8
    src_dir nls/XLC_LOCALE
    action		zh_HK.UTF-8		XLC_LOCALE.pre
    src_dir nls/XI18N_OBJS
    action		zh_HK.UTF-8		XI18N_OBJS
    #src_dir nls/Compose
    #action		zh_HK.UTF-8		Compose.pre

    # zh_TW
    dst_dir lib/X11/nls/zh_TW
    src_dir nls/XLC_LOCALE
    action		zh_TW			XLC_LOCALE.pre
    src_dir nls/XI18N_OBJS
    action		zh_TW			XI18N_OBJS
    src_dir nls/Compose
    action		zh_TW			Compose.pre

    # zh_TW.big5
    dst_dir lib/X11/nls/zh_TW.big5
    src_dir nls/XLC_LOCALE
    action		zh_TW.big5		XLC_LOCALE.pre
    src_dir nls/XI18N_OBJS
    action		zh_TW.big5		XI18N_OBJS
    src_dir nls/Compose
    action		zh_TW.big5		Compose.pre

    # zh_TW.UTF-8
    dst_dir lib/X11/nls/zh_TW.UTF-8
    src_dir nls/XLC_LOCALE
    action		zh_TW.UTF-8		XLC_LOCALE.pre
    src_dir nls/XI18N_OBJS
    action		zh_TW.UTF-8		XI18N_OBJS
    #src_dir nls/Compose
    #action		zh_TW.UTF-8		Compose.pre


    # lcuniconv

    src_dir lib/X11/lcUniConv
    dst_dir lib/X11/src/xlibi18n/lcUniConv

    action	README

    action	8bit_tab_to_h.c
    action	armscii_8.h
    action	ascii.h
    action	big5_emacs.h
    action	big5.h
    action	cjk_tab_to_h.c
    action	COPYRIGHT
    action	cp1133.h
    action	cp1251.h
    action	cp1255.h
    action	cp1256.h
    action	gb2312.h
    action	georgian_academy.h
    action	georgian_ps.h
    action	iso8859_10.h
    action	iso8859_11.h
    action	iso8859_13.h
    action	iso8859_14.h
    action	iso8859_15.h
    action	iso8859_16.h
    action	iso8859_1.h
    action	iso8859_2.h
    action	iso8859_3.h
    action	iso8859_4.h
    action	iso8859_5.h
    action	iso8859_6.h
    action	iso8859_7.h
    action	iso8859_8.h
    action	iso8859_9e.h
    action	iso8859_9.h
    action	jisx0201.h
    action	jisx0208.h
    action	jisx0212.h
    action	koi8_c.h
    action	koi8_r.h
    action	koi8_u.h
    action	ksc5601.h
    action	mulelao.h
    action	tatar_cyr.h
    action	tcvn.h
    action	tis620.h
    action	ucs2be.h
    action	utf8.h
    action	viscii.h
}

symlink_lib_ice() {
    src_dir lib/ICE
    dst_dir lib/ICE/src
    
    action	accept.c
    action	authutil.c
    action	connect.c
    action	error.c
    action	getauth.c
    action	iceauth.c
    action	listen.c
    action	listenwk.c
    action	locking.c
    action	misc.c
    action	ping.c
    action	process.c
    action	protosetup.c
    action	register.c
    action	replywait.c
    action	setauth.c
    action	shutdown.c
    action	watch.c

    action	globals.h
    action	ICElibint.h

    dst_dir lib/ICE/include/X11/ICE

    action	ICEconn.h
    action	ICE.h
    action	ICElib.h
    action	ICEmsg.h
    action	ICEproto.h
    action	ICEutil.h
}

symlink_lib_sm() {
    src_dir lib/SM
    dst_dir lib/SM/src

    action	sm_auth.c
    action	sm_client.c
    action	sm_error.c
    action	sm_genid.c
    action	sm_manager.c
    action	sm_misc.c
    action	sm_process.c

    action	globals.h
    action	SMlibint.h

    dst_dir lib/SM/include/X11/SM
    
    action	SM.h
    action	SMlib.h
    action	SMproto.h
}

symlink_lib_xt() {
    src_dir lib/Xt
    
    # Public headers

    dst_dir lib/Xt/include/X11

    action	Composite.h
    action	CompositeP.h
    action	Constraint.h
    action	ConstrainP.h
    action	Core.h
    action	CoreP.h
    action	Intrinsic.h
    action	IntrinsicP.h
    action	Object.h
    action	ObjectP.h
    action	RectObj.h
    action	RectObjP.h
    action	ShellP.h
    action	Vendor.h
    action	VendorP.h

    # Private headers - they are used by XTrap

    dst_dir lib/Xt/include/X11

    action	CallbackI.h
    action	ConvertI.h
    action	CreateI.h
    action	EventI.h
    action	HookObjI.h
    action	InitialI.h
    action	IntrinsicI.h
    action	PassivGraI.h
    action	ResConfigP.h
    action	ResourceI.h
    action	SelectionI.h
    action	ShellI.h
    action	ThreadsI.h
    action	TranslateI.h
    action	VarargsI.h
    action	Xtos.h

    # Source

    dst_dir lib/Xt/src

    action	ActionHook.c
    action	Alloc.c
    action	ArgList.c
    action	Callback.c
    action	ClickTime.c
    action	Composite.c
    action	Constraint.c
    action	Convert.c
    action	Converters.c
    action	Core.c
    action	Create.c
    action	Destroy.c
    action	Display.c
    action	Error.c
    action	Event.c
    action	EventUtil.c
    action	Functions.c
    action	GCManager.c
    action	Geometry.c
    action	GetActKey.c
    action	GetResList.c
    action	GetValues.c
    action	HookObj.c
    action	Hooks.c
    action	Initialize.c
    action	Intrinsic.c
    action	Keyboard.c
    action	Manage.c
    action	NextEvent.c
    action	Object.c
    action	PassivGrab.c
    action	Pointer.c
    action	Popup.c
    action	PopupCB.c
    action	RectObj.c
    action	ResConfig.c
    action	Resources.c
    action	Selection.c
    action	SetSens.c
    action	SetValues.c
    action	SetWMCW.c
    action	sharedlib.c
    action	Shell.c
    action	Threads.c
    action	TMaction.c
    action	TMgrab.c
    action	TMkey.c
    action	TMparse.c
    action	TMprint.c
    action	TMstate.c
    action	Varargs.c
    action	VarCreate.c
    action	VarGet.c
    action	Vendor.c

    # utils

    src_dir lib/Xt/util
    dst_dir lib/Xt/util

    action	Shell.ht
    action	StrDefs.ct
    action	StrDefs.ht
    action	string.list

    src_dir config/util

    action	makestrs.c

    # man pages

    src_dir doc/man/Xt
    dst_dir lib/Xt/man

    action	XtAddCbk.man	XtAddCallback.man
    action	XtAddEHand.man	XtAddEventHandler.man
    action	XtAddETReg.man	XtAddExposureToRegion.man
    action	XtAddGrab.man	XtAddGrab.man
    action	XtAppAAct.man	XtAppAddActions.man
    action	XtAddAct.man	XtAddActions.man
    action	XtAppAC.man	XtAppAddConverter.man
    action	XtAppAI.man	XtAppAddInput.man
    action	XtAppATO.man	XtAppAddTimeOut.man
    action	XtAppAWP.man	XtAppAddWorkProc.man
    action	XtAppCSh.man	XtAppCreateShell.man
    action	XtAppE.man	XtAppError.man
    action	XtAppEM.man	XtAppErrorMsg.man
    action	XtAppGEDB.man	XtAppGetErrorDatabase.man
    action	XtAppGSTO.man	XtAppGetSelectionTimeout.man
    action	XtAppNEv.man	XtAppNextEvent.man
    action	XtNextEv.man	XtNextEvent.man
    action	XtBEMask.man	XtBuildEventMask.man
    action	XtCallAFoc.man	XtCallAcceptFocus.man
    action	XtCallCbks.man	XtCallCallbacks.man
    action	XtClass.man	XtClass.man
    action	XtConfWid.man	XtConfigureWidget.man
    action	XtConvert.man	XtConvert.man
    action	XtConvSt.man	XtConvertAndStore.man
    action	XtCreACon.man	XtCreateApplicationContext.man
    action	XtCrePSh.man	XtCreatePopupShell.man
    action	XtCreWid.man	XtCreateWidget.man
    action	XtCreWin.man	XtCreateWindow.man
    action	XtDisplay.man	XtDisplay.man
    action	XtDisplayI.man	XtDisplayInitialize.man
    action	XtGetGC.man	XtGetGC.man
    action	XtGetRList.man	XtGetResourceList.man
    action	XtGetSVal.man	XtGetSelectionValue.man
    action	XtGetSres.man	XtGetSubresources.man
    action	XtGetAres.man	XtGetApplicationResources.man
    action	XtMakGReq.man	XtMakeGeometryRequest.man
    action	XtMalloc.man	XtMalloc.man
    action	XtManChild.man	XtManageChildren.man
    action	XtMapWid.man	XtMapWidget.man
    action	XtNameTWid.man	XtNameToWidget.man
    action	XtOffset.man	XtOffset.man
    action	XtOwnSel.man	XtOwnSelection.man
    action	XtParATab.man	XtParseAcceleratorTable.man
    action	XtParTTab.man	XtParseTranslationTable.man
    action	XtPopdown.man	XtPopdown.man
    action	XtPopup.man	XtPopup.man
    action	XtQueryGeo.man	XtQueryGeometry.man
    action	XtRealize.man	XtRealizeWidget.man
    action	XtSetArg.man	XtSetArg.man
    action	XtSetKFoc.man	XtSetKeyboardFocus.man
    action	XtSetKTr.man	XtSetKeyTranslator.man
    action	XtSetSens.man	XtSetSensitive.man
    action	XtSetVal.man	XtSetValues.man
    action	XtStrCW.man	XtStringConversionWarning.man
    action	XtDStrCW.man	XtDisplayStringConversionWarning.man
    action	XtTransC.man	XtTranslateCoords.man
    action	XtKeysym.man	XtGetKeysymTable.man
    action	XtAppSTC.man	XtAppSetTypeConverter.man
    action	XtActHook.man	XtAppAddActionHook.man
    action	XtGetActL.man	XtGetActionList.man
    action	XtCallActP.man	XtCallActionProc.man
    action	XtRegGA.man	XtRegisterGrabAction.man
    action	XtClickT.man	XtSetMultiClickTime.man
    action	XtGetActK.man	XtGetActionKeysym.man
    action	XtExtEvDis.man	XtInsertEventTypeHandler.man
    action	XtGetKFoc.man	XtGetKeyboardFocusWidget.man
    action	XtLastProc.man	XtLastEventProcessed.man
    action	XtAppASig.man	XtAppAddSignal.man
    action	XtAddIn.man	XtAddInput.man
    action	XtBlockH.man	XtAppAddBlockHook.man
    action	XtGetClExt.man	XtGetClassExtension.man
    action	XtVaCrArgL.man	XtVaCreateArgsList.man
    action	XtParent.man	XtParent.man
    action	XtName.man	XtName.man
    action	XtCreASh.man	XtCreateApplicationShell.man
    action	XtSetLangP.man	XtSetLanguageProc.man
    action	XtAppInit.man	XtAppInitialize.man
    action	XtInit.man	XtInitialize.man
    action	XtAppSetFR.man	XtAppSetFallbackResources.man
    action	XtInitWC.man	XtInitializeWidgetClass.man
    action	XtDisACon.man	XtDisplayToApplicationContext.man
    action	XtSession.man	XtSessionGetToken.man
    action	XtErrM.man	XtErrorMsg.man
    action	XtErr.man	XtError.man
    action	XtGEDB.man	XtGetErrorDatabase.man
    action	XtAllocGC.man	XtAllocateGC.man
    action	XtAppRCR.man	XtAppReleaseCacheRefs.man
    action	XtSetWMC.man	XtSetWMColormapWindows.man
    action	XtFindF.man	XtFindFile.man
    action	XtResPath.man	XtResolvePathname.man
    action	XtGetSValI.man	XtGetSelectionValueIncremental.man
    action	XtGetSTO.man	XtGetSelectionTimeout.man
    action	XtGetSR.man	XtGetSelectionRequest.man
    action	XtSetSP.man	XtSetSelectionParameters.man
    action	XtGetSP.man	XtGetSelectionParameters.man
    action	XtCreateSR.man	XtCreateSelectionRequest.man
    action	XtResPA.man	XtReservePropertyAtom.man
    action	XtGrabKey.man	XtGrabKey.man
    action	XtGetANC.man	XtGetApplicationNameAndClass.man
    action	XtRegDraw.man	XtRegisterDrawable.man
    action	XtHookOD.man	XtHooksOfDisplay.man
    action	XtGetDisp.man	XtGetDisplays.man
    action	XtThreadI.man	XtToolkitThreadInitialize.man
    action	XtAppSEF.man	XtAppSetExitFlag.man
    action	XtAppLock.man	XtAppLock.man
    action	XtProcLock.man	XtProcessLock.man
    action	XtOpenApp.man	XtOpenApplication.man
}

symlink_lib_xmu() {
    src_dir lib/Xmu
    dst_dir lib/Xmu/include/X11/Xmu

    action	Atoms.h
    action	CharSet.h
    action	CloseHook.h
    action	Converters.h
    action	CurUtil.h
    action	CvtCache.h
    action	DisplayQue.h
    action	Drawing.h
    action	Editres.h
    action	EditresP.h
    action	Error.h
    action	ExtAgent.h
    action	Initer.h
    action	Lookup.h
    action	Misc.h
    action	StdCmap.h
    action	StdSel.h
    action	SysUtil.h
    action	WhitePoint.h
    action	WidgetNode.h
    action	WinUtil.h
    action	Xct.h
    action	Xmu.h
    
    dst_dir lib/Xmu
    action	README

    dst_dir lib/Xmu/src

    action	AllCmap.c
    action	Atoms.c
    action	ClientWin.c
    action	Clip.c
    action	CloseHook.c
    action	CmapAlloc.c
    action	CrCmap.c
    action	CrPixFBit.c
    action	CursorName.c
    action	CvtCache.c
    action	CvtStdSel.c
    action	DefErrMsg.c
    action	DelCmap.c
    action	DisplayQue.c
    action	Distinct.c
    action	DrawLogo.c
    action	DrRndRect.c
    action	EditresCom.c
    action	ExtAgent.c
    action	FToCback.c
    action	GetHost.c
    action	GrayPixmap.c
    action	Initer.c
    action	LocBitmap.c
    action	Lookup.c
    action	LookupCmap.c
    action	Lower.c
    action	RdBitF.c
    action	ScrOfWin.c
    action	ShapeWidg.c
    action	sharedlib.c
    action	StdCmap.c
    action	StrToBmap.c
    action	StrToBS.c
    action	StrToCurs.c
    action	StrToGrav.c
    action	StrToJust.c
    action	StrToLong.c
    action	StrToOrnt.c
    action	StrToShap.c
    action	StrToWidg.c
    action	UpdMapHint.c
    action	VisCmap.c
    action	WidgetNode.c
    action	Xct.c
}

symlink_lib_xp() {
    src_dir lib/Xp
    dst_dir lib/Xp/src

    action	XpAttr.c
    action	XpContext.c
    action	XpDoc.c
    action	XpExtUtil.c
    action	XpExtVer.c
    action	XpGetData.c
    action	XpImageRes.c
    action	XpInput.c
    action	XpJob.c
    action	XpLocale.c
    action	XpNotifyPdm.c
    action	XpPage.c
    action	XpPageDim.c
    action	XpPrinter.c
    action	XpPutData.c
    action	XpScreens.c

    action	XpExtUtil.h

    # man pages
    src_dir doc/man/Xp
    dst_dir lib/Xp/man

    action	libXp.man			libXp.3
    action	XpCancelDoc.man			XpCancelDoc.3
    action	XpCancelJob.man			XpCancelJob.3
    action	XpCancelPage.man		XpCancelPage.3
    action	XpCreateContext.man		XpCreateContext.3
    action	XpDestroyContext.man		XpDestroyContext.3
    action	XpEndDoc.man			XpEndDoc.3
    action	XpEndJob.man			XpEndJob.3
    action	XpEndPage.man			XpEndPage.3
    action	XpFreePrinterList.man		XpFreePrinterList.3
    action	XpGetAttributes.man		XpGetAttributes.3
    action	XpGetContext.man		XpGetContext.3
    action	XpGetDocumentData.man		XpGetDocumentData.3
    action	XpGetImageResolution.man	XpGetImageResolution.3
    action	XpGetLocaleHinter.man		XpGetLocaleHinter.3
    action	XpGetOneAttribute.man		XpGetOneAttribute.3
    action	XpGetPageDimensions.man		XpGetPageDimensions.3
    action	XpGetPdmStartParams.man		XpGetPdmStartParams.3
    action	XpGetPrinterList.man		XpGetPrinterList.3
    action	XpGetScreenOfContext.man	XpGetScreenOfContext.3
    action	XpInputSelected.man		XpInputSelected.3
    action	XpPutDocumentData.man		XpPutDocumentData.3
    action	XpQueryExtension.man		XpQueryExtension.3
    action	XpQueryScreens.man		XpQueryScreens.3
    action	XpQueryVersion.man		XpQueryVersion.3
    action	XpRehashPrinterList.man		XpRehashPrinterList.3
    action	XpSelectInput.man		XpSelectInput.3
    action	XpSetAttributes.man		XpSetAttributes.3
    action	XpSetContext.man		XpSetContext.3
    action	XpSetImageResolution.man	XpSetImageResolution.3
    action	XpSetLocaleHinter.man		XpSetLocaleHinter.3
    action	XpStartDoc.man			XpStartDoc.3
    action	XpStartJob.man			XpStartJob.3
    action	XpStartPage.man			XpStartPage.3
}

symlink_lib_xpm() {
    src_dir extras/Xpm
    dst_dir lib/Xpm

    action	CHANGES
    action	COPYRIGHT
    action	FAQ.html
    action	FILES
    action	README.AMIGA
    action	README.html
    action	README.MSW

    src_dir extras/Xpm/doc

    action	xpm.PS.gz

    src_dir extras/Xpm/lib

    #
    # Library 
    #

    # Public header
    dst_dir lib/Xpm/include/X11

    action	xpm.h

    # Source 

    dst_dir lib/Xpm/src

    # headers
    action	amigax.h
    action	rgbtab.h
    action	simx.h
    action	XpmI.h

    action	amigax.c
    action	Attrib.c
    action	CrBufFrI.c
    action	CrBufFrP.c
    action	CrDatFrI.c
    action	CrDatFrP.c
    action	create.c
    action	CrIFrBuf.c
    action	CrIFrDat.c
    action	CrIFrP.c
    action	CrPFrBuf.c
    action	CrPFrDat.c
    action	CrPFrI.c
    action	data.c
    action	hashtab.c
    action	Image.c
    action	Info.c
    action	misc.c
    action	parse.c
    action	RdFToBuf.c
    action	RdFToDat.c
    action	RdFToI.c
    action	RdFToP.c
    action	rgb.c
    action	scan.c
    action	simx.c
    action	WrFFrBuf.c
    action	WrFFrDat.c
    action	WrFFrI.c
    action	WrFFrP.c

    # 
    # Apps
    #
    src_dir extras/Xpm/cxpm
    dst_dir lib/Xpm/cxpm

    action	cxpm.c
    action	cxpm.man	cxpm.1
    
    src_dir extras/Xpm/sxpm
    dst_dir lib/Xpm/sxpm

    action	sxpm.c
    action	sxpm.man	sxpm.1
    action	plaid_ext.xpm
    action	plaid_mask.xpm
    action	plaid.xpm
}

symlink_lib_xrender() {
    src_dir lib/Xrender
    dst_dir lib/Xrender/src

    action	AddTrap.c
    action	Color.c
    action	Composite.c
    action	Cursor.c
    action	FillRect.c
    action	FillRects.c
    action	Filter.c
    action	Glyph.c
    action	Picture.c
    action	Poly.c
    action	Trap.c
    action	Tri.c
    action	Xrender.c

    action	Xrenderint.h

    dst_dir lib/Xrender/include/X11/extensions

    action	Xrender.h
}

symlink_lib_xi() {
    src_dir lib/Xi
    dst_dir lib/Xi/src

    action	XIint.h
    action	XAllowDv.c
    action	XChgDCtl.c
    action	XChgFCtl.c
    action	XChgKMap.c
    action	XChgKbd.c
    action	XChgPnt.c
    action	XChgProp.c
    action	XCloseDev.c
    action	XDevBell.c
    action	XExtInt.c
    action	XExtToWire.c
    action	XFreeLst.c
    action	XGMotion.c
    action	XGetBMap.c
    action	XGetDCtl.c
    action	XGetFCtl.c
    action	XGetKMap.c
    action	XGetMMap.c
    action	XGetProp.c
    action	XGetVers.c
    action	XGrDvBut.c
    action	XGrDvKey.c
    action	XGrabDev.c
    action	XGtFocus.c
    action	XGtSelect.c
    action	XListDev.c
    action	XOpenDev.c
    action	XQueryDv.c
    action	XSelect.c
    action	XSetBMap.c
    action	XSetDVal.c
    action	XSetMMap.c
    action	XSetMode.c
    action	XSndExEv.c
    action	XStFocus.c
    action	XUngrDev.c
    action	XUngrDvB.c
    action	XUngrDvK.c

    src_dir doc/man/Xi
    dst_dir lib/Xi/man

    action	XAllDvEv.man	XAllowDeviceEvents.man
    action	XChDCtl.man	XGetDeviceControl.man
    action	XChFCtl.man	XGetFeedbackControl.man
    action	XChKMap.man	XGetDeviceKeyMapping.man
    action	XChMMap.man	XGetDeviceModifierMapping.man
    action	XChProp.man	XChangeDeviceDontPropagateList.man
    action	XChgKbd.man	XChangeKeyboardDevice.man
    action	XChgPtr.man	XChangePointerDevice.man
    action	XDevBell.man	XDeviceBell.man
    action	XGetDvMo.man	XGetDeviceMotionEvents.man
    action	XGetExtV.man	XGetExtensionVersion.man
    action	XGrDvBut.man	XGrabDeviceButton.man
    action	XGrDvKey.man	XGrabDeviceKey.man
    action	XGrabDev.man	XGrabDevice.man
    action	XListDev.man	XListInputDevices.man
    action	XOpenDev.man	XOpenDevice.man
    action	XQueryDv.man	XQueryDeviceState.man
    action	XSExEvnt.man	XSendExtensionEvent.man
    action	XSeBMap.man	XSetDeviceButtonMapping.man
    action	XSeDvFoc.man	XSetDeviceFocus.man
    action	XSelExtEv.man	XSelectExtensionEvent.man
    action	XSetDVal.man	XSetDeviceValuators.man
    action	XSetMode.man	XSetDeviceMode.man

}

symlink_lib_xfont() {
    src_dir lib/font/FreeType
    dst_dir lib/Xfont/src/FreeType

    action      ft.h
    action      ftenc.c
    action      ftfuncs.c
    action      ftfuncs.h
    action      ftsystem.c
    action      fttools.c
    action      xttcap.c
    action      xttcap.h

    src_dir lib/font/bitmap
    dst_dir lib/Xfont/src/bitmap

    action      bdfread.c
    action      bdfutils.c
    action      bitmap.c
    action      bitmapfunc.c
    action      bitmaputil.c
    action      bitscale.c
    action      fontink.c
    action      pcfread.c
    action      pcfwrite.c
    action      snfread.c
    action      snfstr.h

    src_dir lib/font/bitmap
    dst_dir lib/Xfont/include/X11/fonts

    action      bdfint.h
    action      pcf.h

    src_dir lib/font/builtins
    dst_dir lib/Xfont/src/builtins

    action      buildfont
    action      builtin.h
    action      dir.c
    action      file.c
    action      fonts.c
    action      fpe.c
    action      render.c

    src_dir lib/font/fc
    dst_dir lib/Xfont/src/fc

    action      fsconvert.c
    action      fserve.c
    action      fserve.h
    action      fservestr.h
    action      fsio.c
    action      fsio.h
    action      fslibos.h

    src_dir lib/font/fontcache
    dst_dir lib/Xfont/src/fontcache

    action      fcqueue.h
    action      fontcache.c
    action      fontcache.h

    src_dir lib/font/fontfile
    dst_dir lib/Xfont/src/fontfile

    action      bitsource.c
    action      bufio.c
    action      decompress.c
    action      defaults.c
    action      dirfile.c
    action      ffcheck.c
    action      fileio.c
    action      filewr.c
    action      fontdir.c
    action      fontencc.c
    action      fontfile.c
    action      fontscale.c
    action      gunzip.c
    action      printerfont.c
    action      register.c
    action      renderers.c

    src_dir lib/font/include
    dst_dir lib/Xfont/include/X11/fonts

    action      bitmap.h
    action      bufio.h
    action      fntfil.h
    action      fntfilio.h
    action      fntfilst.h
    action      fontencc.h
    action      fontmisc.h
    action      fontmod.h
    action      fontshow.h
    action      fontutil.h
    action      fontxlfd.h

    src_dir lib/font/stubs
    dst_dir lib/Xfont/src/stubs

    action      cauthgen.c
    action      csignal.c
    action      delfntcid.c
    action      errorf.c
    action      fatalerror.c
    action      findoldfnt.c
    action      getcres.c
    action      getdefptsize.c
    action      getnewfntcid.c
    action      gettime.c
    action      initfshdl.c
    action      regfpefunc.c
    action      rmfshdl.c
    action      servclient.c
    action      setfntauth.c
    action      stfntcfnt.c
    action      stubs.h
    action      xpstubs.c

    src_dir lib/font/util
    dst_dir lib/Xfont/src/util

    action      atom.c
    action      fontaccel.c
    action      fontnames.c
    action      fontutil.c
    action      fontxlfd.c
    action      format.c
    action      miscutil.c
    action      patcache.c
    action      private.c
    action      utilbitmap.c

    src_dir lib/font/Speedo
    dst_dir lib/Xfont/src/Speedo

    action	adobe-iso.h
    action	bics-iso.h
    action	bics-unicode.c
    action	bics-unicode.h
    action	do_char.c
    action	do_trns.c
    action	keys.h
    action	out_bl2d.c
    action	out_blk.c
    action	out_outl.c
    action	out_scrn.c
    action	out_util.c
    action	reset.c
    action	set_spcs.c
    action	set_trns.c
    action	spdo_prv.h
    action	speedo.h
    action	spencode.c
    action	sperr.c
    action	spfile.c
    action	spfont.c
    action	spfuncs.c
    action	spglyph.c
    action	spinfo.c
    action	spint.h
    action	useropt.h

    src_dir lib/font/Type1
    dst_dir lib/Xfont/src/Type1

    action	afm.c
    action	AFM.h
    action	arith.c
    action	arith.h
    action	blues.h
    action	cidchar.c
    action	cluts.h
    action	curves.c
    action	curves.h
    action	digit.h
    action	fontfcn.c
    action	fontfcn.h
    action	fonts.h
    action	hdigit.h
    action	hints.c
    action	hints.h
    action	lines.c
    action	lines.h
    action	objects.c
    action	objects.h
    action	paths.c
    action	paths.h
    action	pictures.h
    action	range.h
    action	regions.c
    action	regions.h
    action	scanfont.c
    action	spaces.c
    action	spaces.h
    action	strokes.h
    action	t1funcs.c
    action	t1hdigit.h
    action	t1imager.h
    action	t1info.c
    action	t1intf.h
    action	t1io.c
    action	t1malloc.c
    action	t1snap.c
    action	t1stdio.h
    action	t1stub.c
    action	t1unicode.c
    action	t1unicode.h
    action	token.c
    action	token.h
    action	tokst.h
    action	trig.h
    action	type1.c
    action	util.c
    action	util.h
}

symlink_lib_fontenc() {
    src_dir lib/font/fontfile
    dst_dir lib/fontenc/src

    action	fontenc.c
    action	encparse.c
    action	fontencI.h
    
    src_dir lib/font/include
    dst_dir lib/fontenc/include/X11/fonts

    action	fontenc.h
}

symlink_lib_xaw() {
    src_dir lib/Xaw

    dst_dir lib/Xaw/old-doc

    action      CHANGES
    action      Changelog
    
    dst_dir lib/Xaw/src

    action	Actions.c
    action	AllWidgets.c
    action	AsciiSink.c
    action	AsciiSrc.c
    action	AsciiText.c
    action	Box.c
    action	Command.c
    action	Converters.c
    action	Dialog.c
    action	DisplayList.c
    action	Form.c
    action	Grip.c
    action	Label.c
    action	List.c
    action	MenuButton.c
    action	MultiSink.c
    action	MultiSrc.c
    action	OS.c
    action	Paned.c
    action	Panner.c
    action	Pixmap.c
    action	Porthole.c
    action	PrintShell.c
    action	Repeater.c
    action	Scrollbar.c
    action	sharedlib.c
    action	Simple.c
    action	SimpleMenu.c
    action	SmeBSB.c
    action	Sme.c
    action	SmeLine.c
    action	StripChart.c
    action	TextAction.c
    action	Text.c
    action	TextPop.c
    action	TextSink.c
    action	TextSrc.c
    action	TextTr.c
    action	Tip.c
    action	Toggle.c
    action	Tree.c
    action	Vendor.c
    action	Viewport.c
    action	XawI18n.c
    action	XawIm.c
    action	XawInit.c

    action	Private.h
    action	XawI18n.h

    dst_dir lib/Xaw/include/X11/Xaw

    action	AllWidgets.h
    action	AsciiSink.h
    action	AsciiSinkP.h
    action	AsciiSrc.h
    action	AsciiSrcP.h
    action	AsciiText.h
    action	AsciiTextP.h
    action	Box.h
    action	BoxP.h
    action	Cardinals.h
    action	Command.h
    action	CommandP.h
    action	Dialog.h
    action	DialogP.h
    action	Form.h
    action	FormP.h
    action	Grip.h
    action	GripP.h
    action	Label.h
    action	LabelP.h
    action	List.h
    action	ListP.h
    action	MenuButton.h
    action	MenuButtoP.h
    action	MultiSink.h
    action	MultiSinkP.h
    action	MultiSrc.h
    action	MultiSrcP.h
    action	Paned.h
    action	PanedP.h
    action	Panner.h
    action	PannerP.h
    action	Porthole.h
    action	PortholeP.h
    action	Print.h
    action	PrintSP.h
    action	Repeater.h
    action	RepeaterP.h
    action	Reports.h
    action	Scrollbar.h
    action	ScrollbarP.h
    action	Simple.h
    action	SimpleMenP.h
    action	SimpleMenu.h
    action	SimpleP.h
    action	SmeBSB.h
    action	SmeBSBP.h
    action	Sme.h
    action	SmeLine.h
    action	SmeLineP.h
    action	SmeP.h
    action	StripCharP.h
    action	StripChart.h
    action	Template.c
    action	Template.h
    action	TemplateP.h
    action	Text.h
    action	TextP.h
    action	TextSink.h
    action	TextSinkP.h
    action	TextSrc.h
    action	TextSrcP.h
    action	Tip.h
    action	TipP.h
    action	Toggle.h
    action	ToggleP.h
    action	Tree.h
    action	TreeP.h
    action	VendorEP.h
    action	Viewport.h
    action	ViewportP.h
    action	XawImP.h
    action	XawInit.h

    dst_dir lib/Xaw/man

    action	Xaw.man
}

symlink_lib_fs() {
    src_dir lib/FS
    dst_dir lib/FS/src

    action	FSCloseFt.c
    action	FSClServ.c
    action	FSConnServ.c
    action	FSErrDis.c
    action	FSErrHndlr.c
    action	FSFlush.c
    action	FSFontInfo.c
    action	FSFtNames.c
    action	FSGetCats.c
    action	FSlibInt.c
    action	FSListCats.c
    action	FSListExt.c
    action	FSMisc.c
    action	FSNextEv.c
    action	FSOpenFont.c
    action	FSOpenServ.c
    action	FSQGlyphs.c
    action	FSQuExt.c
    action	FSQXExt.c
    action	FSQXInfo.c
    action	FSServName.c
    action	FSSetCats.c
    action	FSSync.c
    action	FSSynchro.c

    action	FSlibint.h
    action	FSlibos.h

    dst_dir lib/FS/include/X11/fonts

    action	FSlib.h
}

symlink_lib_xres() {
    src_dir lib/XRes
    dst_dir lib/XRes/src

    action	XRes.c

    src_dir include/extensions
    dst_dir lib/XRes/include/X11/extensions

    action	XRes.h

    src_dir lib/XRes
    dst_dir lib/XRes/man

    action	XRes.man
}

symlink_lib_randr()
{
    src_dir lib/Xrandr
    dst_dir lib/Xrandr/src

    action	Xrandrint.h
    action	Xrandr.c

    dst_dir lib/Xrandr/include/X11/extensions

    action	Xrandr.h

    dst_dir lib/Xrandr/man

    action	Xrandr.man		Xrandr.3
}

symlink_lib_windowswm() {
    src_dir lib/windows
    dst_dir lib/WindowsWM/src

    action      windowswm.c

    dst_dir lib/WindowsWM/man

    action      WindowsWM.man WindowsWM.3
}

symlink_lib_xcursor()
{
    src_dir lib/Xcursor

    dst_dir lib/Xcursor/include/X11/Xcursor

    action	Xcursor.h

    dst_dir lib/Xcursor/src
    
    action	xcursorint.h
    action	cursor.c
    action	display.c
    action	file.c
    action	library.c
    action	xlib.c

    dst_dir lib/Xcursor/man

    action	Xcursor.man		Xcursor.3
}

symlink_lib_xtrap()
{
    src_dir lib/XTrap
    dst_dir lib/XTrap/src

    action	XECallBcks.c
    action	XEConTxt.c
    action	XEDsptch.c
    action	XEPrInfo.c
    action	XERqsts.c
    action	XEStrMap.c
    action	XETrapInit.c
    action	XEWrappers.c
}

symlink_lib_xfontcache() 
{
    src_dir lib/Xfontcache
    dst_dir lib/Xfontcache/src

    action	FontCache.c

    dst_dir lib/Xfontcache/man

    action	Xfontcache.man		Xfontcache.3
}

symlink_lib_xinerama()
{
    src_dir lib/Xinerama
    dst_dir lib/Xinerama/src

    action	Xinerama.c
}

symlink_lib_xprint_util()
{
    src_dir lib/XprintUtil
    dst_dir lib/XprintUtil/src

    action	xprintutil.c
    action	xprintutil_printtofile.c

    dst_dir lib/XprintUtil/include/X11/XprintUtil

    action	xprintutil.h
}

symlink_lib_xprint_app_util()
{
    src_dir lib/XprintAppUtil
    dst_dir lib/XprintAppUtil/src

    action	xpapputil.c

    dst_dir lib/XprintAppUtil/include/X11/XprintAppUtil

    action	xpapputil.h
}

symlink_lib_xss()
{
    src_dir lib/Xss
    dst_dir lib/XScrnSaver/src
    
    action	XScrnSaver.c

    dst_dir lib/XScrnSaver/man

    action	Xss.man			Xss.3
}

symlink_lib_xxf86dga() {
    src_dir lib/Xxf86dga
    dst_dir lib/Xxf86dga/src

    action	XF86DGA.c
    action	XF86DGA2.c

    dst_dir lib/Xxf86dga/man

    action	XDGA.man
}

symlink_lib_xxf86misc() {
    src_dir lib/Xxf86misc
    dst_dir lib/Xxf86misc/src

    action	XF86Misc.c

    dst_dir lib/Xxf86misc/man

    action	XF86Misc.man
}

symlink_lib_xxf86vm() {
    src_dir lib/Xxf86vm
    dst_dir lib/Xxf86vm/src

    action	XF86VMode.c

    dst_dir lib/Xxf86vm/man

    action	XF86VM.man
}

symlink_lib_xtst() {
    src_dir lib/Xtst
    dst_dir lib/Xtst/src

    action	XRecord.c
    action	XTest.c
}

symlink_lib_xv() {
    src_dir lib/Xv
    dst_dir lib/Xv/src

    action	Xv.c
    action	Xvlibint.h

    src_dir include/extensions
    dst_dir lib/Xv/include/X11/extensions

    action	Xvlib.h

    src_dir doc/man/Xv
    dst_dir lib/Xv/man

    action	XvFreeAdaptorInfo.man	XvFreeAdaptorInfo.3
    action	XvFreeEncodingInfo.man	XvFreeEncodingInfo.3
    action	XvGetPortAttribute.man	XvGetPortAttribute.3
    action	XvGetStill.man		XvGetStill.3
    action	XvGetVideo.man		XvGetVideo.3
    action	XvGrabPort.man		XvGrabPort.3
    action	Xv.man			Xv.3
    action	XvPortNotify.man	XvPortNotify.3
    action	XvPutStill.man		XvPutStill.3
    action	XvPutVideo.man		XvPutVideo.3
    action	XvQueryAdaptors.man	XvQueryAdaptors.3
    action	XvQueryBestSize.man	XvQueryBestSize.3
    action	XvQueryEncodings.man	XvQueryEncodings.3
    action	XvQueryExtension.man	XvQueryExtension.3
    action	XvSelectPortNotify.man	XvSelectPortNotify.3
    action	XvSelectVideoNotify.man	XvSelectVideoNotify.3
    action	XvSetPortAttribute.man	XvSetPortAttribute.3
    action	XvStopVideo.man		XvStopVideo.3
    action	XvUngrabPort.man	XvUngrabPort.3
    action	XvVideoNotify.man	XvVideoNotify.3
}

symlink_lib_xvmc() {
    src_dir lib/XvMC
    dst_dir lib/XvMC/src

    action	XvMC.c
    action	XvMClibint.h

    src_dir lib/XvMC/wrapper

    action	XvMCWrapper.c

    src_dir include/extensions
    dst_dir lib/XvMC/include/X11/extensions

    action	XvMClib.h
}

symlink_lib_xxf86rush() {
    src_dir lib/Xxf86rush
    dst_dir lib/Xxf86rush/src

    action	XF86Rush.c
}

symlink_lib_xkbfile() {
    src_dir lib/xkbfile
    dst_dir lib/xkbfile/src

    action	cout.c
    action	maprules.c
    action	srvmisc.c
    action	xkbatom.c
    action	xkbbells.c
    action	xkbconfig.c
    action	xkbdraw.c
    action	xkberrs.c
    action	xkbmisc.c
    action	xkbout.c
    action	xkbtext.c
    action	xkmout.c
    action	xkmread.c
    action	XKBfileInt.h
    action	magic

    dst_dir lib/xkbfile/include/X11/extensions

    action	XKBbells.h
    action	XKBconfig.h
    action	XKBfile.h
    action	XKBrules.h
    action	XKMformat.h
    action	XKM.h
}

symlink_lib_xkbui() {
    src_dir lib/xkbui
    dst_dir lib/xkbui/src

    action	XKBui.c
    action	XKBuiPriv.h
    
    dst_dir lib/xkbui/include/X11/extensions

    action	XKBui.h
}

symlink_lib_oldx() {
    src_dir lib/oldX
    dst_dir lib/oldX/src

    action	XCrAssoc.c
    action	XDelAssoc.c
    action	XDestAssoc.c
    action	XDraw.c
    action	XLookAssoc.c
    action	XMakeAssoc.c

    dst_dir lib/oldX/include/X11
    
    action	X10.h
}


symlink_lib_lbxutil() {
    src_dir lib/lbxutil/image
    dst_dir lib/lbxutil/src/image

    action     dfaxg42d.c
    action     dpackbits.c
    action     efaxg42d.c
    action     epackbits.c
    action     lbxbwcodes.h
    action     lbxfax.h
    action     misc.c
    action     mkg3states.c

    src_dir lib/lbxutil/delta
    dst_dir lib/lbxutil/src/delta

    action     lbxdelta.c

    src_dir lib/lbxutil/lbx_zlib
    dst_dir lib/lbxutil/src/lbx_zlib

    action     lbx_zlib.c
    action     lbx_zlib.h
    action     lbx_zlib_io.c
    action     reqstats.c
    action     reqstats.h
}

symlink_lib_xft() {
    src_dir lib/Xft
    dst_dir lib/Xft

    action	NEWS
    action	README
    action	AUTHORS
    action	ChangeLog
    action	COPYING
    action	INSTALL

    action	xft.pc.in
    action	xft-config.in

    dst_dir lib/Xft/man

    action	Xft.3.in
    action	xft-config.1.in

    dst_dir lib/Xft/include/X11/Xft

    action	Xft.h
    action	XftCompat.h

    dst_dir lib/Xft/src

    action	xftcolor.c
    action	xftcore.c
    action	xftdbg.c
    action	xftdpy.c
    action	xftdraw.c
    action	xftextent.c
    action	xftfont.c
    action	xftfreetype.c
    action	xftglyphs.c
    action	xftinit.c
    action	xftint.h
    action	xftlist.c
    action	xftname.c
    action	xftrender.c
    action	xftstr.c
    action	xftswap.c
    action	xftxlfd.c
}

symlink_lib() {
    symlink_lib_xft
    symlink_lib_applewm
    symlink_lib_windowswm
    symlink_lib_dmx
    symlink_lib_composite
    symlink_lib_damage
    symlink_lib_evie
    symlink_lib_fixes 
    symlink_lib_xau
    symlink_lib_xtrans
    symlink_lib_xdmcp
    symlink_lib_x11
    symlink_lib_ice
    symlink_lib_sm
    symlink_lib_xt
    symlink_lib_xext
    symlink_lib_xmu
    symlink_lib_xp
    symlink_lib_xpm
    symlink_lib_fontenc
    symlink_lib_xfont
    symlink_lib_xrender
    symlink_lib_xi
    symlink_lib_xaw
    symlink_lib_fs
    symlink_lib_xres
    symlink_lib_randr
    symlink_lib_xcursor
    symlink_lib_xtrap
    symlink_lib_xfontcache
    symlink_lib_xinerama
    symlink_lib_xprint_util
    symlink_lib_xprint_app_util
    symlink_lib_xss
    symlink_lib_xxf86dga
    symlink_lib_xxf86misc
    symlink_lib_xxf86vm
    symlink_lib_xtst
    symlink_lib_xv
    symlink_lib_xxf86rush
    symlink_lib_xkbfile
    symlink_lib_xkbui
    symlink_lib_oldx
    symlink_lib_xvmc
    symlink_lib_lbxutil
}

#########
#
#	The app module
#
#########

symlink_app_twm() {
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

symlink_app_xdpyinfo() {
    src_dir programs/xdpyinfo
    dst_dir app/xdpyinfo

    action	xdpyinfo.c
    action	xdpyinfo.man
}

symlink_app_xhost() {
    src_dir programs/xhost
    dst_dir app/xhost

    action	xhost.c
    action	xhost.man
}

symlink_app_appres() {
    src_dir programs/appres
    dst_dir app/appres

    action	appres.c

    action	appres.man

}

symlink_app_bdftopcf() {
    src_dir programs/bdftopcf
    dst_dir app/bdftopcf

    action	bdftopcf.c

    action	bdftopcf.man

}

symlink_app_beforelight() {
    src_dir programs/beforelight
    dst_dir app/beforelight

    action	B4light.ad

    action	b4light.c

    action	b4light.man	beforelight.man

}

symlink_app_bitmap() {
    src_dir programs/bitmap
    dst_dir app/bitmap

    action	Bitmap.ad
    action	Bitmap-co.ad		Bitmap-color.ad
    action	Bitmap-nocase.ad

    action	atobm.c
    action	BitEdit.c
    action	Bitmap.c
    action	bmtoa.c
    action	CutPaste.c
    action	Dialog.c
    action	Graphics.c
    action	Handlers.c
    action	ReqMach.c

    action	Bitmap.h
    action	BitmapP.h
    action	Dialog.h
    action	Requests.h

    action	bitmap.man

    action	Dashes
    action	Down
    action	Excl
    action	FlipHoriz
    action	FlipVert
    action	Fold
    action	Left
    action	Right
    action	RotateLeft
    action	RotateRight
    action	Stipple
    action	Term
    action	Up

    action	bitmap.icon
}

symlink_app_editres() {
    src_dir programs/editres
    dst_dir app/editres

    action	Edit-col.ad
    action	Editres.ad

    action	actions.c
    action	comm.c
    action	editres.c
    action	geometry.c
    action	handler.c
    action	setvalues.c
    action	svpopup.c
    action	utils.c
    action	widgets.c
    action	wtree.c

    action	README

    action	editresP.h

    action	editres.man

}

symlink_app_fonttosfnt() {
    src_dir programs/fonttosfnt
    dst_dir app/fonttosfnt

    action	env.c
    action	fonttosfnt.c
    action	read.c
    action	struct.c
    action	util.c
    action	write.c

    action	fonttosfnt.h

    action	fonttosfnt.man

}

symlink_app_fslsfonts() {
    src_dir programs/fslsfonts
    dst_dir app/fslsfonts

    action	fslsfonts.c

    action	fslsfonts.man

}

symlink_app_fstobdf() {
    src_dir programs/fstobdf
    dst_dir app/fstobdf

    action	chars.c
    action	fstobdf.c
    action	header.c
    action	props.c

    action	fstobdf.h

    action	fstobdf.man

}

symlink_app_iceauth() {
    src_dir programs/iceauth
    dst_dir app/iceauth

    action	iceauth.c
    action	process.c

    action	iceauth.h

    action	iceauth.man

}

symlink_app_ico() {
    src_dir programs/ico
    dst_dir app/ico

    action	ico.c

    action	allobjs.h
    action	objcube.h
    action	objico.h
    action	objocta.h
    action	objplane.h
    action	objpyr.h
    action	polyinfo.h

    action	ico.man

}

symlink_app_listres() {
    src_dir programs/listres
    dst_dir app/listres

    action	listres.c

    action	listres.man

}

symlink_app_luit() {
    src_dir programs/luit
    dst_dir app/luit

    action	charset.c
    action	iso2022.c
    action	locale.c
    action	luit.c
    action	other.c
    action	parser.c
    action	sys.c

    action	charset.h
    action	iso2022.h
    action	luit.h
    action	other.h
    action	parser.h
    action	sys.h

    action	luit.man

}

symlink_app_mkcfm() {
    src_dir programs/mkcfm
    dst_dir app/mkcfm

    action	mkcfm.c
    action	mkcfm.man
}

symlink_app_makepsres() {
    src_dir programs/makepsres
    dst_dir app/makepsres

    action	makepsres.c

    action	makepsres.man

}

symlink_app_mkfontdir() {
    src_dir programs/mkfontdir
    dst_dir app/mkfontdir

    action	mkfontdir.cpp

    action	mkfontdir.man

}

symlink_app_mkfontscale() {
    src_dir programs/mkfontscale
    dst_dir app/mkfontscale

    action	hash.c
    action	ident.c
    action	list.c
    action	mkfontscale.c

    action	data.h
    action	hash.h
    action	ident.h
    action	list.h

    action	mkfontscale.man

}

symlink_app_oclock() {
    src_dir programs/oclock
    dst_dir app/oclock

    action	Clock-col.ad

    action	Clock.c
    action	oclock.c
    action	transform.c

    action	Clock.h
    action	ClockP.h
    action	transform.h

    action	oclock.man

    action	oclock.bit
    action	oclmask.bit
}

symlink_app_pclcomp() {
    src_dir programs/pclcomp
    dst_dir app/pclcomp

    action	pclcomp.c

    action	README
    action	printer.note

    action	pclcomp.man

}

symlink_app_proxymngr() {
    src_dir programs/proxymngr
    dst_dir app/proxymngr

    action	config.c
    action	main.c
    action	pmdb.c

    action	config.h
    action	pmdb.h
    action	pmint.h

    action	proxymngr.man

    action	pmconfig.cpp
}

symlink_app_rgb() {
    src_dir programs/rgb
    dst_dir app/rgb

    action	rgb.c
    action	showrgb.c
    action	showrgb.man
    action	rgb.txt
    
    src_dir programs/rgb/others
    dst_dir app/rgb/others

    action	old-rgb.txt
    action	raveling.txt
    action	README
    action	thomas.txt

}

symlink_app_setxkbmap() {
    src_dir programs/setxkbmap
    dst_dir app/setxkbmap

    action	setxkbmap.c

    action	setxkbmap.man
}

symlink_app_showfont() {
    src_dir programs/showfont
    dst_dir app/showfont

    action	showfont.c

    action	showfont.man
}

symlink_app_smproxy() {
    src_dir programs/smproxy
    dst_dir app/smproxy

    action	save.c
    action	smproxy.c

    action	smproxy.h

    action	smproxy.man
}

symlink_app_viewres() {
    src_dir programs/viewres
    dst_dir app/viewres

    action	Viewres.ad

    action	viewres.c

    action	viewres.man
}

symlink_app_x11perf() {
    src_dir programs/x11perf
    dst_dir app/x11perf

    action	bitmaps.c
    action	do_arcs.c
    action	do_blt.c
    action	do_complex.c
    action	do_dots.c
    action	do_lines.c
    action	do_movewin.c
    action	do_rects.c
    action	do_segs.c
    action	do_simple.c
    action	do_tests.c
    action	do_text.c
    action	do_traps.c
    action	do_tris.c
    action	do_valgc.c
    action	do_windows.c
    action	x11perf.c

    action	bitmaps.h
    action	x11perf.h

    action	x11pcomp.man x11perfcomp.man
    action	x11perf.man
    action	Xmark.man

    action	fillblnk.sh	fillblnk
    action	perfboth.sh	perfboth
    action	perfratio.sh	perfratio
    action	Xmark.sh	Xmark

    action	x11pcomp.cpp
}

symlink_app_xauth() {
    src_dir programs/xauth
    dst_dir app/xauth

    action	gethost.c
    action	parsedpy.c
    action	process.c
    action	xauth.c

    action	xauth.h

    action	xauth.man
}

symlink_app_xbiff() {
    src_dir programs/xbiff
    dst_dir app/xbiff

    action	Mailbox.c
    action	xbiff.c

    action	Mailbox.h
    action	MailboxP.h

    action	xbiff.man

    src_dir programs/xbiff/bitmaps
    dst_dir app/xbiff/bitmaps

    action	mail-down
    action	mail-down-mask
    action	mail-up
    action	mail-up-mask
}

symlink_app_xcalc() {
    src_dir programs/xcalc
    dst_dir app/xcalc

    action	XCalc.ad
    action	XCalc-col.ad

    action	actions.c
    action	math.c
    action	xcalc.c

    action	actions.h
    action	xcalc.h

    action	xcalc.man

}

symlink_app_xclipboard() {
    src_dir programs/xclipboard
    dst_dir app/xclipboard

    action	XClipboard.ad

    action	xclipboard.c
    action	xcutsel.c

    action	xclipboard.man
    action	xcutsel.man

}

symlink_app_xclock() {
    src_dir programs/xclock
    dst_dir app/xclock

    action	XClk-col.ad
    action	XClock.ad

    action	Clock.c
    action	xclock.c

    action	Clock.h
    action	ClockP.h

    action	xclock.man

    action	clmask.bit
    action	clock.bit
 
}

symlink_app_xcmsdb() {
    src_dir programs/xcmsdb
    dst_dir app/xcmsdb

    action	loadData.c
    action	xcmsdb.c

    action	SCCDFile.h

    action	xcmsdb.man

    src_dir programs/xcmsdb/datafiles
    dst_dir app/xcmsdb/datafiles

    action	sample1.dcc
    action	sample2.dcc
}

symlink_app_xconsole() {
    src_dir programs/xconsole
    dst_dir app/xconsole

    action	XConsole.ad

    action	xconsole.c

    action	xconsole.man

}

symlink_app_xcursorgen() {
    src_dir programs/xcursorgen
    dst_dir app/xcursorgen

    action	xcursorgen.c
    action	xcursorgen.man
}

symlink_app_xdbedizzy() {
    src_dir programs/xdbedizzy
    dst_dir app/xdbedizzy

    action	xdbedizzy.c

    action	xdbedizzy.man

    action	xdbedizzy.sgml
}

symlink_app_xditview() {
    src_dir programs/xditview
    dst_dir app/xditview

    action	Xdit-chrtr.ad		Xditview-chrtr.ad
    action	Xditview.ad

    action	draw.c
    action	Dvi.c
    action	DviChar.c
    action	font.c
    action	lex.c
    action	page.c
    action	parse.c
    action	xditview.c
    action	XFontName.c

    action	DviChar.h
    action	Dvi.h
    action	DviP.h
    action	Menu.h
    action	XFontName.h

    action	xditview.man

    action	xdit.bm
    action	xdit_mask.bm

    action	ldblarrow
    action	rdblarrow
}

symlink_app_xdriinfo() {
    src_dir programs/xdriinfo
    dst_dir app/xdriinfo

    action	xdriinfo.c

    action	xdriinfo.man

}

symlink_app_xev() {
    src_dir programs/xev
    dst_dir app/xev

    action	xev.c

    action	xev.man

}

symlink_app_xeyes() {
    src_dir programs/xeyes
    dst_dir app/xeyes

    action	Eyes.c
    action	transform.c
    action	xeyes.c

    action	Eyes.h
    action	EyesP.h
    action	transform.h

    action	xeyes.man

    action	eyes.bit
    action	eyesmask.bit
}

symlink_app_xf86dga() {
    src_dir programs/xf86dga
    dst_dir app/xf86dga

    action	dga.c

    action	dga.man

}

symlink_app_xfd() {
    src_dir programs/xfd
    dst_dir app/xfd

    action	Xfd.ad

    action	grid.c
    action	xfd.c

    action	grid.h
    action	gridP.h

    action	xfd.man

}

symlink_app_xfindproxy() {
    src_dir programs/xfindproxy
    dst_dir app/xfindproxy

    action	xfindproxy.c

    action	xfindproxy.h

    action	xfindproxy.man

}

symlink_app_xfontsel() {
    src_dir programs/xfontsel
    dst_dir app/xfontsel

    action	XFontSel.ad

    action	ULabel.c
    action	xfontsel.c

    action	ULabel.h
    action	ULabelP.h

    action	xfontsel.man

}

symlink_app_xfsinfo() {
    src_dir programs/xfsinfo
    dst_dir app/xfsinfo

    action	xfsinfo.c

    action	xfsinfo.man

}

symlink_app_xfwp() {
    src_dir programs/xfwp
    dst_dir app/xfwp

    action	io.c
    action	misc.c
    action	pm.c
    action	transport.c
    action	xfwp.c

    action	io.h
    action	misc.h
    action	pm.h
    action	transport.h
    action	xfwp.h

    action	xfwp.man

}

symlink_app_xgamma() {
    src_dir programs/xgamma
    dst_dir app/xgamma

    action	xgamma.c

    action	xgamma.man

}

symlink_app_xgc() {
    src_dir programs/xgc
    dst_dir app/xgc

    action	Xgc.ad

    action	choice.c
    action	dashlist.c
    action	getfile.c
    action	gram.y
    action	interpret.c
    action	lex.l
    action	main.c
    action	planemask.c
    action	record.c
    action	testfrac.c
    action	tests.c
    action	text.c

    action	constants.h
    action	main.h
    action	xgc.h

    action	xgc.man

    action	Bugs
    action	tile

    src_dir programs/xgc/Written
    dst_dir app/xgc/Written

    action	FilledRects
    action	Interface
    action	Jim
    action	Notes
    action	Notes2
    action	Outline
    action	Widget
}

symlink_app_xinit() {
    src_dir programs/xinit
    dst_dir app/xinit

    action	xinit.c

    action	README

    action	startx.man
    action	xinit.man

    action	startx.cmd
    action	xinitrc.cmd
    action	xinit.def
    action	startx.cpp
    action	xinitrc.cpp
}

symlink_app_xkbcomp() {
    src_dir programs/xkbcomp
    dst_dir app/xkbcomp

    action	action.c
    action	alias.c
    action	compat.c
    action	expr.c
    action	geometry.c
    action	indicators.c
    action	keycodes.c
    action	keymap.c
    action	keytypes.c
    action	listing.c
    action	misc.c
    action	parseutils.c
    action	symbols.c
    action	utils.c
    action	vmod.c
    action	xkbcomp.c
    action	xkbparse.y
    action	xkbpath.c
    action	xkbscan.c

    action	README
    action	README.config
    action	README.enhancing

    action	action.h
    action	alias.h
    action	compat.h
    action	expr.h
    action	indicators.h
    action	keycodes.h
    action	misc.h
    action	parseutils.h
    action	tokens.h
    action	utils.h
    action	vmod.h
    action	xkbcomp.h
    action	xkbpath.h

    action	xkbcomp.man

}

symlink_app_xkbevd() {
    src_dir programs/xkbevd
    dst_dir app/xkbevd

    action	cfgparse.y
    action	cfgscan.c
    action	evargs.c
    action	printev.c
    action	utils.c
    action	xkbevd.c

    action	tokens.h
    action	utils.h
    action	xkbevd.h

    action	xkbevd.man

    action      example.cf
}

symlink_app_xkbprint() {
    src_dir programs/xkbprint
    dst_dir app/xkbprint

    action	psgeom.c
    action	utils.c
    action	xkbprint.c

    action	isokeys.h
    action	utils.h
    action	xkbprint.h

    action	xkbprint.man

}

symlink_app_xkbutils() {
    src_dir programs/xkbutils
    dst_dir app/xkbutils

    action	LED.c
    action	utils.c
    action	xkbbell.c
    action	xkbvleds.c
    action	xkbwatch.c

    action	LED.h
    action	LEDP.h
    action	utils.h

}

symlink_app_xkill() {
    src_dir programs/xkill
    dst_dir app/xkill

    action	xkill.c

    action	xkill.man

}

symlink_app_xload() {
    src_dir programs/xload
    dst_dir app/xload

    action	XLoad.ad

    action	get_load.c
    action	get_rload.c
    action	xload.c

    action	xload.h

    action	xload.man

    action	xload.bit
}

symlink_app_xlogo() {
    src_dir programs/xlogo
    dst_dir app/xlogo

    action	XLogo.ad
    action	XLogo-co.ad

    action	Logo.c
    action	print.c
    action	RenderLogo.c
    action	xlogo.c

    action	Logo.h
    action	LogoP.h
    action	print.h
    action	RenderLogo.h
    action	xlogo.h

    action	xlogo.man

}

symlink_app_xlsatoms() {
    src_dir programs/xlsatoms
    dst_dir app/xlsatoms

    action	xlsatoms.c

    action	xlsatoms.man

}

symlink_app_xlsclients() {
    src_dir programs/xlsclients
    dst_dir app/xlsclients

    action	xlsclients.c

    action	xlscli.man xlsclients.man

}

symlink_app_xlsfonts() {
    src_dir programs/xlsfonts
    dst_dir app/xlsfonts

    action	dsimple.c
    action	xlsfonts.c

    action	dsimple.h

    action	xlsfonts.man
    action      xlsfonts.sgml
}

symlink_app_xmag() {
    src_dir programs/xmag
    dst_dir app/xmag

    action	Xmag.ad

    action	CutPaste.c
    action	RootWin.c
    action	Scale.c
    action	xmag.c

    action	CutPaste.h
    action	RootWin.h
    action	RootWinP.h
    action	Scale.h
    action	ScaleP.h

    action	Scale.doc Scale.txt

    action	xmag.man

    action	xmag.icon
}

symlink_app_xman() {
    src_dir programs/xman
    dst_dir app/xman

    action	Xman-noxprint.ad
    action	Xman-xprint.ad

    action	buttons.c
    action	globals.c
    action	handler.c
    action	help.c
    action	main.c
    action	man.c
    action	misc.c
    action	print.c
    action	ScrollByL.c
    action	search.c
    action	tkfuncs.c
    action	vendor.c

    action	defs.h
    action	globals.h
    action	iconclosed.h
    action	icon_help.h
    action	icon_open.h
    action	man.h
    action	print.h
    action	ScrollByL.h
    action	ScrollByLP.h
    action	vendor.h
    action	version.h

    action	xman.help
    action	xman.man

}

symlink_app_xmessage() {
    src_dir programs/xmessage
    dst_dir app/xmessage

    action	Xmessage.ad
    action	Xmessage-color.ad

    action	makeform.c
    action	readfile.c
    action	xmessage.c

    action	README

    action	readfile.h
    action	xmessage.h

    action	xmessage.man

    action	Tests
}

symlink_app_xmh() {
    src_dir programs/xmh
    dst_dir app/xmh

    action	Xmh.ad

    action	bbox.c
    action	command.c
    action	compfuncs.c
    action	folder.c
    action	init.c
    action	main.c
    action	menu.c
    action	miscfuncs.c
    action	mlist.c
    action	msg.c
    action	pick.c
    action	popup.c
    action	screen.c
    action	toc.c
    action	tocfuncs.c
    action	tocutil.c
    action	tsource.c
    action	util.c
    action	viewfuncs.c

    action	actions.h
    action	bbox.h
    action	bboxint.h
    action	externs.h
    action	globals.h
    action	mlist.h
    action	msg.h
    action	toc.h
    action	tocintrnl.h
    action	tocutil.h
    action	tsource.h
    action	tsourceP.h
    action	version.h
    action	xmh.h

    action	xmh.man

    action	black6
    action	box6
    action	Xmh.sample
}

symlink_app_xmodmap() {
    src_dir programs/xmodmap
    dst_dir app/xmodmap

    action	exec.c
    action	handle.c
    action	pf.c
    action	xmodmap.c

    action	wq.h
    action	xmodmap.h

    action	xmodmap.man

    action	swap.km
}

symlink_app_xmore() {
    src_dir programs/xmore
    dst_dir app/xmore

    action	XMore.ad

    action	print.c
    action	printdialog.c
    action	xmore.c

    action	printdialog.h
    action	printdialogprivates.h
    action	print.h
    action	xmore.h

    action	xmore.man
    action      xmore.sgml
}

symlink_app_xplsprinters() {
    src_dir programs/xplsprinters
    dst_dir app/xplsprinters

    action	xplsprinters.c

    action	xplsprinters.man

    action	xplsprinters.sgml
}

symlink_app_xpr() {
    src_dir programs/xpr
    dst_dir app/xpr

    action	x2jet.c
    action	x2pmp.c
    action	xpr.c

    action	lncmd.h
    action	pmp.h
    action	xpr.h

    action	xdpr.man
    action	xpr.man

    action	xdpr.script
}

symlink_app_xprehashprinterlist() {
    src_dir programs/xprehashprinterlist
    dst_dir app/xprehashprinterlist

    action	xprehashprinterlist.c

    action	xprehashprinterlist.man

    action	xprehashprinterlist.sgml
}

symlink_app_xrandr() {
    src_dir programs/xrandr
    dst_dir app/xrandr

    action	xrandr.c

    action	xrandr.man

}

symlink_app_xrdb() {
    src_dir programs/xrdb
    dst_dir app/xrdb

    action	xrdb.c

    action	xrdb.man

}

symlink_app_xrefresh() {
    src_dir programs/xrefresh
    dst_dir app/xrefresh

    action	xrefresh.c

    action	xrefresh.man

}

symlink_app_xset() {
    src_dir programs/xset
    dst_dir app/xset

    action	xset.c

    action	xset.man

}

symlink_app_xsetmode() {
    src_dir programs/xsetmode
    dst_dir app/xsetmode

    action	xsetmode.c

    action	xsetmode.man

}

symlink_app_xsetpointer() {
    src_dir programs/xsetpointer
    dst_dir app/xsetpointer

    action	xsetpointer.c

    action	xsetpnt.man xsetpointer.man

}

symlink_app_xsetroot() {
    src_dir programs/xsetroot
    dst_dir app/xsetroot

    action	xsetroot.c

    action	xsetroot.man

}

symlink_app_xsm() {
    src_dir programs/xsm
    dst_dir app/xsm

    action	XSm.ad

    action	auth.c
    action	choose.c
    action	globals.c
    action	info.c
    action	list.c
    action	lock.c
    action	log.c
    action	mainwin.c
    action	misc.c
    action	popup.c
    action	printhex.c
    action	prop.c
    action	remote.c
    action	restart.c
    action	save.c
    action	saveutil.c
    action	signals.c
    action	xsm.c
    action	xtwatch.c

    action	README

    action	system.xsm

    action	auth.h
    action	choose.h
    action	info.h
    action	list.h
    action	lock.h
    action	log.h
    action	mainwin.h
    action	popup.h
    action	prop.h
    action	restart.h
    action	save.h
    action	saveutil.h
    action	xsm.h
    action	xtwatch.h

    action	xsm.man

}

symlink_app_xstdcmap() {
    src_dir programs/xstdcmap
    dst_dir app/xstdcmap

    action	xstdcmap.c

    action	xstdcmap.man

}

symlink_app_xtrap() {
    src_dir programs/xtrap
    dst_dir app/xtrap

    action	chparse.c
    action	XEKeybCtrl.c
    action	xtrapchar.c
    action	xtrapin.c
    action	xtrapinfo.c
    action	xtrapout.c
    action	xtrapproto.c
    action	xtrapreset.c
    action	xtrapstats.c

    action	chparse.h
    action	XEKeybCtrl.h

    action	xtrap.man

}

symlink_app_xvidtune() {
    src_dir programs/xvidtune
    dst_dir app/xvidtune

    action	Xvidtune.cpp

    action	xvidtune.c

    action	xvidtune.man

}

symlink_app_xvinfo() {
    src_dir programs/xvinfo
    dst_dir app/xvinfo

    action	xvinfo.c

    action	xvinfo.man
}

symlink_app_xwud() {
    src_dir programs/xwud
    dst_dir app/xwud

    action	xwud.c

    action	xwud.man
}

symlink_app_scripts() {
    src_dir programs/scripts
    dst_dir app/scripts

    action	fontname.sh
    action	fontprop.sh
    action	xauth_switch_to_sun-des-1.cpp
    action	xon.sh xon

    action	xon.man
}

symlink_app_rstart() {
    src_dir programs/rstart
    dst_dir app/rstart

    action	auth.c		
    action	server.c	

    action	rstartd.man	
    action	rstart.man	
    
    action	client.cpp	
    action	server.cpp	
    action	config.cpp	

    action	server.os2	

    # commands

    src_dir programs/rstart/commands
    dst_dir app/rstart/commands

    action	ListContexts
    action	ListGenericCommands
    action	@List

    #        x11r6
    
    src_dir programs/rstart/commands/x11r6
    dst_dir app/rstart/commands/x11r6

    action	@List
    action	LoadMonitor
    action	Terminal

    # contexts

    src_dir programs/rstart/contexts
    dst_dir app/rstart/contexts

    action	@List
    action	@Aliases
    action	default
    action	x11r6

    # samples

    #        commands

    src_dir programs/rstart/samples/commands
    dst_dir app/rstart/samples/commands

    action	@List
    action	ListContexts
    action	ListGenericCommands

    #                odt1
    
    src_dir programs/rstart/samples/commands/odt1
    dst_dir app/rstart/samples/commands/odt1

    action	@List
    action	LoadMonitor
    action	Terminal

    #                openwindows2

    src_dir programs/rstart/samples/commands/openwindows2
    dst_dir app/rstart/samples/commands/openwindows2

    action	@List
    action	LoadMonitor
    action	Terminal

    #                openwindow3

    src_dir programs/rstart/samples/commands/openwindows3
    dst_dir app/rstart/samples/commands/openwindows3

    action	@List
    action	LoadMonitor
    action	Terminal

    #                x11r5

    src_dir programs/rstart/samples/commands/x11r5
    dst_dir app/rstart/samples/commands/x11r5

    action	@List
    action	LoadMonitor
    action	Terminal

    #        contexts.odt1

    src_dir programs/rstart/samples/contexts.odt1
    dst_dir app/rstart/samples/contexts.odt1

    action	@Aliases
    action	@List
    action	default
    action	odt1

    #        contexts.sun

    src_dir programs/rstart/samples/contexts.sun
    dst_dir app/rstart/samples/contexts.odt1

    action	@Aliases
    action	@List
    action	default
    action	openwindows2
    action	openwindows3
    action	x11r5
    action	x11r6
}

symlink_app_sessreg() {
    src_dir programs/xdm
    dst_dir app/sessreg

    action	sessreg.c
    action	sessreg.man
}

symlink_app_xdm() {
    src_dir programs/xdm
    dst_dir app/xdm

    action	access.c
    action	auth.c
    action	choose.c
    action	chooser.c
    action	daemon.c
    action	dm.c
    action	dpylist.c
    action	error.c
    action	file.c
    action	genauth.c
    action	krb5auth.c
    action	mitauth.c
    action	netaddr.c
    action	policy.c
    action	prngc.c
    action	protodpy.c
    action	reset.c
    action	resource.c
    action	rpcauth.c
    action	server.c
    action	session.c
    action	socket.c
    action	streams.c
    action	util.c
    action	xdmauth.c
    action	xdmcp.c
    action      xdmshell.c

    action	dm_auth.h
    action	dm_error.h
    action	dm.h
    action	dm_socket.h
    action	greet.h

    action	Chooser.ad

    action	xdm.man		xdm.man.cpp

    src_dir programs/xdm/greeter
    dst_dir app/xdm/greeter

    action	greet.c
    action	Login.c
    action	Login.h
    action	LoginP.h
    action	verify.c

    src_dir programs/xdm/config
    dst_dir app/xdm/config
    
    action	README

    action	GiveConsole
    action	TakeConsole

    action	xorg-bw.xpm
    action	xorg.xpm

    action	Xreset
    action	Xaccess
    action	Xservers.fs
    action	Xsession
    action	Xsetup_0
    action	Xstartup
    action	Xwilling
 
    action	Xres.cpp	Xresources.cpp
    action	Xserv.ws.cpp	Xservers.ws.cpp
    action	xdm-conf.cpp	xdm-config.cpp
}

symlink_app_xprop() {
    src_dir programs/xprop
    dst_dir app/xprop

    action	xprop.c

    action	xprop.man

    src_dir programs/xlsfonts

    action	dsimple.c
    action	dsimple.h
}

symlink_app_xwd() {
    src_dir programs/xwd
    dst_dir app/xwd

    action	list.c
    action	multiVis.c
    action	xwd.c

    action	list.h
    action	multiVis.h
    action	wsutils.h

    action	xwd.man

    src_dir programs/xlsfonts

    action	dsimple.c
    action	dsimple.h
}

symlink_app_xwininfo() {
    src_dir programs/xwininfo
    dst_dir app/xwininfo

    action	xwininfo.c

    action	xwininfo.man

    src_dir programs/xlsfonts

    action	dsimple.c
    action	dsimple.h
}

symlink_app_xphelloworld() {
    src_dir programs/xphelloworld/xpxmhelloworld
    dst_dir app/xphelloworld/xpxmhelloworld

    action	xpxmhelloworld.man
    action	xpxmhelloworld.c
    action	xpxmhelloworld.sgml

    src_dir programs/xphelloworld/xpsimplehelloworld
    dst_dir app/xphelloworld/xpsimplehelloworld

    action	xpsimplehelloworld.sgml
    action	xpsimplehelloworld.c
    action	xpsimplehelloworld.man

    src_dir programs/xphelloworld/xpxthelloworld
    dst_dir app/xphelloworld/xpxthelloworld

    action	xpxthelloworld.man
    action	xpxthelloworld.sgml
    action	xpxthelloworld.c

    src_dir programs/xphelloworld/xpawhelloworld
    dst_dir app/xphelloworld/xpawhelloworld

    action	xpawhelloworld.c
    action	xpawhelloworld.man

    src_dir programs/xphelloworld/xphelloworld
    dst_dir app/xphelloworld/xphelloworld

    action	xphelloworld.sgml
    action	xphelloworld.c
    action	xphelloworld.man
}

symlink_app_lbxproxy() {
    src_dir programs/lbxproxy
    dst_dir app/lbxproxy

    action	design
    action	lbxproxy.def
    action	lbxproxy.man

    src_dir programs/lbxproxy/config
    dst_dir app/lbxproxy/config

    action	AtomControl

    src_dir programs/lbxproxy/di
    dst_dir app/lbxproxy/di

    action	atomcache.c
    action	cache.c
    action	cmap.c
    action	cmaputil.c
    action	dispatch.c
    action	extensions.c
    action	gfx.c
    action	globals.c
    action	init.c
    action	lbxfuncs.c
    action	lbxutil.c
    action	main.c
    action	options.c
    action	pm.c
    action	props.c
    action	reqtype.c
    action	resource.c
    action	swaprep.c
    action	swapreq.c
    action	tables.c
    action	tags.c
    action	unsquish.c
    action	utils.c
    action	wire.c
    action	zeropad.c

    src_dir programs/lbxproxy/include
    dst_dir app/lbxproxy/include

    action	assert.h
    action	atomcache.h
    action	cache.h
    action	colormap.h
    action	init.h
    action	lbxext.h
    action	lbx.h
    action	misc.h
    action	os.h
    action	pm.h
    action	pmP.h
    action	proxyopts.h
    action	reqtype.h
    action	resource.h
    action	swap.h
    action	tags.h
    action	util.h
    action	wire.h

    src_dir programs/lbxproxy/os
    dst_dir app/lbxproxy/os

    action	connection.c
    action	io.c
    action	osdep.h
    action	osinit.c
    action	WaitFor.c
}

symlink_app_xedit() {
    src_dir programs/xedit
    dst_dir app/xedit

    action	xedit.h
    action	commands.c
    action	hook.c
    action	ispell.c
    action	lisp.c
    action	options.c
    action	realpath.c
    action	strcasecmp.c
    action	util.c
    action	xedit.c

    action	Xedit-color.ad
    action	Xedit-noxprint.ad
    action	Xedit-xprint.ad

    action	Xedit-sample

    dst_dir app/xedit/man
    action      xedit.man xedit.1
    
    src_dir programs/xedit/lisp
    dst_dir app/xedit/lisp
    
    action	bytecode.c
    action	bytecode.h
    action	compile.c
    action	core.c
    action	core.h
    action	debugger.c
    action	debugger.h
    action	env.c
    action	format.c
    action	format.h
    action	hash.c
    action	hash.h
    action	helper.c
    action	helper.h
    action	internal.h
    action	io.c
    action	io.h
    action	lisp.c
    action	lisp.h
    action	lsp.c
    action	math.c
    action	math.h
    action	mathimp.c
    action	package.c
    action	package.h
    action	pathname.c
    action	pathname.h
    action	private.h
    action	read.c
    action	read.h
    action	regex.c
    action	regex.h
    action	require.c
    action	require.h
    action	stream.c
    action	stream.h
    action	string.c
    action	string.h
    action	struct.c
    action	struct.h
    action	time.c
    action	time.h
    action	write.c
    action	write.h
    action	xedit.c
    action	xedit.h
    action	TODO
    action	README
    
    src_dir programs/xedit/lisp/modules
    dst_dir app/xedit/lisp/modules
    
    action	indent.lsp
    action	lisp.lsp
    action	syntax.lsp
    action	xedit.lsp
    action	psql.c
    action	x11.c
    action	xaw.c
    action	xt.c

    src_dir programs/xedit/lisp/modules/progmodes
    dst_dir app/xedit/lisp/modules/progmodes

    action	c.lsp
    action	html.lsp
    action	imake.lsp
    action	lisp.lsp
    action	make.lsp
    action	man.lsp
    action	patch.lsp
    action	rpm.lsp
    action	sgml.lsp
    action	sh.lsp
    action	xconf.lsp
    action	xlog.lsp
    action	xrdb.lsp
    
    src_dir programs/xedit/lisp/re
    dst_dir app/xedit/lisp/re
    
    action	README
    action	re.c
    action	rec.c
    action	re.h
    action	reo.c
    action	rep.h
    action	tests.c
    action	tests.txt
    
    src_dir programs/xedit/lisp/test
    dst_dir app/xedit/lisp/test
    
    action	hello.lsp
    action	list.lsp
    action	math.lsp
    action	psql-1.lsp
    action	psql-2.lsp
    action	psql-3.lsp
    action	regex.lsp
    action	stream.lsp
    action	widgets.lsp

    src_dir programs/xedit/lisp/mp
    dst_dir app/xedit/lisp/mp

    action	mp.c
    action	mp.h
    action	mpi.c
    action	mpr.c

    src_dir programs/xmore
    dst_dir app/xedit

    action	print.h
    action	print.c
    action	printdialog.h
    action	printdialog.c
    action	printdialogprivates.h
}

symlink_app_xfs() {
    src_dir programs/xfs
    dst_dir app/xfs
    
    action	xfs.def
    action	xfs.man
    action	README
    action	config.cpp

    src_dir programs/xfs/difs
    dst_dir app/xfs/difs

    action	atom.c
    action	cache.c
    action	charinfo.c
    action	difsutils.c
    action	dispatch.c
    action	events.c
    action	extensions.c
    action	fontinfo.c
    action	fonts.c
    action	globals.c
    action	initfonts.c
    action	main.c
    action	resource.c
    action	swaprep.c
    action	swapreq.c
    action	tables.c

    src_dir programs/xfs/include
    dst_dir app/xfs/include

    action	access.h
    action	accstr.h
    action	assert.h
    action	auth.h
    action	authstr.h
    action	cache.h
    action	cachestr.h
    action	client.h
    action	clientstr.h
    action	closestr.h
    action	closure.h
    action	difsfn.h
    action	difsfnst.h
    action	difs.h
    action	difsutils.h
    action	dispatch.h
    action	extentst.h
    action	fsevents.h
    action	fsresource.h
    action	globals.h
    action	misc.h
    action	os.h
    action	osstruct.h
    action	servermd.h
    action	site.h
    action	swaprep.h
    action	swapreq.h

    src_dir programs/xfs/os
    dst_dir app/xfs/os

    action	access.c
    action	config.c
    action	config.h
    action	configstr.h
    action	connection.c
    action	daemon.c
    action	error.c
    action	io.c
    action	osdep.h
    action	osglue.c
    action	osinit.c
    action	utils.c
    action	waitfor.c
}

symlink_app_xrx()
{
    src_dir programs/xrx/helper
    dst_dir app/xrx/helper

    action	GetUrl.c
    action	GetUrl.h
    action	helper.c
    action	xrx.man

    src_dir programs/xrx/libxplugin
    dst_dir app/xrx/libxplugin

    action	README
    
    src_dir programs/xrx/rx
    dst_dir app/xrx/rx
    
    action	XDpyName.h
    action	XUrls.h
    action	RxI.h
    action	BuildReq.c
    action	XDpyName.c
    action	Rx.h
    action	Prefs.c
    action	Prefs.h
    action	XAuth.c
    action	PParse.c
    action	XAuth.h
    action	PRead.c
    action	XUrls.c
    
    src_dir programs/xrx/xnest-plugin
    dst_dir app/xrx/xnest-plugin
    
    action	PProcess.c
    action	XnestDis.c
    action	SetWin.c
    action	RxPlugin.h
    action	NewNDest.c
    
    src_dir programs/xrx/htdocs
    dst_dir app/xrx/htdocs
    
    action	xclock
    action	dtcm.html
    action	excel.html
    action	bitmap
    action	bitmap.html
    action	xclock.html
    action	xload
    action	dtcm
    action	xload.html
    action	excel
    
    src_dir programs/xrx/testplugin
    dst_dir app/xrx/testplugin
    
    action	testplugin.man
    action	testplugin.c
    
    src_dir programs/xrx/plugin
    dst_dir app/xrx/plugin
    
    action	PProcess.c
    action	stubs.c
    action	libxrx.man
    action	SetWin.c
    action	Global.c
    action	Main.c
    action	RxPlugin.h
    action	NewNDest.c

    src_dir programs/xrx/plugin/common
    dst_dir app/xrx/plugin/common

    action	npunix.c

    src_dir programs/xrx/plugin/include
    dst_dir app/xrx/plugin/include

    action	npapi.h
    action	npupp.h
    action	jri.h
    action	jri_md.h
    action	jritypes.h
    
    src_dir programs/xrx/cgi-bin
    dst_dir app/xrx/cgi-bin
    
    action	xclock
    action	dtcm.sh
    action	bitmap
    action	xload
    action	dtcm
    action	excel
}

symlink_app() {
    symlink_app_xfs
    symlink_app_xedit
    symlink_app_lbxproxy
    symlink_app_xphelloworld
    symlink_app_xwininfo
    symlink_app_xwd
    symlink_app_xprop
    symlink_app_xwud
    symlink_app_xvinfo
    symlink_app_xvidtune
    symlink_app_xtrap
    symlink_app_xstdcmap
    symlink_app_xsm
    symlink_app_xsetroot
    symlink_app_xsetpointer
    symlink_app_xsetmode
    symlink_app_xset
    symlink_app_xrefresh
    symlink_app_xrdb
    symlink_app_xrandr
    symlink_app_xprehashprinterlist
    symlink_app_xpr
    symlink_app_xplsprinters
    symlink_app_xmore
    symlink_app_xmodmap
    symlink_app_xmh
    symlink_app_xmessage
    symlink_app_xman
    symlink_app_xmag
    symlink_app_xlsfonts
    symlink_app_xlsclients
    symlink_app_xlsatoms
    symlink_app_xlogo
    symlink_app_xload
    symlink_app_xkill
    symlink_app_xkbutils
    symlink_app_xkbprint
    symlink_app_xkbevd
    symlink_app_xkbcomp
    symlink_app_xinit
    symlink_app_xgc
    symlink_app_xgamma
    symlink_app_xfwp
    symlink_app_xfsinfo
    symlink_app_xfontsel
    symlink_app_xfindproxy
    symlink_app_xfd
    symlink_app_xf86dga
    symlink_app_xeyes
    symlink_app_xev
    symlink_app_xdriinfo
    symlink_app_xditview
    symlink_app_xdbedizzy
    symlink_app_xconsole
    symlink_app_xcmsdb
    symlink_app_xclock
    symlink_app_xclipboard
    symlink_app_xcalc
    symlink_app_xbiff
    symlink_app_xauth
    symlink_app_x11perf
    symlink_app_viewres
    symlink_app_smproxy
    symlink_app_showfont
    symlink_app_setxkbmap
    symlink_app_rstart
    symlink_app_rgb
    symlink_app_proxymngr
    symlink_app_pclcomp
    symlink_app_oclock
    symlink_app_mkfontdir
    symlink_app_mkfontscale
    symlink_app_makepsres
    symlink_app_mkcfm
    symlink_app_luit
    symlink_app_listres
    symlink_app_ico
    symlink_app_iceauth
    symlink_app_fstobdf
    symlink_app_fslsfonts
    symlink_app_fonttosfnt
    symlink_app_editres
    symlink_app_bitmap
    symlink_app_beforelight
    symlink_app_bdftopcf
    symlink_app_appres
    symlink_app_twm
    symlink_app_xdpyinfo
    symlink_app_xhost
    symlink_app_xcursorgen
    symlink_app_scripts
    symlink_app_xdm
    symlink_app_sessreg
    symlink_app_xrx
#    ...
}


#########
#
#	The xserver module
#
#########


symlink_xserver_GL_apple() {
    src_dir programs/Xserver/GL/apple
    dst_dir xserver/xorg/GL/apple

    action      aglGlx.c
    action      indirect.c
}

symlink_xserver_GL_dri() {
    src_dir programs/Xserver/GL/dri
    dst_dir xserver/xorg/hw/xfree86/dri

    action      dri.c
    action      dri.h
    action      drimodule.c
    action      dristruct.h
    action      sarea.h
    action      xf86dri.c

    # don't hate me
#    src_dir extras/drm/shared-core
#    action      drm.h
}

symlink_xserver_GL_glx() {
    src_dir programs/Xserver/GL/glx
    dst_dir xserver/xorg/GL/glx

    action      g_disptab.c
    action      g_disptab.h
    action      g_disptab_EXT.c
    action      g_disptab_EXT.h
    action      g_render.c
    action      g_renderswap.c
    action      g_single.c
    action      g_singleswap.c
    action      global.c
    action      glxbuf.c
    action      glxbuf.h
    action      glxcmds.c
    action      glxcmdsswap.c
    action      glxcontext.h
    action      glxdrawable.h
    action      glxerror.h
    action      glxext.c
    action      glxext.h
    action      glxfb.c
    action      glxfb.h
    action      glximports.c
    action      glximports.h
    action      glxmem.c
    action      glxmem.h
    action      glxpix.c
    action      glxpix.h
    action      glxscreens.c
    action      glxscreens.h
    action      glxserver.h
    action      glxutil.c
    action      glxutil.h
    action      impsize.h
    action      render2.c
    action      render2swap.c
    action      renderpix.c
    action      renderpixswap.c
    action      rensize.c
    action      rensizetab.c
    action      single2.c
    action      single2swap.c
    action      singlepix.c
    action      singlepixswap.c
    action      singlesize.c
    action      singlesize.h
    action      unpack.h
    action      xfont.c
}

symlink_xserver_GL_include_GL() {
    src_dir programs/Xserver/GL/include/GL
    dst_dir xserver/xorg/GL/include/GL

    action      glx_ansic.h
    action      xf86glx.h
}

symlink_xserver_GL_mesa_X() {
    src_dir programs/Xserver/GL/mesa/X
    dst_dir xserver/xorg/GL/mesa/X

    action      xf86glx.c
    action      xf86glx_util.c
    action      xf86glx_util.h
    action      xf86glxint.h
}

symlink_xserver_GL_windows() {
    src_dir programs/Xserver/GL/windows
    dst_dir xserver/xorg/GL/windows

    action      glwindows.h
    action      glwrap.c
    action      indirect.c

    action      ChangeLog
}

symlink_xserver_XTrap() {
    src_dir programs/Xserver/XTrap
    dst_dir xserver/xorg/XTrap

    action      xf86XTrapModule.c
    action      xtrapddmi.c
    action      xtrapdi.c
    action      xtrapdiswp.c
    action      xtrapditbl.c
}

symlink_xserver_Xext() {
    src_dir programs/Xserver/Xext
    dst_dir xserver/xorg/Xext

    action      EVI.c
    action      EVIstruct.h
    action      appgroup.c
    action      appgroup.h
    action      bigreq.c
    action      cup.c
    action      dpms.c
    action      dpmsproc.h
    action      dpmsstubs.c
    action      fontcache.c
    action      mbuf.c
    action      mbufbf.c
    action      mbufpx.c
    action      mitmisc.c
    action      panoramiX.c
    action      panoramiX.h
    action      panoramiXSwap.c
    action      panoramiXh.h
    action      panoramiXprocs.c
    action      panoramiXsrv.h
    action      sampleEVI.c
    action      saver.c
    action      security.c
    action      shape.c
    action      shm.c
    action      sleepuntil.c
    action      sleepuntil.h
    action      sync.c
    action      xcmisc.c
    action      xevie.c
    action      xf86bigfont.c
    action      xprint.c
    action      xres.c
    action      xtest.c
    action      xtest1dd.c
    action      xtest1dd.h
    action      xtest1di.c
    action      xvdisp.c
    action      xvdisp.h
    action      xvdix.h
    action      xvmain.c
    action      xvmc.c
    action      xvmcext.h
    action	SecurityPolicy
    action	xtest1.frags	README.xtest1-ddx

    # some of these are really DDX-specific despite being in Xext

    dst_dir xserver/xorg/hw/xfree86/dixmods/extmod
    action      dgaproc.h
    action      vidmodeproc.h
    action      xf86dga.c
    action      xf86dga2.c
    action      xf86dgaext.h
    action      xf86misc.c
    action      xf86miscproc.h
    action      xf86vmode.c
    action      xvmod.c
    action      xvmodproc.h

    dst_dir xserver/xorg/hw/dmx
    action      dmx.c
}

symlink_xserver_Xext_extmod() {
    src_dir programs/Xserver/Xext/extmod
    dst_dir xserver/xorg/hw/xfree86/dixmods/extmod

    action      modinit.c
    action      modinit.h
}

symlink_xserver_Xi() {
    src_dir programs/Xserver/Xi
    dst_dir xserver/xorg/Xi

    action      allowev.c
    action      allowev.h
    action      chgdctl.c
    action      chgdctl.h
    action      chgfctl.c
    action      chgfctl.h
    action      chgkbd.c
    action      chgkbd.h
    action      chgkmap.c
    action      chgkmap.h
    action      chgprop.c
    action      chgprop.h
    action      chgptr.c
    action      chgptr.h
    action      closedev.c
    action      closedev.h
    action      devbell.c
    action      devbell.h
    action      exevents.c
    action      exglobals.h
    action      extinit.c
    action      getbmap.c
    action      getbmap.h
    action      getdctl.c
    action      getdctl.h
    action      getfctl.c
    action      getfctl.h
    action      getfocus.c
    action      getfocus.h
    action      getkmap.c
    action      getkmap.h
    action      getmmap.c
    action      getmmap.h
    action      getprop.c
    action      getprop.h
    action      getselev.c
    action      getselev.h
    action      getvers.c
    action      getvers.h
    action      grabdev.c
    action      grabdev.h
    action      grabdevb.c
    action      grabdevb.h
    action      grabdevk.c
    action      grabdevk.h
    action      gtmotion.c
    action      gtmotion.h
    action      listdev.c
    action      listdev.h
    action      opendev.c
    action      opendev.h
    action      queryst.c
    action      queryst.h
    action      selectev.c
    action      selectev.h
    action      sendexev.c
    action      sendexev.h
    action      setbmap.c
    action      setbmap.h
    action      setdval.c
    action      setdval.h
    action      setfocus.c
    action      setfocus.h
    action      setmmap.c
    action      setmmap.h
    action      setmode.c
    action      setmode.h
    action      stubs.c
    action      ungrdev.c
    action      ungrdev.h
    action      ungrdevb.c
    action      ungrdevb.h
    action      ungrdevk.c
    action      ungrdevk.h
}

symlink_xserver_Xprint() {
    src_dir programs/Xserver/Xprint
    dst_dir xserver/xorg/Xprint

    action      AttrValid.c
    action      AttrValid.h
    action      DiPrint.h
    action      Init.c
    action      Oid.c
    action      Oid.h
    action      OidDefs.h
    action      OidStrs.h
    action      Util.c
    action      ValTree.c
    action      attributes.c
    action      attributes.h
    action      ddxInit.c
    action      mediaSizes.c
    action      spooler.c
    action      spooler.h

    dst_dir xserver/xorg/Xprint/doc
    action	Xprt.html
    action	Xprt.man Xprt.man.pre
    action	Xprt.sgml
}

symlink_xserver_Xprint_etc() {
    src_dir programs/Xserver/Xprint/etc/init.d
    dst_dir xserver/xorg/Xprint/etc/init.d

    action	xprint.cpp

    src_dir programs/Xserver/Xprint/etc/profile.d
    dst_dir xserver/xorg/Xprint/etc/profile.d

    action	xprint.csh
    action	xprint.sh

    src_dir programs/Xserver/Xprint/etc/Xsession.d
    dst_dir xserver/xorg/Xprint/etc/Xsession.d

    action	cde_xsessiond_xprint.sh
}

symlink_xserver_Xprint_ps() {
    src_dir programs/Xserver/Xprint/ps
    dst_dir xserver/xorg/Xprint/ps

    action      Ps.h
    action      PsArc.c
    action      PsArea.c
    action      PsAttVal.c
    action      PsAttr.c
    action      PsCache.c
    action      PsColor.c
    action      PsDef.h
    action      PsFTFonts.c
    action      PsFonts.c
    action      PsGC.c
    action      PsImageUtil.c
    action      PsInit.c
    action      PsLine.c
    action      PsMisc.c
    action      PsPixel.c
    action      PsPixmap.c
    action      PsPolygon.c
    action      PsPrint.c
    action      PsSpans.c
    action      PsText.c
    action      PsWindow.c
    action      psout.c
    action      psout.h
    action      psout_ft.c
    action      psout_ftpstype1.c
    action      psout_ftpstype3.c
    action      ttf2pt1wrap.c
}

symlink_xserver_Xprint_pcl() {
    src_dir programs/Xserver/Xprint/pcl
    dst_dir xserver/xorg/Xprint/pcl

    action      Pcl.h
    action      PclArc.c
    action      PclArea.c
    action      PclAttVal.c
    action      PclAttr.c
    action      PclColor.c
    action      PclCursor.c
    action      PclDef.h
    action      PclFonts.c
    action      PclGC.c
    action      PclInit.c
    action      PclLine.c
    action      PclMisc.c
    action      PclPixel.c
    action      PclPixmap.c
    action      PclPolygon.c
    action      PclPrint.c
    action      PclSFonts.c
    action      PclSFonts.h
    action      PclSpans.c
    action      PclText.c
    action      PclWindow.c
    action      Pclmap.h
}

symlink_xserver_Xprint_raster() {
    src_dir programs/Xserver/Xprint/raster
    dst_dir xserver/xorg/Xprint/raster

    action      Raster.c
    action      Raster.h
    action      RasterAttVal.c
}

symlink_xserver_afb() {
    src_dir programs/Xserver/afb
    dst_dir xserver/xorg/afb

    action      afb.h
    action      afbbitblt.c
    action      afbblt.c
    action      afbbres.c
    action      afbbresd.c
    action      afbbstore.c
    action      afbclip.c
    action      afbcmap.c
    action      afbfillarc.c
    action      afbfillrct.c
    action      afbfillsp.c
    action      afbfont.c
    action      afbgc.c
    action      afbgetsp.c
    action      afbhrzvert.c
    action      afbimage.c
    action      afbimggblt.c
    action      afbline.c
    action      afbmisc.c
    action      afbpixmap.c
    action      afbply1rct.c
    action      afbplygblt.c
    action      afbpntarea.c
    action      afbpntwin.c
    action      afbpolypnt.c
    action      afbpushpxl.c
    action      afbscrinit.c
    action      afbsetsp.c
    action      afbtegblt.c
    action      afbtile.c
    action      afbwindow.c
    action      afbzerarc.c

    action      README
    action      Xdaniver.doc
}

symlink_xserver_cfb() {
    src_dir programs/Xserver/cfb
    dst_dir xserver/xorg/cfb

    action      cfb.h
    action      cfb16.h
    action      cfb24.h
    action      cfb32.h
    action      cfb8bit.c
    action      cfb8bit.h
    action      cfb8line.c
    action      cfballpriv.c
    action      cfbbitblt.c
    action      cfbblt.c
    action      cfbbres.c
    action      cfbbresd.c
    action      cfbbstore.c
    action      cfbcmap.c
    action      cfbcppl.c
    action      cfbfillarc.c
    action      cfbfillrct.c
    action      cfbfillsp.c
    action      cfbgc.c
    action      cfbgetsp.c
    action      cfbglblt8.c
    action      cfbhrzvert.c
    action      cfbigblt8.c
    action      cfbimage.c
    action      cfbline.c
    action      cfbmap.h
    action      cfbmskbits.c
    action      cfbmskbits.h
    action      cfbpixmap.c
    action      cfbply1rct.c
    action      cfbpntwin.c
    action      cfbpolypnt.c
    action      cfbpush8.c
    action      cfbrctstp8.c
    action      cfbrrop.c
    action      cfbrrop.h
    action      cfbscrinit.c
    action      cfbsetsp.c
    action      cfbsolid.c
    action      cfbtab.h
    action      cfbteblt8.c
    action      cfbtegblt.c
    action      cfbtile32.c
    action      cfbtileodd.c
    action      cfbunmap.h
    action      cfbwindow.c
    action      cfbzerarc.c
    action      stip68kgnu.h
    action      stipmips.s
    action      stipsparc.s
    action      stipsprc32.s
}

symlink_xserver_cfb24() {
    src_dir programs/Xserver/cfb24
    dst_dir xserver/xorg/cfb24

    action      cfbrrop24.h
}

symlink_xserver_composite() {
    src_dir programs/Xserver/composite
    dst_dir xserver/xorg/composite

    action      compalloc.c
    action      compext.c
    action      compinit.c
    action      compint.h
    action      compwindow.c
}

symlink_xserver_damageext() {
    src_dir programs/Xserver/damageext
    dst_dir xserver/xorg/damageext

    action      damageext.c
    action      damageext.h
    action      damageextint.h
}

symlink_xserver_dbe() {
    src_dir programs/Xserver/dbe
    dst_dir xserver/xorg/dbe

    action      dbe.c
    action      dbestruct.h
    action      midbe.c
    action      midbe.h
    action      midbestr.h
}

symlink_xserver_dix() {
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

symlink_xserver_fb() {
    src_dir programs/Xserver/fb
    dst_dir xserver/xorg/fb

    action      fb.h
    action      fb24_32.c
    action      fb24_32.h
    action      fballpriv.c
    action      fbarc.c
    action      fbbits.c
    action      fbbits.h
    action      fbblt.c
    action      fbbltone.c
    action      fbbstore.c
    action      fbcmap.c
    action      fbcompose.c
    action      fbcopy.c
    action      fbedge.c
    action      fbedgeimp.h
    action      fbfill.c
    action      fbfillrect.c
    action      fbfillsp.c
    action      fbgc.c
    action      fbgetsp.c
    action      fbglyph.c
    action      fbimage.c
    action      fbline.c
    action      fbmmx.c
    action      fbmmx.h
    action      fboverlay.c
    action      fboverlay.h
    action      fbpict.c
    action      fbpict.h
    action      fbpixmap.c
    action      fbpoint.c
    action      fbpseudocolor.c
    action      fbpseudocolor.h
    action      fbpush.c
    action      fbrop.h
    action      fbscreen.c
    action      fbseg.c
    action      fbsetsp.c
    action      fbsolid.c
    action      fbstipple.c
    action      fbtile.c
    action      fbtrap.c
    action      fbutil.c
    action      fbwindow.c
}

symlink_xserver_hw_darwin() {
    src_dir programs/Xserver/hw/darwin
    dst_dir xserver/xorg/hw/darwin

    action      darwin.c
    action      darwin.h
    action      darwinClut8.h
    action      darwinEvents.c
    action      darwinKeyboard.c
    action      darwinKeyboard.h
    action      darwinXinput.c

    action      XDarwin.man
}

symlink_xserver_hw_darwin_bundle() {
    src_dir programs/Xserver/hw/darwin/bundle
    dst_dir xserver/xorg/hw/darwin/bundle

    action	startXClients.cpp
    action	XDarwin.icns

    src_dir programs/Xserver/hw/darwin/bundle/Dutch.lproj
    dst_dir xserver/xorg/hw/darwin/bundle/Dutch.lproj

    action	Credits.rtf
    action	Localizable.strings
    action	XDarwinHelp.html.cpp

    src_dir programs/Xserver/hw/darwin/bundle/Dutch.lproj/MainMenu.nib
    dst_dir xserver/xorg/hw/darwin/bundle/Dutch.lproj/MainMenu.nib

    action classes.nib
    action objects.nib

    src_dir programs/Xserver/hw/darwin/bundle/English.lproj
    dst_dir xserver/xorg/hw/darwin/bundle/English.lproj

    action	Credits.rtf
    action	InfoPlist.strings.cpp
    action	Localizable.strings
    action	XDarwinHelp.html.cpp

    src_dir programs/Xserver/hw/darwin/bundle/English.lproj/MainMenu.nib
    dst_dir xserver/xorg/hw/darwin/bundle/English.lproj/MainMenu.nib

    action classes.nib
    action objects.nib

    src_dir programs/Xserver/hw/darwin/bundle/French.lproj
    dst_dir xserver/xorg/hw/darwin/bundle/French.lproj

    action	Credits.rtf
    action	Localizable.strings
    action	XDarwinHelp.html.cpp

    src_dir programs/Xserver/hw/darwin/bundle/French.lproj/MainMenu.nib
    dst_dir xserver/xorg/hw/darwin/bundle/French.lproj/MainMenu.nib

    action classes.nib
    action objects.nib

    src_dir programs/Xserver/hw/darwin/bundle/German.lproj
    dst_dir xserver/xorg/hw/darwin/bundle/German.lproj

    action	Credits.rtf
    action	Localizable.strings
    action	XDarwinHelp.html.cpp

    src_dir programs/Xserver/hw/darwin/bundle/German.lproj/MainMenu.nib
    dst_dir xserver/xorg/hw/darwin/bundle/German.lproj/MainMenu.nib

    action classes.nib
    action objects.nib

    src_dir programs/Xserver/hw/darwin/bundle/Japanese.lproj
    dst_dir xserver/xorg/hw/darwin/bundle/Japanese.lproj

    action	Credits.rtf
    action	Localizable.strings
    action	XDarwinHelp.html.cpp

    src_dir programs/Xserver/hw/darwin/bundle/Japanese.lproj/MainMenu.nib
    dst_dir xserver/xorg/hw/darwin/bundle/Japanese.lproj/MainMenu.nib

    action classes.nib
    action objects.nib

    src_dir programs/Xserver/hw/darwin/bundle/ko.lproj
    dst_dir xserver/xorg/hw/darwin/bundle/ko.lproj

    action	Credits.rtf
    action	Localizable.strings
    action	XDarwinHelp.html.cpp

    src_dir programs/Xserver/hw/darwin/bundle/ko.lproj/MainMenu.nib
    dst_dir xserver/xorg/hw/darwin/bundle/ko.lproj/MainMenu.nib

    action classes.nib
    action objects.nib

    src_dir programs/Xserver/hw/darwin/bundle/Portuguese.lproj
    dst_dir xserver/xorg/hw/darwin/bundle/Portuguese.lproj

    action	Credits.rtf
    action	Localizable.strings
    action	XDarwinHelp.html.cpp

    src_dir programs/Xserver/hw/darwin/bundle/Portuguese.lproj/MainMenu.nib
    dst_dir xserver/xorg/hw/darwin/bundle/Portuguese.lproj/MainMenu.nib

    action classes.nib
    action objects.nib

    src_dir programs/Xserver/hw/darwin/bundle/Spanish.lproj
    dst_dir xserver/xorg/hw/darwin/bundle/Spanish.lproj

    action	Credits.rtf
    action	Localizable.strings
    action	XDarwinHelp.html.cpp

    src_dir programs/Xserver/hw/darwin/bundle/Spanish.lproj/MainMenu.nib
    dst_dir xserver/xorg/hw/darwin/bundle/Spanish.lproj/MainMenu.nib

    action classes.nib
    action objects.nib

    src_dir programs/Xserver/hw/darwin/bundle/Swedish.lproj
    dst_dir xserver/xorg/hw/darwin/bundle/Swedish.lproj

    action	Credits.rtf
    action	Localizable.strings
    action	XDarwinHelp.html.cpp

    src_dir programs/Xserver/hw/darwin/bundle/Swedish.lproj/MainMenu.nib
    dst_dir xserver/xorg/hw/darwin/bundle/Swedish.lproj/MainMenu.nib

    action classes.nib
    action objects.nib
}

symlink_xserver_hw_darwin_iokit() {
    src_dir programs/Xserver/hw/darwin/iokit
    dst_dir xserver/xorg/hw/darwin/iokit

    action      xfIOKit.c
    action      xfIOKit.h
    action      xfIOKitCursor.c
    action      xfIOKitStartup.c
}

symlink_xserver_hw_darwin_quartz() {
    src_dir programs/Xserver/hw/darwin/quartz
    dst_dir xserver/xorg/hw/darwin/quartz

    action      Preferences.h
    action      XApplication.h
    action      XDarwinStartup.c
    action      XServer.h
    action      applewm.c
    action      applewmExt.h
    action      keysym2ucs.c
    action      keysym2ucs.h
    action      pseudoramiX.c
    action      pseudoramiX.h
    action      quartz.c
    action      quartz.h
    action      quartzAudio.c
    action      quartzAudio.h
    action      quartzCommon.h
    action      quartzCursor.c
    action      quartzCursor.h
    action      quartzKeyboard.c
    action      quartzPasteboard.c
    action      quartzPasteboard.h
    action      quartzStartup.c

    action	Preferences.m
    action	quartzCocoa.m
    action	XApplication.m
    action	XServer.m

    action	XDarwinStartup.man

    src_dir programs/Xserver/hw/darwin/quartz/XDarwin.pbproj
    dst_dir xserver/xorg/hw/darwin/quartz/XDarwin.pbproj
    action	project.pbxproj
}

symlink_xserver_hw_darwin_quartz_cr() {
    src_dir programs/Xserver/hw/darwin/quartz/cr
    dst_dir xserver/xorg/hw/darwin/quartz/cr

    action      XView.h
    action      cr.h

    action	crAppleWM.m
    action	crFrame.m
    action	crScreen.m
    action	XView.m
}

symlink_xserver_hw_darwin_quartz_fullscreen() {
    src_dir programs/Xserver/hw/darwin/quartz/fullscreen
    dst_dir xserver/xorg/hw/darwin/quartz/fullscreen

    action      fullscreen.c
    action      quartzCursor.c
    action      quartzCursor.h
}

symlink_xserver_hw_darwin_quartz_xpr() {
    src_dir programs/Xserver/hw/darwin/quartz/xpr
    dst_dir xserver/xorg/hw/darwin/quartz/xpr

    action      Xplugin.h
    action      appledri.c
    action      dri.c
    action      dri.h
    action      dristruct.h
    action      x-hash.c
    action      x-hash.h
    action      x-hook.c
    action      x-hook.h
    action      x-list.c
    action      x-list.h
    action      xpr.h
    action      xprAppleWM.c
    action      xprCursor.c
    action      xprFrame.c
    action      xprScreen.c
}

symlink_xserver_hw_darwin_utils() {
    src_dir programs/Xserver/hw/darwin/utils
    dst_dir xserver/xorg/hw/darwin/utils

    action	dumpkeymap.c
    action	dumpkeymap.man
    action	README.txt
}

symlink_xserver_hw_dmx() {
    src_dir programs/Xserver/hw/dmx
    dst_dir xserver/xorg/hw/dmx

    action      dmx.h
    action      dmx_glxvisuals.c
    action      dmx_glxvisuals.h
    action      dmxcb.c
    action      dmxcb.h
    action      dmxclient.h
    action      dmxcmap.c
    action      dmxcmap.h
    action      dmxcursor.c
    action      dmxcursor.h
    action      dmxdpms.c
    action      dmxdpms.h
    action      dmxextension.c
    action      dmxextension.h
    action      dmxfont.c
    action      dmxfont.h
    action      dmxgc.c
    action      dmxgc.h
    action      dmxgcops.c
    action      dmxgcops.h
    action      dmxinit.c
    action      dmxinit.h
    action      dmxinput.c
    action      dmxinput.h
    action      dmxlog.c
    action      dmxlog.h
    action      dmxpict.c
    action      dmxpict.h
    action      dmxpixmap.c
    action      dmxpixmap.h
    action      dmxprop.c
    action      dmxprop.h
    action      dmxscrinit.c
    action      dmxscrinit.h
    action      dmxshadow.c
    action      dmxshadow.h
    action      dmxstat.c
    action      dmxstat.h
    action      dmxsync.c
    action      dmxsync.h
    action      dmxvisual.c
    action      dmxvisual.h
    action      dmxwindow.c
    action      dmxwindow.h

    action      Xdmx.man		Xdmx.1
}

symlink_xserver_hw_dmx_config() {
    src_dir programs/Xserver/hw/dmx/config
    dst_dir xserver/xorg/hw/dmx/config

    action	Canvas.c
    action	Canvas.h
    action	CanvasP.h
    action	dmxcompat.c
    action	dmxcompat.h
    action	dmxconfig.c
    action	dmxconfig.h
    action	dmxparse.c
    action	dmxparse.h
    action	dmxprint.c
    action	dmxprint.h
    action	dmxtodmx.c
    action	dmxtodmx.man
    action	parser.y
    action	scanner.l
    action	test-a.in
    action	test-a.out
    action	test-b.in
    action	test-b.out
    action	test-c.in
    action	test-c.out
    action	test-d.in
    action	test-d.out
    action	test-e.in
    action	test-e.out
    action	test-f.in
    action	test-f.out
    action	test-g.in
    action	test-g.out
    action	test-h.in
    action	test-h.out
    action	test-i.in
    action	test-i.out
    action	test-j.in
    action	test-j.out
    action	test-k.in
    action	test-k.out
    action	test-l.in
    action	test-l.out
    action	TODO
    action	vdltodmx.c
    action	vdltodmx.man
    action	xdmxconfig.c
    action	xdmxconfig.man
}

symlink_xserver_hw_dmx_doc() {
    src_dir programs/Xserver/hw/dmx/doc
    dst_dir xserver/xorg/hw/dmx/doc

    action      dmx.sgml
    action      DMXSpec.txt
    action      DMXSpec-v1.txt
    action      dmx.txt
    action      doxygen.conf
    action      doxygen.css
    action      doxygen.foot
    action      doxygen.head
    action      scaled.sgml
    action      scaled.txt

    src_dir programs/Xserver/hw/dmx/doc/html
    dst_dir xserver/xorg/hw/dmx/doc/html

    action      annotated.html
    action      ChkNotMaskEv_8c.html
    action      ChkNotMaskEv_8h.html
    action      ChkNotMaskEv_8h-source.html
    action      classes.html
    action      dmx_8h.html
    action      dmx_8h-source.html
    action      dmxarg_8c.html
    action      dmxarg_8h.html
    action      dmxarg_8h-source.html
    action      dmxbackend_8c.html
    action      dmxbackend_8h.html
    action      dmxbackend_8h-source.html
    action      dmxcb_8c.html
    action      dmxcb_8h.html
    action      dmxcb_8h-source.html
    action      dmxclient_8h.html
    action      dmxclient_8h-source.html
    action      dmxcmap_8c.html
    action      dmxcmap_8h.html
    action      dmxcmap_8h-source.html
    action      dmxcommon_8c.html
    action      dmxcommon_8h.html
    action      dmxcommon_8h-source.html
    action      dmxcompat_8c.html
    action      dmxcompat_8h.html
    action      dmxcompat_8h-source.html
    action      dmxconfig_8c.html
    action      dmxconfig_8h.html
    action      dmxconfig_8h-source.html
    action      dmxconsole_8c.html
    action      dmxconsole_8h.html
    action      dmxconsole_8h-source.html
    action      dmxcursor_8c.html
    action      dmxcursor_8h.html
    action      dmxcursor_8h-source.html
    action      dmxdetach_8c.html
    action      dmxdpms_8c.html
    action      dmxdpms_8h.html
    action      dmxdpms_8h-source.html
    action      dmxdummy_8c.html
    action      dmxdummy_8h.html
    action      dmxdummy_8h-source.html
    action      dmxeq_8c.html
    action      dmxeq_8h.html
    action      dmxeq_8h-source.html
    action      dmxevents_8c.html
    action      dmxevents_8h.html
    action      dmxevents_8h-source.html
    action      dmxext_8h.html
    action      dmxext_8h-source.html
    action      dmxextension_8c.html
    action      dmxextension_8h.html
    action      dmxextension_8h-source.html
    action      dmxfont_8c.html
    action      dmxfont_8h.html
    action      dmxfont_8h-source.html
    action      dmxgc_8c.html
    action      dmxgc_8h.html
    action      dmxgc_8h-source.html
    action      dmxgcops_8c.html
    action      dmxgcops_8h.html
    action      dmxgcops_8h-source.html
    action      dmx__glxvisuals_8h-source.html
    action      dmxinit_8c.html
    action      dmxinit_8h.html
    action      dmxinit_8h-source.html
    action      dmxinput_8c.html
    action      dmxinput_8h.html
    action      dmxinput_8h-source.html
    action      dmxinputinit_8c.html
    action      dmxinputinit_8h.html
    action      dmxinputinit_8h-source.html
    action      dmxlog_8c.html
    action      dmxlog_8h.html
    action      dmxlog_8h-source.html
    action      dmxmap_8c.html
    action      dmxmap_8h.html
    action      dmxmap_8h-source.html
    action      dmxmotion_8c.html
    action      dmxmotion_8h.html
    action      dmxmotion_8h-source.html
    action      dmxparse_8c.html
    action      dmxparse_8h.html
    action      dmxparse_8h-source.html
    action      dmxpict_8c.html
    action      dmxpict_8h.html
    action      dmxpict_8h-source.html
    action      dmxpixmap_8c.html
    action      dmxpixmap_8h.html
    action      dmxpixmap_8h-source.html
    action      dmxprint_8c.html
    action      dmxprint_8h.html
    action      dmxprint_8h-source.html
    action      dmxprop_8c.html
    action      dmxprop_8h.html
    action      dmxprop_8h-source.html
    action      dmxproto_8h.html
    action      dmxproto_8h-source.html
    action      dmxscrinit_8c.html
    action      dmxscrinit_8h.html
    action      dmxscrinit_8h-source.html
    action      dmxshadow_8c.html
    action      dmxshadow_8h.html
    action      dmxshadow_8h-source.html
    action      dmxsigio_8c.html
    action      dmxsigio_8h.html
    action      dmxsigio_8h-source.html
    action      dmxstat_8c.html
    action      dmxstat_8h.html
    action      dmxstat_8h-source.html
    action      dmxsync_8c.html
    action      dmxsync_8h.html
    action      dmxsync_8h-source.html
    action      dmxvisual_8c.html
    action      dmxvisual_8h.html
    action      dmxvisual_8h-source.html
    action      dmxwindow_8c.html
    action      dmxwindow_8h.html
    action      dmxwindow_8h-source.html
    action      dmxxinput_8c.html
    action      doxygen.css
    action      doxygen.png
    action      files.html
    action      ftv2blank.png
    action      ftv2doc.png
    action      ftv2folderclosed.png
    action      ftv2folderopen.png
    action      ftv2lastnode.png
    action      ftv2link.png
    action      ftv2mlastnode.png
    action      ftv2mnode.png
    action      ftv2node.png
    action      ftv2plastnode.png
    action      ftv2pnode.png
    action      ftv2vertline.png
    action      functions.html
    action      functions_vars.html
    action      globals_defs.html
    action      globals_enum.html
    action      globals_eval.html
    action      globals_func.html
    action      globals.html
    action      globals_type.html
    action      globals_vars.html
    action      index.html
    action      lib_2dmx_2dmx_8c.html
    action      lnx-keyboard_8c.html
    action      lnx-keyboard_8h.html
    action      lnx-keyboard_8h-source.html
    action      lnx-ms_8c.html
    action      lnx-ms_8h.html
    action      lnx-ms_8h-source.html
    action      lnx-ps2_8c.html
    action      lnx-ps2_8h.html
    action      lnx-ps2_8h-source.html
    action      main.html
    action      programs_2Xserver_2Xext_2dmx_8c.html
    action      struct__dmxArg.html
    action      struct__dmxColormapPriv.html
    action      structDMXConfigCmdStruct.html
    action      struct__DMXConfigComment.html
    action      struct__DMXConfigDisplay.html
    action      struct__DMXConfigEntry.html
    action      struct__DMXConfigFullDim.html
    action      structDMXConfigListStruct.html
    action      struct__DMXConfigNumber.html
    action      struct__DMXConfigOption.html
    action      struct__DMXConfigPair.html
    action      struct__DMXConfigParam.html
    action      struct__DMXConfigPartDim.html
    action      struct__DMXConfigString.html
    action      struct__DMXConfigSub.html
    action      struct__DMXConfigToken.html
    action      struct__DMXConfigVirtual.html
    action      struct__DMXConfigWall.html
    action      struct__dmxCursorPriv.html
    action      structDMXDesktopAttributes.html
    action      structDMXDesktopAttributesRec.html
    action      struct__DMXEventMap.html
    action      struct__dmxFontPriv.html
    action      struct__dmxGCPriv.html
    action      structdmxGlxVisualPrivate.html
    action      struct__dmxGlyphPriv.html
    action      structDMXInputAttributes.html
    action      structDMXInputAttributesRec.html
    action      struct__DMXInputInfo.html
    action      struct__DMXLocalInitInfo.html
    action      struct__DMXLocalInputInfo.html
    action      struct__dmxPictPriv.html
    action      struct__dmxPixPriv.html
    action      structDMXScreenAttributes.html
    action      structDMXScreenAttributesRec.html
    action      struct__DMXScreenInfo.html
    action      struct__DMXStatAvg.html
    action      struct__DMXStatInfo.html
    action      structDMXWindowAttributes.html
    action      structDMXWindowAttributesRec.html
    action      struct__dmxWinPriv.html
    action      struct__Event.html
    action      struct__EventQueue.html
    action      struct__myPrivate.html
    action      structxDMXAddInputReply.html
    action      structxDMXAddInputReq.html
    action      structxDMXAddScreenReply.html
    action      structxDMXAddScreenReq.html
    action      structxDMXChangeDesktopAttributesReply.html
    action      structxDMXChangeDesktopAttributesReq.html
    action      structxDMXChangeScreensAttributesReply.html
    action      structxDMXChangeScreensAttributesReq.html
    action      structxDMXForceWindowCreationReply.html
    action      structxDMXForceWindowCreationReq.html
    action      structxDMXGetDesktopAttributesReply.html
    action      structxDMXGetDesktopAttributesReq.html
    action      structxDMXGetInputAttributesReply.html
    action      structxDMXGetInputAttributesReq.html
    action      structxDMXGetInputCountReply.html
    action      structxDMXGetInputCountReq.html
    action      structxDMXGetScreenAttributesReply.html
    action      structxDMXGetScreenAttributesReq.html
    action      structxDMXGetScreenCountReply.html
    action      structxDMXGetScreenCountReq.html
    action      structxDMXGetWindowAttributesReply.html
    action      structxDMXGetWindowAttributesReq.html
    action      structxDMXQueryVersionReply.html
    action      structxDMXQueryVersionReq.html
    action      structxDMXRemoveInputReply.html
    action      structxDMXRemoveInputReq.html
    action      structxDMXRemoveScreenReply.html
    action      structxDMXRemoveScreenReq.html
    action      structxDMXSyncReply.html
    action      structxDMXSyncReq.html
    action      tree.html
    action      usb-common_8c.html
    action      usb-common_8h.html
    action      usb-common_8h-source.html
    action      usb-keyboard_8c.html
    action      usb-keyboard_8h.html
    action      usb-keyboard_8h-source.html
    action      usb-mouse_8c.html
    action      usb-mouse_8h.html
    action      usb-mouse_8h-source.html
    action      usb-other_8c.html
    action      usb-other_8h.html
    action      usb-other_8h-source.html
    action      usb-private_8h.html
    action      usb-private_8h-source.html
}

symlink_xserver_hw_dmx_examples() {
    src_dir programs/Xserver/hw/dmx/examples
    dst_dir xserver/xorg/hw/dmx/examples

    action      dmxaddinput.c
    action      dmxaddscreen.c
    action      dmxreconfig.c
    action      dmxresize.c
    action      dmxrminput.c
    action      dmxrmscreen.c
    action      dmxwininfo.c
    action      ev.c
    action      evi.c
    action      res.c
    action      xbell.c
    action      xdmx.c
    action      xinput.c
    action      xled.c
    action      xtest.c
}

symlink_xserver_hw_dmx_glxProxy() {
    src_dir programs/Xserver/hw/dmx/glxProxy
    dst_dir xserver/xorg/hw/dmx/glxProxy

    action      compsize.c
    action      g_disptab.c
    action      g_disptab.h
    action      g_renderswap.c
    action      global.c
    action      glxcmds.c
    action      glxcmdsswap.c
    action      glxcontext.h
    action      glxdrawable.h
    action      glxerror.h
    action      glxext.c
    action      glxext.h
    action      glxfbconfig.c
    action      glxfbconfig.h
    action      glxscreens.c
    action      glxscreens.h
    action      glxserver.h
    action      glxsingle.c
    action      glxsingle.h
    action      glxswap.c
    action      glxswap.h
    action      glxutil.c
    action      glxutil.h
    action      glxvendor.c
    action      glxvendor.h
    action      glxvisuals.c
    action      glxvisuals.h
    action      render2swap.c
    action      renderpixswap.c
    action      unpack.h
}

symlink_xserver_hw_dmx_input() {
    src_dir programs/Xserver/hw/dmx/input
    dst_dir xserver/xorg/hw/dmx/input

    action      ChkNotMaskEv.c
    action      ChkNotMaskEv.h
    action      dmxarg.c
    action      dmxarg.h
    action      dmxbackend.c
    action      dmxbackend.h
    action      dmxcommon.c
    action      dmxcommon.h
    action      dmxconsole.c
    action      dmxconsole.h
    action      dmxdetach.c
    action      dmxdummy.c
    action      dmxdummy.h
    action      dmxeq.c
    action      dmxeq.h
    action      dmxevents.c
    action      dmxevents.h
    action      dmxinputinit.c
    action      dmxinputinit.h
    action      dmxmap.c
    action      dmxmap.h
    action      dmxmotion.c
    action      dmxmotion.h
    action      dmxsigio.c
    action      dmxsigio.h
    action      dmxxinput.c
    action      lnx-keyboard.c
    action      lnx-keyboard.h
    action      lnx-ms.c
    action      lnx-ms.h
    action      lnx-ps2.c
    action      lnx-ps2.h
    action      usb-common.c
    action      usb-common.h
    action      usb-keyboard.c
    action      usb-keyboard.h
    action      usb-mouse.c
    action      usb-mouse.h
    action      usb-other.c
    action      usb-other.h
    action      usb-private.h
}

# We skip most of Xserver/hw/sun since it's no longer maintained, but a
# couple of files are useful still
symlink_xserver_hw_sun() {
    src_dir programs/Xserver/hw/sun

    dst_dir xserver/xorg/hw/xfree86/utils/kbd_mode
    action  kbd_mode.c   sun-kbd_mode.c
    action  kbd_mode.man sun-kbd_mode.man.pre

    dst_dir app/constype
    action  constype.c
    action  constype.man
}

symlink_xserver_hw_vfb() {
    src_dir programs/Xserver/hw/vfb
    dst_dir xserver/xorg/hw/vfb

    action      InitInput.c
    action      InitOutput.c
    action      lk201kbd.h

    action      Xvfb.man Xvfb.man.pre
}

symlink_xserver_hw_xfree86() {
    src_dir programs/Xserver/hw/xfree86
    dst_dir xserver/xorg/hw/xfree86

    action	xorgconf.cpp
    action	Options
}

symlink_xserver_hw_xfree86_common() {
    src_dir programs/Xserver/hw/xfree86/common
    dst_dir xserver/xorg/hw/xfree86/common

    action      atKeynames.h
    action      compiler.h
    action      fourcc.h
    action      scoasm.h
    action      xf86.h
    action      xf86AutoConfig.c
    action      xf86Bus.c
    action      xf86Bus.h
    action      xf86Config.c
    action      xf86Config.h
    action      xf86Configure.c
    action      xf86Cursor.c
    action      xf86DGA.c
    action      xf86DPMS.c
    action      xf86Debug.c
    action      xf86DefModes.c
    action      xf86DoProbe.c
    action      xf86DoScanPci.c
    action      xf86Events.c
    action      xf86Globals.c
    action      xf86Helper.c
    action      xf86InPriv.h
    action      xf86Init.c
    action      xf86Io.c
    action      xf86Kbd.c
    action      xf86KbdBSD.c
    action      xf86KbdLnx.c
    action      xf86KbdMach.c
    action      xf86Keymap.h
    action      xf86MiscExt.c
    action      xf86Mode.c
    action      xf86Module.h
    action      xf86Opt.h
    action      xf86Option.c
    action      xf86PM.c
    action      xf86PciInfo.h
    action      xf86Priv.h
    action      xf86Privstr.h
    action      xf86RandR.c
    action      xf86Resources.h
    action      xf86Versions.c
    action      xf86VidMode.c
    action      xf86XKB.c
    action      xf86Xinput.c
    action      xf86Xinput.h
    action      xf86cmap.c
    action      xf86cmap.h
    action      xf86fbBus.c
    action      xf86fbman.c
    action      xf86fbman.h
    action      xf86isaBus.c
    action      xf86noBus.c
    action      xf86pciBus.c
    action      xf86pciBus.h
    action      xf86sbusBus.c
    action      xf86sbusBus.h
    action      xf86str.h
    action      xf86xv.c
    action      xf86xv.h
    action      xf86xvmc.c
    action      xf86xvmc.h
    action      xf86xvpriv.h
    action      xisb.c
    action      xisb.h
    action      xorgHelper.c

    action      modeline2c.pl

    src_dir programs/Xserver/hw/xfree86
    action	xf86Date.h
    action	xf86Version.h
    action	xorgVersion.h
}

symlink_xserver_hw_xfree86_ddc() {
    src_dir programs/Xserver/hw/xfree86/ddc
    dst_dir xserver/xorg/hw/xfree86/ddc

    action      ddcPriv.h
    action      ddcProperty.c
    action      edid.c
    action      edid.h
    action      interpret_edid.c
    action      interpret_vdif.c
    action      print_edid.c
    action      print_vdif.c
    action      vdif.h
    action      xf86DDC.c
    action      xf86DDC.h

    action	DDC.HOWTO
}

symlink_xserver_hw_xfree86_doc() {

# Docs generic to all Xservers in xserver-xorg module:
    src_dir programs/Xserver
    dst_dir xserver/xorg/doc
    action  Xserver.man Xserver.man.pre

    src_dir programs/Xserver/hw/xfree86/doc
    dst_dir xserver/xorg/doc
    action  smartsched

# Docs specific to XFree86 DDX/Xorg server:

    src_dir programs/Xserver/hw/xfree86
    dst_dir xserver/xorg/hw/xfree86/doc/man

    action  Xorg.man Xorg.man.pre
    action  xorg.conf.man xorg.conf.man.pre

    dst_dir xserver/xorg/hw/xfree86/doc/devel
    action  DebuggingHints
    action  Domain.note
    action  RAC.Notes
    action  Registry

    dst_dir xserver/xorg/hw/xfree86/doc/changelogs
    action	CHANGELOG
    action	CHANGELOG.ND
    action	CHANGELOG.R5

    src_dir programs/Xserver/hw/xfree86/doc
    dst_dir xserver/xorg/hw/xfree86/doc/devel
    action  exa-driver.txt
    action  README.DRIcomp

    dst_dir xserver/xorg/hw/xfree86/doc
    action	README.DRI
    action	README.fonts
    action	README.rapidaccess

    src_dir programs/Xserver/hw/xfree86/doc/sgml
    dst_dir xserver/xorg/hw/xfree86/doc/sgml

    action  DESIGN.sgml

# Docs about the entire Xorg distribution:

    dst_dir doc/old/sgml
    action  Darwin.sgml
    action  Install.sgml
    action  LICENSE.sgml
    action  LynxOS.sgml
    action  NetBSD.sgml
    action  OS2Notes.sgml
    action  OpenBSD.sgml
    action  README.sgml
    action  RELNOTES.sgml
    action  SCO.sgml
    action  Solaris.sgml
    action  Versions.sgml
    action  XKB-Config.sgml
    action  XKB-Enhancing.sgml
    action  add.sh
    action  dps.sgml
    action  fonts.sgml
    action  index.post
    action  index.pre
    action  mdefs.cpp	mdefs.pre

# Entity files and scripts needed for all sgml docs:

    dst_dir doc/xorg-sgml-doctools
    action  defs.ent

# Driver-specific docs:

    dst_dir driver/xf86-video-tga
    action  DECtga.sgml		README.sgml

    dst_dir driver/xf86-video-i128
    action  I128.sgml		README.sgml

    dst_dir driver/xf86-video-sis
    action  SiS.sgml		README.sgml

    dst_dir driver/xf86-video-apm
    action  apm.sgml		README.sgml

    dst_dir driver/xf86-video-ati
    action  ati.sgml		README.ati.sgml
    action  r128.sgml		README.r128.sgml

    dst_dir driver/xf86-video-chips
    action  chips.sgml		README.sgml

    dst_dir driver/xf86-video-cyrix
    action  cyrix.sgml		README.sgml

    dst_dir driver/xf86-video-i740
    action  i740.sgml		README.sgml

    dst_dir driver/xf86-video-i810
    action  i810.sgml		README.sgml

    dst_dir driver/xf86-input-mouse
    action  mouse.sgml		README.sgml

    dst_dir driver/xf86-video-newport
    action  newport.sgml	README.sgml

    dst_dir driver/xf86-video-rendition
    action  rendition.sgml	README.sgml

    dst_dir driver/xf86-video-s3virge
    action  s3virge.sgml	README.sgml

#   Japanese documentation
    src_dir programs/Xserver/hw/xfree86/doc/Japanese/sgml
    dst_dir doc/old/sgml/Japanese

    action	1st.sgml
    action	read98.sgml
}

symlink_xserver_hw_xfree86_etc() {
    src_dir programs/Xserver/hw/xfree86/etc

    dst_dir xserver/xorg/hw/xfree86/common
    action vesamodes
    action extramodes

    dst_dir xserver/xorg/hw/xfree86/utils/gtf
    action gtf.c
    action gtf.man gtf.man.pre

    dst_dir xserver/xorg/hw/xfree86/utils/ioport
    action ioport.c

    dst_dir xserver/xorg/hw/xfree86/utils/kbd_mode
    action kbd_mode.c   bsd-kbd_mode.c
    action kbd_mode.man bsd-kbd_mode.man.pre

    dst_dir xserver/xorg/hw/xfree86/utils/pcitweak
    action pcitweak.c
    action pcitweak.man pcitweak.man.pre

    dst_dir xserver/xorg/hw/xfree86/os-support/solaris
    action apSolaris.shar
}

symlink_xserver_hw_xfree86_x86emu() {
    src_dir extras/x86emu/include
    dst_dir xserver/xorg/hw/xfree86/x86emu

    action      x86emu.h

    src_dir extras/x86emu/src/x86emu

    action debug.c
    action decode.c  
    action fpu.c
    action ops2.c
    action ops.c
    action prim_ops.c
    action sys.c
    action validate.c

    dst_dir xserver/xorg/hw/xfree86/x86emu/x86emu
    src_dir extras/x86emu/include/x86emu

    action fpu_regs.h
    action regs.h
    action types.h

    src_dir extras/x86emu/src/x86emu/x86emu

    action debug.h
    action decode.h
    action fpu.h
    action ops.h
    action prim_asm.h
    action prim_ops.h
    action x86emui.h
}


symlink_xserver_hw_xfree86_dixmods() {
    dst_dir xserver/xorg/hw/xfree86/dixmods

    src_dir programs/Xserver/GL
    action      glxmodule.c

    src_dir programs/Xserver/GL/mesa/GLcore
    action      GLcoremodule.c

    src_dir programs/Xserver/afb
    action	afbmodule.c

    src_dir lib/font/bitmap/module
    action	bitmapmod.c

    src_dir lib/font/FreeType/module
    action      ftmodule.c

    src_dir lib/font/Type1/module
    action	type1mod.c

    src_dir programs/Xserver/cfb
    action	cfbmodule.c

    src_dir programs/Xserver/cfb16
    action	cfbmodule.c	cfb16module.c

    src_dir programs/Xserver/cfb24
    action	cfbmodule.c	cfb24module.c

    src_dir programs/Xserver/cfb32
    action	cfbmodule.c	cfb32module.c

    src_dir programs/Xserver/dbe
    action	dbemodule.c
	    
    src_dir programs/Xserver/fb
    action	fbmodule.c

    src_dir programs/Xserver/miext/layer
    action	laymodule.c

    src_dir programs/Xserver/miext/shadow
    action	shmodule.c

    src_dir programs/Xserver/mfb
    action	mfbmodule.c

    src_dir programs/Xserver/record
    action	recordmod.c
}

symlink_xserver_hw_xfree86_dummylib() {
    src_dir programs/Xserver/hw/xfree86/dummylib
    dst_dir xserver/xorg/hw/xfree86/dummylib

    action	README
    action      dummylib.h
    action      fatalerror.c
    action      getvalidbios.c
    action      logvwrite.c
    action      pcitestmulti.c
    action      verrorf.c
    action      xalloc.c
    action      xf86addrestolist.c
    action      xf86allocscripi.c
    action      xf86drvmsg.c
    action      xf86drvmsgverb.c
    action      xf86errorf.c
    action      xf86errorfverb.c
    action      xf86getpagesize.c
    action      xf86getverb.c
    action      xf86info.c
    action      xf86msg.c
    action      xf86msgverb.c
    action      xf86opt.c
    action      xf86screens.c
    action      xf86servisinit.c
    action      xf86verbose.c

    src_dir lib/misc
    action	strlcat.c
    action	strlcpy.c
}

symlink_xserver_hw_xfree86_exa() {
    src_dir programs/Xserver/hw/xfree86/exa
    dst_dir xserver/xorg/hw/xfree86/exa

    action      exaasync.c
    action      exa.c
    action      exa.h
    action      exaoffscreen.c
    action      exapict.c
    action      exaPriv.h
}

symlink_xserver_hw_xfree86_fbdevhw() {
    src_dir programs/Xserver/hw/xfree86/fbdevhw
    dst_dir xserver/xorg/hw/xfree86/fbdevhw

    action      fbdevhw.c
    action      fbdevhw.h
    action      fbdevhwstub.c
    action      fbpriv.h
    action	README
    action	fbdevhw.man fbdevhw.man.pre
}

symlink_xserver_hw_xfree86_getconfig() {
    src_dir programs/Xserver/hw/xfree86/getconfig
    dst_dir xserver/xorg/hw/xfree86/getconfig

    action      cfg.man		cfg.man.pre
    action      cfg.sample
    action      getconfig.man	getconfig.man.pre
    action      getconfig.pl
    action      getconfig.sh	getconfig
    action      xorg.cfg
}

symlink_xserver_hw_xfree86_i2c() {
    src_dir programs/Xserver/hw/xfree86/i2c
    dst_dir xserver/xorg/hw/xfree86/i2c

    action      xf86i2c.c
    action      xf86i2c.h
    action      xf86i2cmodule.c

    src_dir programs/Xserver/hw/xfree86/drivers/i2c
    dst_dir xserver/xorg/hw/xfree86/i2c
    
    action	i2c_def.h

    action	bt829.c
    action	bt829.h
    action	bt829_module.c
 
    action	fi1236.c
    action	fi1236.h
    action	fi1236_module.c
    
    action	msp3430.c
    action	msp3430.h
    action	msp3430_module.c

    action	tda8425.c
    action	tda8425.h
    action	tda8425_module.c

    action	tda9850.c
    action	tda9850.h
    action	tda9850_module.c

    action	tda9885.c
    action	tda9885.h
    action	tda9885_module.c

    action	uda1380.c
    action	uda1380.h
    action	uda1380_module.c
}

symlink_xserver_hw_xfree86_int10() {
    src_dir programs/Xserver/hw/xfree86/int10
    dst_dir xserver/xorg/hw/xfree86/int10

    action      generic.c
    action      helper_exec.c
    action      helper_mem.c
    action      pci.c
    action      stub.c
    action      x86emu.c
    action      xf86int10.c
    action      xf86int10.h
    action      xf86int10module.c
    action      xf86x86emu.c
    action      xf86x86emu.h
    action	INT10.HOWTO
}

symlink_xserver_hw_xfree86_loader() {
    src_dir programs/Xserver/hw/xfree86/loader
    dst_dir xserver/xorg/hw/xfree86/loader

    action      SparcMulDiv.S
    action      aout.h
    action      aoutloader.c
    action      aoutloader.h
    action      ar.h
    action      coff.h
    action      coffloader.c
    action      coffloader.h
    action      dixsym.c
    action      dlloader.c
    action      dlloader.h
    action      elf.h
    action      elfloader.c
    action      elfloader.h
    action      extsym.c
    action      fontsym.c
    action      hash.c
    action      hash.h
    action      loader.c
    action      loader.h
    action      loaderProcs.h
    action      loadext.c
    action      loadfont.c
    action      loadmod.c
    action      misym.c
    action      os.c
    action      sym.h
    action      xf86sym.c
}

symlink_xserver_hw_xfree86_ossupport() {
    src_dir programs/Xserver/hw/xfree86/os-support
    dst_dir xserver/xorg/hw/xfree86/os-support

    action      assyntax.h
    action      int10Defines.h
    action      xf86OSKbd.h
    action      xf86OSmouse.h
    action      xf86OSpriv.h
    action      xf86_OSlib.h
    action      xf86_OSproc.h
    action      xf86_ansic.h
    action      xf86_libc.h
    action      xf86drm.h
    action      xf86drmCompat.h

    action	README.OS-lib
}

symlink_xserver_hw_xfree86_ossupport_bsd() {
    src_dir programs/Xserver/hw/xfree86/os-support/bsd
    dst_dir xserver/xorg/hw/xfree86/os-support/bsd

    action      alpha_video.c
    action      arm_video.c
    action      bsdResource.c
    action      bsd_KbdMap.c
    action      bsd_VTsw.c
    action      bsd_apm.c
    action      bsd_axp.c
    action      bsd_ev56.c
    action      bsd_init.c
    action      bsd_io.c
    action      bsd_jstk.c
    action      bsd_kbd.c
    action      bsd_kbd.h
    action      bsd_kmod.c
    action      bsd_kqueue_apm.c
    action      bsd_mouse.c
    action      i386_video.c
    action      memrange.h
    action      ppc_video.c
    action      sparc64_video.c
}

symlink_xserver_hw_xfree86_ossupport_bsd_libusb() {
    src_dir programs/Xserver/hw/xfree86/os-support/bsd/libusb
    dst_dir xserver/xorg/hw/xfree86/os-support/bsd/libusb

    action      data.c
    action      descr.c
    action      parse.c
    action      usage.c
    action      usb.h
    action      usbvar.h
    action	usb.3
    action	usb_hid_usages
}

symlink_xserver_hw_xfree86_ossupport_bsdi() {
    src_dir programs/Xserver/hw/xfree86/os-support/bsdi
    dst_dir xserver/xorg/hw/xfree86/os-support/bsdi

    action      bsdi_init.c
    action      bsdi_io.c
    action      bsdi_mouse.c
    action      bsdi_video.c
}

symlink_xserver_hw_xfree86_ossupport_bus() {
    src_dir programs/Xserver/hw/xfree86/os-support/bus
    dst_dir xserver/xorg/hw/xfree86/os-support/bus

    action      460gxPCI.c
    action      460gxPCI.h
    action      Pci.c
    action      Pci.h
    action      Sbus.c
    action      altixPCI.c
    action      altixPCI.h
    action      axpPci.c
    action      e8870PCI.c
    action      e8870PCI.h
    action      freebsdPci.c
    action      ix86Pci.c
    action      linuxPci.c
    action      netbsdPci.c
    action      ppcPci.c
    action      sparcPci.c
    action      xf86Pci.h
    action      xf86Sbus.h
    action      zx1PCI.c
    action      zx1PCI.h
}

symlink_xserver_hw_xfree86_ossupport_dgux() {
    src_dir programs/Xserver/hw/xfree86/os-support/dgux
    dst_dir xserver/xorg/hw/xfree86/os-support/dgux

    action      bios_DGmmap.c
    action      dgux_init.c
    action      dgux_io.c
    action      dgux_kbd.c
    action      dgux_kbdEv.c
    action      dgux_tty.c
    action      dgux_video.c
}

symlink_xserver_hw_xfree86_ossupport_drm() {
    src_dir programs/Xserver/hw/xfree86/os-support/linux/drm
    dst_dir xserver/xorg/hw/xfree86/os-support/drm

    action      drmmodule.c
    action      xf86drm.c
    action      xf86drmHash.c
    action      xf86drmRandom.c
    action      xf86drmSL.c
}

symlink_xserver_hw_xfree86_ossupport_hurd() {
    src_dir programs/Xserver/hw/xfree86/os-support/hurd
    dst_dir xserver/xorg/hw/xfree86/os-support/hurd

    action      bios_mmap.c
    action      hurd_init.c
    action      hurd_io.c
    action      hurd_mouse.c
    action      hurd_video.c
}

symlink_xserver_hw_xfree86_ossupport_linux() {
    src_dir programs/Xserver/hw/xfree86/os-support/linux
    dst_dir xserver/xorg/hw/xfree86/os-support/linux

    action      agpgart.h
    action      lnx.h
    action      lnxResource.c
    action      lnx_KbdMap.c
    action      lnx_acpi.c
    action      lnx_agp.c
    action      lnx_apm.c
    action      lnx_axp.c
    action      lnx_ev56.c
    action      lnx_font.c
    action      lnx_ia64.c
    action      lnx_init.c
    action      lnx_io.c
    action      lnx_jstk.c
    action      lnx_kbd.c
    action      lnx_kbd.h
    action      lnx_kmod.c
    action      lnx_mouse.c
    action      lnx_pci.c
    action      lnx_video.c
}

symlink_xserver_hw_xfree86_ossupport_linux_int10() {
    src_dir programs/Xserver/hw/xfree86/os-support/linux/int10
    dst_dir xserver/xorg/hw/xfree86/os-support/linux/int10

    action      linux.c
}

symlink_xserver_hw_xfree86_ossupport_linux_int10_vm86() {
    src_dir programs/Xserver/hw/xfree86/os-support/linux/int10/vm86
    dst_dir xserver/xorg/hw/xfree86/os-support/linux/int10/vm86

    action      linux_vm86.c
}

symlink_xserver_hw_xfree86_ossupport_lynxos() {
    src_dir programs/Xserver/hw/xfree86/os-support/lynxos
    dst_dir xserver/xorg/hw/xfree86/os-support/lynxos

    action      lynx_init.c
    action      lynx_io.c
    action      lynx_mmap.c
    action      lynx_mouse.c
    action      lynx_noinline.c
    action      lynx_ppc.c
    action      lynx_video.c
    action	lynx_ppc.S
}

symlink_xserver_hw_xfree86_ossupport_misc() {
    src_dir programs/Xserver/hw/xfree86/os-support/misc
    dst_dir xserver/xorg/hw/xfree86/os-support/misc

    action      BUSmemcpy.c
    action      Delay.c
    action      IODelay.c
    action      SlowBcopy.c
    action      xf86_IlHack.c
    action      xf86_Util.c

    action	BUSmemcpy.S
    action	IODelay.S
    action	PortIO.S
    action	SlowBcopy.S
    
}

symlink_xserver_hw_xfree86_ossupport_nto() {
    src_dir programs/Xserver/hw/xfree86/os-support/nto
    dst_dir xserver/xorg/hw/xfree86/os-support/nto

    action      nto_init.c
    action      nto_io.c
    action      nto_ioperm.c
    action      nto_kbdEv.c
    action      nto_mouse.c
    action      nto_video.c
    action	README
}

symlink_xserver_hw_xfree86_ossupport_os2() {
    src_dir programs/Xserver/hw/xfree86/os-support/os2
    dst_dir xserver/xorg/hw/xfree86/os-support/os2

    action      os2_VTsw.c
    action      os2_bios.c
    action      os2_diag.c
    action      os2_init.c
    action      os2_io.c
    action      os2_ioperm.c
    action      os2_kbd.c
    action      os2_kbdEv.c
    action      os2_mouse.c
    action      os2_select.c
    action      os2_select.h
    action      os2_serial.c
    action      os2_stubs.c
    action      os2_video.c
    action	README
}

symlink_xserver_hw_xfree86_ossupport_os2_int10() {
    src_dir programs/Xserver/hw/xfree86/os-support/os2/int10
    dst_dir xserver/xorg/hw/xfree86/os-support/os2/int10

    action      os2.c
}

symlink_xserver_hw_xfree86_ossupport_pmax() {
    src_dir programs/Xserver/hw/xfree86/os-support/pmax
    dst_dir xserver/xorg/hw/xfree86/os-support/pmax

    action      pmax_devs.c
    action      pmax_init.c
    action      pmax_map.c
    action      pmax_mouse.c
    action      pmax_pci.c
    action      pmax_ppc.c
}

symlink_xserver_hw_xfree86_ossupport_qnx4() {
    src_dir programs/Xserver/hw/xfree86/os-support/qnx4
    dst_dir xserver/xorg/hw/xfree86/os-support/qnx4

    action      qnx_VTsw.c
    action      qnx_init.c
    action      qnx_io.c
    action      qnx_kbd.c
    action      qnx_mouse.c
    action      qnx_select.c
    action      qnx_utils.c
    action      qnx_video.c
}

symlink_xserver_hw_xfree86_ossupport_sco() {
    src_dir programs/Xserver/hw/xfree86/os-support/sco
    dst_dir xserver/xorg/hw/xfree86/os-support/sco

    action      VTsw_sco.c
    action      sco_init.c
    action      sco_io.c
    action      sco_iop.c
    action      sco_mouse.c
    action      sco_video.c
}

symlink_xserver_hw_xfree86_ossupport_shared() {
    src_dir programs/Xserver/hw/xfree86/os-support/shared
    dst_dir xserver/xorg/hw/xfree86/os-support/shared

    action      VTsw_noop.c
    action      VTsw_usl.c
    action      agp_noop.c
    action      at_scancode.c
    action      bios_devmem.c
    action      bios_mmap.c
    action      ia64Pci.c
    action      ia64Pci.h
    action      ioperm_noop.c
    action      kbd.c
    action      kmod_noop.c
    action      libc_wrapper.c
    action      pm_noop.c
    action      posix_tty.c
    action      sigio.c
    action      sigiostubs.c
    action      stdPci.c
    action      stdResource.c
    action      std_kbdEv.c
    action      sysv_kbd.c
    action      vidmem.c
    action      xf86Axp.c
    action      xf86Axp.h
    action	inout.S
}

symlink_xserver_hw_xfree86_ossupport_sunos() {
    src_dir programs/Xserver/hw/xfree86/os-support/sunos
    dst_dir xserver/xorg/hw/xfree86/os-support/solaris

    action      sun_agp.c
    action      agpgart.h
    action      sun_bios.c
    action      sun_init.c
    action      sun_io.c
    action      sun_kbd.h
    action      sun_kbd.c
    action      sun_kbdEv.c
    action      sun_mouse.c
    action      sun_vid.c
    action      solaris-amd64.S
    action      solaris-ia32.S
    action      solaris-sparcv8plus.S
    action	sun_inout.s
}

symlink_xserver_hw_xfree86_ossupport_sysv() {
    src_dir programs/Xserver/hw/xfree86/os-support/sysv
    dst_dir xserver/xorg/hw/xfree86/os-support/sysv

    action      sysv_init.c
    action      sysv_io.c
    action      sysv_mouse.c
    action      sysv_video.c
    action      xqueue.c
    action      xqueue.h
}

symlink_xserver_hw_xfree86_parser() {
    src_dir programs/Xserver/hw/xfree86/parser
    dst_dir xserver/xorg/hw/xfree86/parser

    action      Configint.h
    action      DRI.c
    action      Device.c
    action      Extensions.c
    action      Files.c
    action      Flags.c
    action      Input.c
    action      Keyboard.c
    action      Layout.c
    action      Module.c
    action      Monitor.c
    action      Pointer.c
    action      Screen.c
    action      Vendor.c
    action      Video.c
    action      configProcs.h
    action      cpconfig.c
    action      read.c
    action      scan.c
    action      write.c
    action      xf86Optrec.h
    action      xf86Parser.h
    action      xf86tokens.h
}

symlink_xserver_hw_xfree86_rac() {
    src_dir programs/Xserver/hw/xfree86/rac
    dst_dir xserver/xorg/hw/xfree86/rac

    action      xf86RAC.c
    action      xf86RAC.h
    action      xf86RACmodule.c
}

symlink_xserver_hw_xfree86_ramdac() {
    src_dir programs/Xserver/hw/xfree86/ramdac
    dst_dir xserver/xorg/hw/xfree86/ramdac

    action      BT.c
    action      BT.h
    action      BTPriv.h
    action      IBM.c
    action      IBM.h
    action      IBMPriv.h
    action      TI.c
    action      TI.h
    action      TIPriv.h
    action      xf86Cursor.c
    action      xf86Cursor.h
    action      xf86CursorPriv.h
    action      xf86HWCurs.c
    action      xf86RamDac.c
    action      xf86RamDac.h
    action      xf86RamDacCmap.c
    action      xf86RamDacMod.c
    action      xf86RamDacPriv.h

    action      CURSOR.NOTES
}

symlink_xserver_hw_xfree86_scanpci() {
    src_dir programs/Xserver/hw/xfree86/scanpci
    dst_dir xserver/xorg/hw/xfree86/scanpci

    action      xf86PciData.h
    action      xf86PciStdIds.h
    action      xf86PciStr.h
    action      xf86ScanPci.c
    action      xf86ScanPci.h
    
    action      pciid2c.pl

    src_dir programs/Xserver/hw/xfree86/etc
    action	pci.ids
    action	extrapci.ids

    dst_dir xserver/xorg/hw/xfree86/utils/scanpci
    action	scanpci.c
    action	scanpci.man scanpci.man.pre
}

symlink_xserver_hw_xfree86_shadowfb() {
    src_dir programs/Xserver/hw/xfree86/shadowfb
    dst_dir xserver/xorg/hw/xfree86/shadowfb

    action      sfbmodule.c
    action      shadow.c
    action      shadowfb.h
}

symlink_xserver_hw_xfree86_vbe() {
    src_dir programs/Xserver/hw/xfree86/vbe
    dst_dir xserver/xorg/hw/xfree86/vbe

    action      vbe.c
    action      vbe.h
    action      vbeModes.c
    action      vbeModes.h
    action      vbe_module.c
}

symlink_xserver_hw_xfree86_vgahw() {
    src_dir programs/Xserver/hw/xfree86/vgahw
    dst_dir xserver/xorg/hw/xfree86/vgahw

    action      vgaCmap.c
    action      vgaHW.c
    action      vgaHW.h
    action      vgaHWmodule.c
}

symlink_xserver_hw_xfree86_xaa() {
    src_dir programs/Xserver/hw/xfree86/xaa
    dst_dir xserver/xorg/hw/xfree86/xaa

    action      xaa.h
    action      xaaBitBlt.c
    action      xaaBitOrder.c
    action      xaaBitmap.c
    action      xaaCpyArea.c
    action      xaaCpyPlane.c
    action      xaaCpyWin.c
    action      xaaDashLine.c
    action      xaaFallback.c
    action      xaaFillArc.c
    action      xaaFillPoly.c
    action      xaaFillRect.c
    action      xaaGC.c
    action      xaaGCmisc.c
    action      xaaImage.c
    action      xaaInit.c
    action      xaaInitAccel.c
    action      xaaLine.c
    action      xaaLineMisc.c
    action      xaaNonTEGlyph.c
    action      xaaNonTEText.c
    action      xaaOffscreen.c
    action      xaaOverlay.c
    action      xaaOverlayDF.c
    action      xaaPCache.c
    action      xaaPaintWin.c
    action      xaaPict.c
    action      xaaROP.c
    action      xaaRect.c
    action      xaaSpans.c
    action      xaaStateChange.c
    action      xaaStipple.c
    action      xaaTEGlyph.c
    action      xaaTEText.c
    action      xaaTables.c
    action      xaaWideLine.c
    action      xaaWrapper.c
    action      xaaWrapper.h
    action      xaacexp.h
    action      xaalocal.h
    action      xaarop.h
    action      xaawrap.h
    action	xaaTEGlyphBlt.S

    action      XAA.HOWTO
}

symlink_xserver_hw_xfree86_xf1bpp() {
    src_dir programs/Xserver/hw/xfree86/xf1bpp
    dst_dir xserver/xorg/hw/xfree86/xf1bpp

    action      mfbmap.h
    action      mfbmodule.c
    action      mfbunmap.h
    action      xf1bpp.h
    action      mfbmap.sh
    action      mfbunmap.sh
}

symlink_xserver_hw_xfree86_xf4bpp() {
    src_dir programs/Xserver/hw/xfree86/xf4bpp
    dst_dir xserver/xorg/hw/xfree86/xf4bpp

    action      OScompiler.h
    action      emulOpStip.c
    action      emulRepAre.c
    action      emulTile.c
    action      ibmTrace.h
    action      mfbbres.c
    action      mfbbresd.c
    action      mfbfillarc.c
    action      mfbhrzvert.c
    action      mfbimggblt.c
    action      mfbline.c
    action      mfbzerarc.c
    action      offscreen.c
    action      ppcArea.c
    action      ppcBStore.c
    action      ppcCReduce.c
    action      ppcClip.c
    action      ppcCpArea.c
    action      ppcDepth.c
    action      ppcFillRct.c
    action      ppcGC.c
    action      ppcGCstr.h
    action      ppcGetSp.c
    action      ppcIO.c
    action      ppcImg.c
    action      ppcPixFS.c
    action      ppcPixmap.c
    action      ppcPntWin.c
    action      ppcPolyPnt.c
    action      ppcPolyRec.c
    action      ppcQuery.c
    action      ppcRslvC.c
    action      ppcSetSp.c
    action      ppcSpMcro.h
    action      ppcWinFS.c
    action      ppcWindow.c
    action      vgaBitBlt.c
    action      vgaGC.c
    action      vgaImages.c
    action      vgaReg.h
    action      vgaSolid.c
    action      vgaStipple.c
    action      vgaVideo.h
    action      vgamodule.c
    action      wm3.c
    action      wm3.h
    action      xf4bpp.h

    action      NOTES
}

symlink_xserver_hw_xfree86_xf8_16bpp() {
    src_dir programs/Xserver/hw/xfree86/xf8_16bpp
    dst_dir xserver/xorg/hw/xfree86/xf8_16bpp

    action      cfb8_16.h
    action      cfb8_16module.c
    action      cfbscrinit.c
    action      cfbwindow.c
}

symlink_xserver_hw_xfree86_xf8_32bpp() {
    src_dir programs/Xserver/hw/xfree86/xf8_32bpp
    dst_dir xserver/xorg/hw/xfree86/xf8_32bpp

    action      cfb8_32.h
    action      cfb8_32module.c
    action      cfbbstore.c
    action      cfbcpyarea.c
    action      cfbcpyplane.c
    action      cfbgc.c
    action      cfbgcmisc.c
    action      cfbgcunder.c
    action      cfbimage.c
    action      cfbpntwin.c
    action      cfbscrinit.c
    action      cfbwindow.c
    action      xf86overlay.c
}

symlink_xserver_hw_xfree86_xf8_32wid() {
    src_dir programs/Xserver/hw/xfree86/xf8_32wid
    dst_dir xserver/xorg/hw/xfree86/xf8_32wid

    action      cfb8_32wid.h
    action      cfb8_32widmodule.c
    action      cfbscrinit.c
    action      cfbwid.c
    action      cfbwindow.c
}

symlink_xserver_hw_xfree86_xf86cfg() {
    src_dir programs/Xserver/hw/xfree86/xf86cfg
    dst_dir xserver/xorg/hw/xfree86/utils/xorgcfg

    action	 TODO
    action	 XOrgCfg.cpp XOrgCfg.pre
    action	 accessx.c
    action	 card-cfg.c
    action	 card-cfg.h
    action	 card.xbm
    action	 card.xpm
    action	 cards.c
    action	 cards.h
    action	 computer.xpm
    action	 config.c
    action	 config.h
    action	 down.xbm
    action	 expert.c
    action	 help.c
    action	 help.h
    action	 interface.c
    action	 keyboard-cfg.c
    action	 keyboard-cfg.h
    action	 keyboard.xbm
    action	 keyboard.xpm
    action	 left.xbm
    action	 loader.c
    action	 loader.h
    action	 loadmod.c
    action	 monitor-cfg.c
    action	 monitor-cfg.h
    action	 monitor.xbm
    action	 monitor.xpm
    action	 mouse-cfg.c
    action	 mouse-cfg.h
    action	 mouse.xbm
    action	 mouse.xpm
    action	 narrower.xbm
    action	 options.c
    action	 options.h
    action	 right.xbm
    action	 screen-cfg.c
    action	 screen-cfg.h
    action	 screen.c
    action	 screen.h
    action	 shorter.xbm
    action	 startx.c
    action	 stubs.c
    action	 stubs.h
    action	 taller.xbm
    action	 text-mode.c
    action	 up.xbm
    action	 vidmode.c
    action	 vidmode.h
    action	 wider.xbm
    action	 xf86config.c
    action	 xf86config.h
    action	 xorgcfg.man xorgcfg.man.pre

}

symlink_xserver_hw_xfree86_xf86config() {
    src_dir programs/Xserver/hw/xfree86/xf86config
    dst_dir xserver/xorg/hw/xfree86/utils/xorgconfig

    action	Cards
    action	Cards98
    action	cards.c
    action	cards.h
    action	xorgconfig.c
    action	xorgconfig.man xorgconfig.man.pre
}

symlink_xserver_hw_xnest() {
    src_dir programs/Xserver/hw/xnest
    dst_dir xserver/xorg/hw/xnest

    action      Args.c
    action      Args.h
    action      Color.c
    action      Color.h
    action      Cursor.c
    action      Display.c
    action      Display.h
    action      Drawable.h
    action      Events.c
    action      Events.h
    action      Font.c
    action      GC.c
    action      GCOps.c
    action      GCOps.h
    action      GetTime.c
    action      Handlers.c
    action      Handlers.h
    action      Init.c
    action      Init.h
    action      Keyboard.c
    action      Keyboard.h
    action      Pixmap.c
    action      Pointer.c
    action      Pointer.h
    action      Screen.c
    action      Screen.h
    action      TestExt.c
    action      Visual.c
    action      Visual.h
    action      Window.c
    action      XNCursor.h
    action      XNFont.h
    action      XNGC.h
    action      XNPixmap.h
    action      XNWindow.h
    action      Xnest.h
    action      icon
    action      os2Stub.c
    action      screensaver

    action      Xnest.man Xnest.man.pre
}

symlink_xserver_hw_xwin() {
    src_dir programs/Xserver/hw/xwin
    dst_dir xserver/xorg/hw/xwin

    action      InitInput.c
    action      InitOutput.c
    action      ddraw.h
    action      win.h
    action      winallpriv.c
    action      winauth.c
    action      winblock.c
    action      winclip.c
    action      winclipboard.h
    action      winclipboardinit.c
    action      winclipboardtextconv.c
    action      winclipboardthread.c
    action      winclipboardunicode.c
    action      winclipboardwndproc.c
    action      winclipboardwrappers.c
    action      winclipboardxevents.c
    action      wincmap.c
    action      winconfig.c
    action      winconfig.h
    action      wincreatewnd.c
    action      wincursor.c
    action      windialogs.c
    action      winengine.c
    action      winerror.c
    action      winfillsp.c
    action      winfont.c
    action      wingc.c
    action      wingetsp.c
    action      winglobals.c
    action      winkeybd.c
    action      winkeybd.h
    action      winkeyhook.c
    action      winkeymap.h
    action      winkeynames.h
    action      winlayouts.h
    action      winmessages.h
    action      winmisc.c
    action      winmouse.c
    action      winms.h
    action      winmsg.c
    action      winmsg.h
    action      winmultiwindowclass.c
    action      winmultiwindowclass.h
    action      winmultiwindowicons.c
    action      winmultiwindowshape.c
    action      winmultiwindowwindow.c
    action      winmultiwindowwm.c
    action      winmultiwindowwndproc.c
    action      winnativegdi.c
    action      winpfbdd.c
    action      winpixmap.c
    action      winpntwin.c
    action      winpolyline.c
    action      winprefs.c
    action      winprefs.h
    action      winprefsyacc.y
    action      winprefslex.l
    action      winpriv.c
    action      winpriv.h
    action      winprocarg.c
    action      winpushpxl.c
    action      winrandr.c
    action      winregistry.c
    action      winresource.h
    action      winrop.c
    action      winscrinit.c
    action      winsetsp.c
    action      winshaddd.c
    action      winshadddnl.c
    action      winshadgdi.c
    action      wintrayicon.c
    action      winvalargs.c
    action      winvideo.c
    action      winwakeup.c
    action      winwin32rootless.c
    action      winwin32rootlesswindow.c
    action      winwin32rootlesswndproc.c
    action      winwindow.c
    action      winwindow.h
    action      winwindowswm.c
    action      winwndproc.c

    action      XWin.rc
    action      X.ico
    action      X-boxed.ico

    action      XWin.man    XWin.1
    action      XWinrc.man  XWinrc.1

    action	_usr_X11R6_lib_X11_system.XWinrc

    action      ChangeLog
    action      README
}

symlink_xserver_hw_xwin_xlaunch() {
    src_dir programs/Xserver/hw/xwin/xlaunch
    dst_dir xserver/xorg/hw/xwin/xlaunch

    action	config.cc
    action	config.h
    action	COPYING
    action	main.cc
    action	Makefile

    src_dir programs/Xserver/hw/xwin/xlaunch/resources
    dst_dir xserver/xorg/hw/xwin/xlaunch/resources

    action	dialog.rc
    action	fullscreen.bmp
    action	images.rc
    action	multiwindow.bmp
    action	nodecoration.bmp
    action	resources.h
    action	resources.rc
    action	strings.rc
    action	windowed.bmp

    src_dir programs/Xserver/hw/xwin/xlaunch/window
    dst_dir xserver/xorg/hw/xwin/xlaunch/window

    action	dialog.cc
    action	dialog.h
    action	util.cc
    action	util.h
    action	window.cc
    action	window.h
    action	wizard.cc
    action	wizard.h
}

symlink_xserver_ilbm() {
    src_dir programs/Xserver/ilbm
    dst_dir xserver/xorg/ilbm

    action      ilbm.h
    action      ilbmbitblt.c
    action      ilbmblt.c
    action      ilbmbres.c
    action      ilbmbresd.c
    action      ilbmbstore.c
    action      ilbmclip.c
    action      ilbmcmap.c
    action      ilbmfillarc.c
    action      ilbmfillrct.c
    action      ilbmfillsp.c
    action      ilbmfont.c
    action      ilbmgc.c
    action      ilbmgetsp.c
    action      ilbmhrzvert.c
    action      ilbmimage.c
    action      ilbmimggblt.c
    action      ilbmline.c
    action      ilbmmisc.c
    action      ilbmpixmap.c
    action      ilbmply1rct.c
    action      ilbmplygblt.c
    action      ilbmpntarea.c
    action      ilbmpntwin.c
    action      ilbmpolypnt.c
    action      ilbmpushpxl.c
    action      ilbmscrinit.c
    action      ilbmsetsp.c
    action      ilbmtegblt.c
    action      ilbmtile.c
    action      ilbmwindow.c
    action      ilbmzerarc.c

    action      README
}

symlink_xserver_include() {
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

symlink_xserver_iplan2p2() {
    src_dir programs/Xserver/iplan2p2
    dst_dir xserver/xorg/iplan2p2
}

symlink_xserver_iplan2p4() {
    src_dir programs/Xserver/iplan2p4
    dst_dir xserver/xorg/iplan2p4

    action      ipl.h
    action      iplallpriv.c
    action      iplbitblt.c
    action      iplblt.c
    action      iplbres.c
    action      iplbresd.c
    action      iplbstore.c
    action      iplcmap.c
    action      iplfillarc.c
    action      iplfillrct.c
    action      iplfillsp.c
    action      iplgc.c
    action      iplgetsp.c
    action      iplhrzvert.c
    action      iplimage.c
    action      iplline.c
    action      iplmap.h
    action      iplmergerop.h
    action      iplmskbits.c
    action      iplmskbits.h
    action      iplpack.c
    action      iplpack.h
    action      iplpixmap.c
    action      iplply1rct.c
    action      iplpntwin.c
    action      iplpolypnt.c
    action      iplrrop.c
    action      iplrrop.h
    action      iplscrinit.c
    action      iplsetsp.c
    action      iplsolid.c
    action      ipltegblt.c
    action      ipltile32.c
    action      ipltileodd.c
    action      iplwindow.c
}

symlink_xserver_iplan2p8() {
    src_dir programs/Xserver/iplan2p8
    dst_dir xserver/xorg/iplan2p8

}

symlink_xserver_lbx() {
    src_dir programs/Xserver/lbx
    dst_dir xserver/xorg/lbx

    action      lbxcmap.c
    action      lbxdata.h
    action      lbxdix.c
    action      lbxexts.c
    action      lbxgfx.c
    action      lbxmain.c
    action      lbxopts.c
    action      lbxprop.c
    action      lbxserve.h
    action      lbxsquish.c
    action      lbxsrvopts.h
    action      lbxswap.c
    action      lbxtables.c
    action      lbxtags.c
    action      lbxtags.h
    action      lbxzerorep.c
}

symlink_xserver_mfb() {
    src_dir programs/Xserver/mfb
    dst_dir xserver/xorg/mfb

    action      fastblt.h
    action      maskbits.c
    action      maskbits.h
    action      mergerop.h
    action      mfb.h
    action      mfbbitblt.c
    action      mfbblt.c
    action      mfbbres.c
    action      mfbbresd.c
    action      mfbbstore.c
    action      mfbclip.c
    action      mfbcmap.c
    action      mfbfillarc.c
    action      mfbfillrct.c
    action      mfbfillsp.c
    action      mfbfont.c
    action      mfbgc.c
    action      mfbgetsp.c
    action      mfbhrzvert.c
    action      mfbimage.c
    action      mfbimggblt.c
    action      mfbline.c
    action      mfbmisc.c
    action      mfbpixmap.c
    action      mfbply1rct.c
    action      mfbplygblt.c
    action      mfbpntarea.c
    action      mfbpntwin.c
    action      mfbpolypnt.c
    action      mfbpushpxl.c
    action      mfbscrclse.c
    action      mfbscrinit.c
    action      mfbsetsp.c
    action      mfbtegblt.c
    action      mfbtile.c
    action      mfbwindow.c
    action      mfbzerarc.c
}

symlink_xserver_mi() {
    src_dir programs/Xserver/mi
    dst_dir xserver/xorg/mi

    action      cbrt.c
    action      mi.h
    action      miarc.c
    action      mibank.c
    action      mibank.h
    action      mibitblt.c
    action      mibstore.c
    action      mibstore.h
    action      mibstorest.h
    action      miclipn.c
    action      micmap.c
    action      micmap.h
    action      micoord.h
    action      micursor.c
    action      midash.c
    action      midispcur.c
    action      mieq.c
    action      miexpose.c
    action      mifillarc.c
    action      mifillarc.h
    action      mifillrct.c
    action      mifpoly.h
    action      mifpolycon.c
    action      migc.c
    action      migc.h
    action      miglblt.c
    action	miinitext.c
    action      miline.h
    action      mioverlay.c
    action      mioverlay.h
    action      mipointer.c
    action      mipointer.h
    action      mipointrst.h
    action      mipoly.c
    action      mipoly.h
    action      mipolycon.c
    action      mipolygen.c
    action      mipolypnt.c
    action      mipolyrect.c
    action      mipolyseg.c
    action      mipolytext.c
    action      mipolyutil.c
    action      mipushpxl.c
    action      miregion.c
    action      miscanfill.h
    action      miscrinit.c
    action      mispans.c
    action      mispans.h
    action      misprite.c
    action      misprite.h
    action      mispritest.h
    action      mistruct.h
    action      mivalidate.h
    action      mivaltree.c
    action      miwideline.c
    action      miwideline.h
    action      miwindow.c
    action      mizerarc.c
    action      mizerarc.h
    action      mizerclip.c
    action      mizerline.c
}

symlink_xserver_miext_cw() {
    src_dir programs/Xserver/miext/cw
    dst_dir xserver/xorg/miext/cw

    action      cw.c
    action      cw.h
    action      cw_ops.c
    action      cw_render.c
}

symlink_xserver_miext_damage() {
    src_dir programs/Xserver/miext/damage
    dst_dir xserver/xorg/miext/damage

    action      damage.c
    action      damage.h
    action      damagestr.h
}

symlink_xserver_miext_layer() {
    src_dir programs/Xserver/miext/layer
    dst_dir xserver/xorg/miext/layer

    action      layer.h
    action      layergc.c
    action      layerinit.c
    action      layerpict.c
    action      layerstr.h
    action      layerwin.c
}

symlink_xserver_miext_rootless() {
    src_dir programs/Xserver/miext/rootless
    dst_dir xserver/xorg/miext/rootless

    action      rootless.h
    action      rootlessCommon.c
    action      rootlessCommon.h
    action      rootlessConfig.h
    action      rootlessGC.c
    action      rootlessScreen.c
    action      rootlessValTree.c
    action      rootlessWindow.c
    action      rootlessWindow.h

    action      README.txt
}

symlink_xserver_miext_rootless_accel() {
    src_dir programs/Xserver/miext/rootless/accel
    dst_dir xserver/xorg/miext/rootless/accel

    action      rlAccel.c
    action      rlAccel.h
    action      rlBlt.c
    action      rlCopy.c
    action      rlFill.c
    action      rlFillRect.c
    action      rlFillSpans.c
    action      rlGlyph.c
    action      rlSolid.c
}

symlink_xserver_miext_rootless_safealpha() {
    src_dir programs/Xserver/miext/rootless/safeAlpha
    dst_dir xserver/xorg/miext/rootless/safeAlpha

    action      safeAlpha.h
    action      safeAlphaPicture.c
    action      safeAlphaWindow.c
}

symlink_xserver_miext_shadow() {
    src_dir programs/Xserver/miext/shadow
    dst_dir xserver/xorg/miext/shadow

    action      shadow.c
    action      shadow.h
    action      shalloc.c
    action      shpacked.c
    action      shplanar.c
    action      shplanar8.c
    action      shrot16pack.c
    action      shrot16pack_180.c
    action      shrot16pack_270.c
    action      shrot16pack_90.c
    action      shrot32pack.c
    action      shrot32pack_180.c
    action      shrot32pack_270.c
    action      shrot32pack_90.c
    action      shrot8pack.c
    action      shrot8pack_180.c
    action      shrot8pack_270.c
    action      shrot8pack_90.c
    action      shrotate.c
    action      shrotpack.h
}

symlink_xserver_os() {
    src_dir programs/Xserver/os
    dst_dir xserver/xorg/os

    action      WaitFor.c
    action      access.c
    action      auth.c
    action      connection.c
    action      io.c
    action      k5auth.c
    action      lbxio.c
    action      log.c
    action      mitauth.c
    action      oscolor.c
    action      osdep.h
    action      osinit.c
    action      rpcauth.c
    action      secauth.c
    action      utils.c
    action      xalloc.c
    action      xdmauth.c
    action      xdmcp.c
    action      xprintf.c
}

symlink_xserver_randr() {
    src_dir programs/Xserver/randr
    dst_dir xserver/xorg/randr

    action      mirandr.c
    action      randr.c
    action      randrstr.h
}

symlink_xserver_record() {
    src_dir programs/Xserver/record
    dst_dir xserver/xorg/record

    action      record.c
    action      set.c
    action      set.h
}

symlink_xserver_render() {
    src_dir programs/Xserver/render
    dst_dir xserver/xorg/render

    action      animcur.c
    action      filter.c
    action      glyph.c
    action      glyphstr.h
    action      miglyph.c
    action      miindex.c
    action      mipict.c
    action      mipict.h
    action      mirect.c
    action      mitrap.c
    action      mitri.c
    action      picture.c
    action      picture.h
    action      picturestr.h
    action      render.c
    action      renderedge.c
    action      renderedge.h
}

symlink_xserver_xfixes() {
    src_dir programs/Xserver/xfixes
    dst_dir xserver/xorg/xfixes

    action      cursor.c
    action      region.c
    action      saveset.c
    action      select.c
    action      xfixes.c
    action      xfixes.h
    action      xfixesint.h
}

symlink_xserver_xkb() {
    src_dir programs/Xserver/xkb
    dst_dir xserver/xorg/xkb

    action      ddxBeep.c
    action      ddxConfig.c
    action      ddxCtrls.c
    action      ddxDevBtn.c
    action      ddxFakeBtn.c
    action      ddxFakeMtn.c
    action      ddxInit.c
    action      ddxKeyClick.c
    action      ddxKillSrv.c
    action      ddxLEDs.c
    action      ddxList.c
    action      ddxLoad.c
    action      ddxPrivate.c
    action      ddxVT.c
    action      xkb.c
    action      xkb.h
    action      xkbAccessX.c
    action      xkbActions.c
    action      xkbDflts.h
    action      xkbEvents.c
    action      xkbInit.c
    action      xkbLEDs.c
    action      xkbPrKeyEv.c
    action      xkbPrOtherEv.c
    action      xkbSwap.c
    action      xkbUtils.c

    src_dir lib/X11
    action	XKBAlloc.c
    action	XKBGAlloc.c
    action	XKBMAlloc.c
    action	XKBMisc.c

    src_dir lib/xkbfile
    action	maprules.c
    action	xkbconfig.c
    action	xkberrs.c
    action	xkbmisc.c xkbfmisc.c
    action	xkbout.c
    action	xkbtext.c
    action	xkmread.c

    src_dir programs/xkbcomp/compiled
    action	README		README.compiled
}

symlink_xserver_xprint_config_models() {
    # CANONBJ10E-GS
    src_dir programs/Xserver/XpConfig/C/print/models/CANONBJ10E-GS
    dst_dir xserver/xorg/XpConfig/C/print/models/CANONBJ10E-GS

    action	model-config

    # CANONC3200-PS
    src_dir programs/Xserver/XpConfig/C/print/models/CANONC3200-PS
    dst_dir xserver/xorg/XpConfig/C/print/models/CANONC3200-PS

    action	model-config

    # GSdefault
    src_dir programs/Xserver/XpConfig/C/print/models/GSdefault
    dst_dir xserver/xorg/XpConfig/C/print/models/GSdefault

    action	model-config

    # HPDJ1600C
    src_dir programs/Xserver/XpConfig/C/print/models/HPDJ1600C
    dst_dir xserver/xorg/XpConfig/C/print/models/HPDJ1600C
    
    action	model-config

    src_dir programs/Xserver/XpConfig/C/print/models/HPDJ1600C/fonts
    dst_dir xserver/xorg/XpConfig/C/print/models/HPDJ1600C/fonts

    action	9nb00051.pmf
    action	9nb00052.pmf
    action	9nb00053.pmf
    action	9nb00054.pmf
    action	9nb00055.pmf
    action	9nb00056.pmf
    action	9nb00057.pmf
    action	9nb00058.pmf
    action	9nb00059.pmf
    action	9nb00060.pmf
    action	9nb00061.pmf
    action	9nb00062.pmf
    action	9nb00063.pmf
    action	9nb00064.pmf
    action	9nb00065.pmf
    action	9nb00066.pmf
    action	9nb00067.pmf
    action	9nb00068.pmf
    action	9nb00069.pmf
    action	9nb00070.pmf
    action	9nb00071.pmf
    action	9nb00072.pmf
    action	9nb00073.pmf
    action	9nb00074.pmf
    action	9nb00075.pmf
    action	9nb00076.pmf
    action	9nb00077.pmf
    action	9nb00079.pmf
    action	9nb00080.pmf
    action	9nb00081.pmf
    action	9nb00082.pmf
    action	9nb00083.pmf
    action	9nb00084.pmf
    action	9nb00085.pmf
    action	9nb00086.pmf
    action	9nb00087.pmf
    action	9nb00088.pmf
    action	9nb00089.pmf
    action	9nb00090.pmf
    action	9nb00091.pmf
    action	9nb00092.pmf
    action	9nb00093.pmf
    action	9nb00094.pmf
    action	fonts.alias
    action	fonts.dir
    action	lpr0ye1a.pmf
    action	README

    # HPLJ4050-PS
    src_dir programs/Xserver/XpConfig/C/print/models/HPLJ4050-PS
    dst_dir xserver/xorg/XpConfig/C/print/models/HPLJ4050-PS

    action	model-config

    # HPLJ4family
    src_dir programs/Xserver/XpConfig/C/print/models/HPLJ4family
    dst_dir xserver/xorg/XpConfig/C/print/models/HPLJ4family

    action	model-config

    src_dir programs/Xserver/XpConfig/C/print/models/HPLJ4family/fonts
    dst_dir xserver/xorg/XpConfig/C/print/models/HPLJ4family/fonts

    action	9nb00051.pmf
    action	9nb00052.pmf
    action	9nb00053.pmf
    action	9nb00054.pmf
    action	9nb00055.pmf
    action	9nb00056.pmf
    action	9nb00057.pmf
    action	9nb00058.pmf
    action	9nb00059.pmf
    action	9nb00060.pmf
    action	9nb00061.pmf
    action	9nb00062.pmf
    action	9nb00063.pmf
    action	9nb00064.pmf
    action	9nb00065.pmf
    action	9nb00066.pmf
    action	9nb00067.pmf
    action	9nb00068.pmf
    action	9nb00069.pmf
    action	9nb00070.pmf
    action	9nb00071.pmf
    action	9nb00072.pmf
    action	9nb00073.pmf
    action	9nb00074.pmf
    action	9nb00075.pmf
    action	9nb00076.pmf
    action	9nb00077.pmf
    action	9nb00079.pmf
    action	9nb00080.pmf
    action	9nb00081.pmf
    action	9nb00082.pmf
    action	9nb00083.pmf
    action	9nb00084.pmf
    action	9nb00085.pmf
    action	9nb00086.pmf
    action	9nb00087.pmf
    action	9nb00088.pmf
    action	9nb00089.pmf
    action	9nb00090.pmf
    action	9nb00091.pmf
    action	9nb00092.pmf
    action	9nb00093.pmf
    action	9nb00094.pmf
    action	fonts.alias
    action	fonts.dir
    action	lpr0ye1a.pmf
    action	README

    # PS2PDFspooldir-GS
    src_dir programs/Xserver/XpConfig/C/print/models/PS2PDFspooldir-GS
    dst_dir xserver/xorg/XpConfig/C/print/models/PS2PDFspooldir-GS
    
    action	model-config
    action	ps2pdf_spooltodir.sh
    
    # PSdefault
    src_dir programs/Xserver/XpConfig/C/print/models/PSdefault
    dst_dir xserver/xorg/XpConfig/C/print/models/PSdefault
    
    action	model-config

    src_dir programs/Xserver/XpConfig/C/print/models/PSdefault/fonts
    dst_dir xserver/xorg/XpConfig/C/print/models/PSdefault/fonts
    
    action	AvantGarde-BookOblique.pmf
    action	AvantGarde-Book.pmf
    action	AvantGarde-DemiOblique.pmf
    action	AvantGarde-Demi.pmf
    action	Courier-BoldOblique.pmf
    action	Courier-Bold.pmf
    action	Courier-Oblique.pmf
    action	Courier.pmf
    action	Helvetica-BoldOblique.pmf
    action	Helvetica-Bold.pmf
    action	Helvetica-Oblique.pmf
    action	Helvetica.pmf
    action	LubalinGraph-BookOblique.pmf
    action	LubalinGraph-Book.pmf
    action	LubalinGraph-DemiOblique.pmf
    action	LubalinGraph-Demi.pmf
    action	NewCenturySchlbk-BoldItalic.pmf
    action	NewCenturySchlbk-Bold.pmf
    action	NewCenturySchlbk-Italic.pmf
    action	NewCenturySchlbk-Roman.pmf
    action	Souvenir-DemiItalic.pmf
    action	Souvenir-Demi.pmf
    action	Souvenir-LightItalic.pmf
    action	Souvenir-Light.pmf
    action	Symbol.pmf
    action	Times-BoldItalic.pmf
    action	Times-Bold.pmf
    action	Times-Italic.pmf
    action	Times-Roman.pmf
    action	ZapfDingbats.pmf
    
    # PSspooldir
    src_dir programs/Xserver/XpConfig/C/print/models/PSspooldir
    dst_dir xserver/xorg/XpConfig/C/print/models/PSspooldir

    action	model-config
    action	spooltodir.sh
    
    # SPSPARC2
    src_dir programs/Xserver/XpConfig/C/print/models/SPSPARC2
    dst_dir xserver/xorg/XpConfig/C/print/models/SPSPARC2
    
    action	model-config

    
}

symlink_xserver_xprint_config() {
    src_dir programs/Xserver/XpConfig
    dst_dir xserver/xorg/XpConfig
    
    action	README

    src_dir programs/Xserver/XpConfig/C/print
    dst_dir xserver/xorg/XpConfig/C/print
    
    action	Xprinters
    
    src_dir programs/Xserver/XpConfig/C/print/attributes
    dst_dir xserver/xorg/XpConfig/C/print/attributes

    action	document
    action	job
    action	printer

    src_dir programs/Xserver/XpConfig/C/print/ddx-config/raster
    dst_dir xserver/xorg/XpConfig/C/print/ddx-config/raster

    action	pcl
    action	postscript

    src_dir programs/Xserver/XpConfig/en_US/print/attributes
    dst_dir xserver/xorg/XpConfig/en_US/print/attributes
    
    action	document

    symlink_xserver_xprint_config_models
}

symlink_xserver() {
    symlink_xserver_GL_apple
    symlink_xserver_GL_dri
    symlink_xserver_GL_glx
    symlink_xserver_GL_include_GL
    symlink_xserver_GL_mesa_X
    symlink_xserver_GL_windows
    symlink_xserver_XTrap
    symlink_xserver_Xext
    symlink_xserver_Xext_extmod
    symlink_xserver_Xi
    symlink_xserver_Xprint
    symlink_xserver_Xprint_etc
    symlink_xserver_Xprint_ps
    symlink_xserver_Xprint_pcl
    symlink_xserver_Xprint_raster
    symlink_xserver_afb
    symlink_xserver_cfb
    symlink_xserver_cfb24
    symlink_xserver_composite
    symlink_xserver_damageext
    symlink_xserver_dbe
    symlink_xserver_dix
    symlink_xserver_fb
    symlink_xserver_hw_darwin
    symlink_xserver_hw_darwin_bundle
    symlink_xserver_hw_darwin_iokit
    symlink_xserver_hw_darwin_quartz
    symlink_xserver_hw_darwin_quartz_cr
    symlink_xserver_hw_darwin_quartz_fullscreen
    symlink_xserver_hw_darwin_quartz_xpr
    symlink_xserver_hw_darwin_utils
    symlink_xserver_hw_dmx
    symlink_xserver_hw_dmx_config
    symlink_xserver_hw_dmx_doc
    symlink_xserver_hw_dmx_examples
    symlink_xserver_hw_dmx_glxProxy
    symlink_xserver_hw_dmx_input
    symlink_xserver_hw_sun
    symlink_xserver_hw_vfb
    symlink_xserver_hw_xfree86
    symlink_xserver_hw_xfree86_common
    symlink_xserver_hw_xfree86_ddc
    symlink_xserver_hw_xfree86_x86emu
    symlink_xserver_hw_xfree86_dixmods
    symlink_xserver_hw_xfree86_doc
    symlink_xserver_hw_xfree86_dummylib
    symlink_xserver_hw_xfree86_etc
    symlink_xserver_hw_xfree86_exa
    symlink_xserver_hw_xfree86_fbdevhw
    symlink_xserver_hw_xfree86_getconfig
    symlink_xserver_hw_xfree86_i2c
    symlink_xserver_hw_xfree86_int10
    symlink_xserver_hw_xfree86_loader
    symlink_xserver_hw_xfree86_ossupport
    symlink_xserver_hw_xfree86_ossupport_bsd
    symlink_xserver_hw_xfree86_ossupport_bsd_libusb
    symlink_xserver_hw_xfree86_ossupport_bsdi
    symlink_xserver_hw_xfree86_ossupport_bus
    symlink_xserver_hw_xfree86_ossupport_dgux
    symlink_xserver_hw_xfree86_ossupport_drm
    symlink_xserver_hw_xfree86_ossupport_hurd
    symlink_xserver_hw_xfree86_ossupport_linux
    symlink_xserver_hw_xfree86_ossupport_linux_int10
    symlink_xserver_hw_xfree86_ossupport_linux_int10_vm86
    symlink_xserver_hw_xfree86_ossupport_lynxos
    symlink_xserver_hw_xfree86_ossupport_misc
    symlink_xserver_hw_xfree86_ossupport_nto
    symlink_xserver_hw_xfree86_ossupport_os2
    symlink_xserver_hw_xfree86_ossupport_os2_int10
    symlink_xserver_hw_xfree86_ossupport_pmax
    symlink_xserver_hw_xfree86_ossupport_qnx4
    symlink_xserver_hw_xfree86_ossupport_sco
    symlink_xserver_hw_xfree86_ossupport_shared
    symlink_xserver_hw_xfree86_ossupport_sunos
    symlink_xserver_hw_xfree86_ossupport_sysv
    symlink_xserver_hw_xfree86_parser
    symlink_xserver_hw_xfree86_rac
    symlink_xserver_hw_xfree86_ramdac
    symlink_xserver_hw_xfree86_scanpci
    symlink_xserver_hw_xfree86_shadowfb
    symlink_xserver_hw_xfree86_vbe
    symlink_xserver_hw_xfree86_vgahw
    symlink_xserver_hw_xfree86_xaa
    symlink_xserver_hw_xfree86_xf1bpp
    symlink_xserver_hw_xfree86_xf4bpp
    symlink_xserver_hw_xfree86_xf8_16bpp
    symlink_xserver_hw_xfree86_xf8_32bpp
    symlink_xserver_hw_xfree86_xf8_32wid
    symlink_xserver_hw_xfree86_xf86cfg
    symlink_xserver_hw_xfree86_xf86config
    symlink_xserver_hw_xnest
    symlink_xserver_hw_xwin
    symlink_xserver_hw_xwin_xlaunch
    symlink_xserver_ilbm
    symlink_xserver_include
    symlink_xserver_iplan2p2
    symlink_xserver_iplan2p4
    symlink_xserver_iplan2p8
    symlink_xserver_lbx
    symlink_xserver_mfb
    symlink_xserver_mi
    symlink_xserver_miext_cw
    symlink_xserver_miext_damage
    symlink_xserver_miext_layer
    symlink_xserver_miext_rootless
    symlink_xserver_miext_rootless_accel
    symlink_xserver_miext_rootless_safealpha
    symlink_xserver_miext_shadow
    symlink_xserver_os
    symlink_xserver_randr
    symlink_xserver_record
    symlink_xserver_render
    symlink_xserver_xfixes
    symlink_xserver_xkb
    symlink_xserver_xprint_config
#    ...
}

#########
#
#	The driver module
#
#########


symlink_driver_apm() {
    src_dir programs/Xserver/hw/xfree86/drivers/apm
    dst_dir driver/xf86-video-apm

    action	README

    src_dir programs/Xserver/hw/xfree86/drivers/apm
    dst_dir driver/xf86-video-apm/src

    action      apm.h
    action      apm_accel.c
    action      apm_cursor.c
    action      apm_dga.c
    action      apm_driver.c
    action      apm_funcs.c
    action      apm_i2c.c
    action      apm_regs.h
    action      apm_rush.c
    action      apm_video.c

    dst_dir driver/xf86-video-apm/man

    action      apm.man     apm.4
}

symlink_driver_ark() {
    src_dir programs/Xserver/hw/xfree86/drivers/ark
    dst_dir driver/xf86-video-ark/src

    action      ark.h
    action      ark_accel.c
    action      ark_driver.c
    action      ark_reg.h

    dst_dir driver/xf86-video-ark/man

}

symlink_driver_ati() {
    src_dir programs/Xserver/hw/xfree86/drivers/ati
    dst_dir driver/xf86-video-ati/src

    action      ati.c
    action      ati.h
    action      atiaccel.c
    action      atiaccel.h
    action      atiadapter.c
    action      atiadapter.h
    action      atiadjust.c
    action      atiadjust.h
    action      atiaudio.c
    action      atiaudio.h
    action      atibank.c
    action      atibank.h
    action      atibus.c
    action      atibus.h
    action      atichip.c
    action      atichip.h
    action      aticlock.c
    action      aticlock.h
    action      aticonfig.c
    action      aticonfig.h
    action      aticonsole.c
    action      aticonsole.h
    action      aticrtc.h
    action      aticursor.c
    action      aticursor.h
    action      atidac.c
    action      atidac.h
    action      atidecoder.c
    action      atidecoder.h
    action      atidga.c
    action      atidga.h
    action      atidri.c
    action      atidri.h
    action      atidripriv.h
    action      atidsp.c
    action      atidsp.h
    action      atifillin.c
    action      atifillin.h
    action      atii2c.c
    action      atii2c.h
    action      atiident.c
    action      atiident.h
    action      atiio.h
    action      atiload.c
    action      atiload.h
    action      atilock.c
    action      atilock.h
    action      atimach64.c
    action      atimach64.h
    action      atimach64accel.c
    action      atimach64accel.h
    action      atimach64cursor.c
    action      atimach64cursor.h
    action      atimach64i2c.c
    action      atimach64i2c.h
    action      atimach64io.c
    action      atimach64io.h
    action      atimach64xv.c
    action      atimach64xv.h
    action      atimisc.c
    action      atimode.c
    action      atimode.h
    action      atimodule.c
    action      atimodule.h
    action      atimono.h
    action      atioption.c
    action      atioption.h
    action      atipreinit.c
    action      atipreinit.h
    action      atiprint.c
    action      atiprint.h
    action      atipriv.h
    action      atiprobe.c
    action      atiprobe.h
    action      atiregs.h
    action      atirgb514.c
    action      atirgb514.h
    action      atiscreen.c
    action      atiscreen.h
    action      atistruct.h
    action      atituner.c
    action      atituner.h
    action      atiutil.c
    action      atiutil.h
    action      ativalid.c
    action      ativalid.h
    action      ativersion.h
    action      ativga.c
    action      ativga.h
    action      ativgaio.c
    action      ativgaio.h
    action      atividmem.c
    action      atividmem.h
    action      atiwonder.c
    action      atiwonder.h
    action      atiwonderio.c
    action      atiwonderio.h
    action      atixv.c
    action      atixv.h
    action      generic_bus.h
    action      mach64_common.h
    action      mach64_dri.h
    action      mach64_sarea.h
    action      r128.h
    action      r128_accel.c
    action      r128_chipset.h
    action      r128_common.h
    action      r128_cursor.c
    action      r128_dga.c
    action      r128_dri.c
    action      r128_dri.h
    action      r128_dripriv.h
    action      r128_driver.c
    action      r128_misc.c
    action      r128_probe.c
    action      r128_probe.h
    action      r128_reg.h
    action      r128_sarea.h
    action      r128_version.h
    action      r128_video.c
    action      radeon.h
    action      radeon_accel.c
    action      radeon_accelfuncs.c
    action      radeon_bios.c
    action      radeon_chipset.h
    action      radeon_common.h
    action      radeon_commonfuncs.c
    action      radeon_cursor.c
    action      radeon_dga.c
    action      radeon_dri.c
    action      radeon_dri.h
    action      radeon_dripriv.h
    action      radeon_driver.c
    action      radeon_exa.c
    action      radeon_exa_funcs.c
    action      radeon_exa_render.c
    action      radeon_macros.h
    action      radeon_mergedfb.c
    action      radeon_mergedfb.h
    action      radeon_misc.c
    action      radeon_mm_i2c.c
    action      radeon_probe.c
    action      radeon_probe.h
    action      radeon_reg.h
    action      radeon_render.c
    action      radeon_sarea.h
    action      radeon_version.h
    action      radeon_video.c
    action      radeon_video.h
    action      radeon_vip.c
    action      theatre.c
    action      theatre.h
    action      theatre200.c
    action      theatre200.h
    action      theatre200_module.c
    action      theatre_detect.c
    action      theatre_detect.h
    action      theatre_detect_module.c
    action      theatre_module.c
    action      theatre_reg.h

    dst_dir driver/xf86-video-ati/man

    action      ati.man     ati.4
    action      r128.man    r128.4
    action      radeon.man  radeon.4
}

symlink_driver_chips() {
    src_dir programs/Xserver/hw/xfree86/drivers/chips
    dst_dir driver/xf86-video-chips/src

    action      ct_BlitMM.h
    action      ct_Blitter.h
    action      ct_BltHiQV.h
    action      ct_accel.c
    action      ct_bank.c
    action      ct_cursor.c
    action      ct_ddc.c
    action      ct_dga.c
    action      ct_driver.c
    action      ct_driver.h
    action      ct_regs.c
    action      ct_shadow.c
    action      ct_video.c

    dst_dir driver/xf86-video-chips/man

    action      chips.man   chips.4

    src_dir programs/Xserver/hw/xfree86/drivers/chips/util
    dst_dir driver/xf86-video-chips/util

    action	AsmMacros.h
    action	dRegs.c
    action	modClock.c
    action	mRegs.c
}

symlink_driver_cirrus() {
    src_dir programs/Xserver/hw/xfree86/drivers/cirrus
    dst_dir driver/xf86-video-cirrus

    action	README.multihead

    src_dir programs/Xserver/hw/xfree86/drivers/cirrus
    dst_dir driver/xf86-video-cirrus/src

    action      CirrusClk.c
    action      alp.h
    action      alp_driver.c
    action      alp_hwcurs.c
    action      alp_i2c.c
    action      alp_xaa.c
    action      alp_xaam.c
    action      cir.h
    action      cir_dga.c
    action      cir_driver.c
    action      cir_shadow.c
    action      lg.h
    action      lg_driver.c
    action      lg_hwcurs.c
    action      lg_i2c.c
    action      lg_xaa.c
    action      lg_xaa.h

    dst_dir driver/xf86-video-cirrus/man

    action      cirrus.man  cirrus.4
}

symlink_driver_cyrix() {
    src_dir programs/Xserver/hw/xfree86/drivers/cyrix
    dst_dir driver/xf86-video-cyrix

    action	README
    action	ChangeLog

    src_dir programs/Xserver/hw/xfree86/drivers/cyrix
    dst_dir driver/xf86-video-cyrix/src

    action      cyrix.h
    action      cyrix_accel.c
    action      cyrix_bank.c
    action      cyrix_driver.c
    action      cyrix_helper.c
    action      cyrix_shadow.c

    dst_dir driver/xf86-video-cyrix/man

    action      cyrix.man   cyrix.4
}

symlink_driver_dummy() {
    src_dir programs/Xserver/hw/xfree86/drivers/dummy
    dst_dir driver/xf86-video-dummy/src

    action      dummy.h
    action      dummy_cursor.c
    action      dummy_dga.c
    action      dummy_driver.c

    dst_dir driver/xf86-video-dummy/man

}

symlink_driver_fbdev() {
    src_dir programs/Xserver/hw/xfree86/drivers/fbdev
    dst_dir driver/xf86-video-fbdev/src

    action      fbdev.c

    dst_dir driver/xf86-video-fbdev/man

    action      fbdev.man   fbdev.4
}

symlink_driver_glide() {
    src_dir programs/Xserver/hw/xfree86/drivers/glide
    dst_dir driver/xf86-video-glide/src

    action      glide_driver.c

    dst_dir driver/xf86-video-glide/man

    action      glide.man   glide.4
}

symlink_driver_glint() {
    src_dir programs/Xserver/hw/xfree86/drivers/glint
    dst_dir driver/xf86-video-glint

    action	DRI.txt
    action	README.pm3

    src_dir programs/Xserver/hw/xfree86/drivers/glint
    dst_dir driver/xf86-video-glint/src

    action      IBMramdac.c
    action      TIramdac.c
    action      glint.h
    action      glint_common.h
    action      glint_dga.c
    action      glint_dri.c
    action      glint_dri.h
    action      glint_dripriv.h
    action      glint_driver.c
    action      glint_regs.h
    action      glint_shadow.c
    action      pm2_accel.c
    action      pm2_dac.c
    action      pm2_video.c
    action      pm2ramdac.c
    action      pm2v_dac.c
    action      pm2vramdac.c
    action      pm3_accel.c
    action      pm3_dac.c
    action      pm3_regs.h
    action      pm3_video.c
    action      pm_accel.c
    action      pm_dac.c
    action      sx_accel.c
    action      tx_accel.c
    action      tx_dac.c

    dst_dir driver/xf86-video-glint/man

    action      glint.man   glint.4
}

symlink_driver_i128() {
    src_dir programs/Xserver/hw/xfree86/drivers/i128
    dst_dir driver/xf86-video-i128/src

    action      IBMRGB.h
    action      Ti302X.h
    action      i128.h
    action      i128IBMDAC.c
    action      i128_driver.c
    action      i128accel.c
    action      i128dga.c
    action      i128exa.c
    action      i128init.c
    action      i128reg.h

    dst_dir driver/xf86-video-i128/man

    action      i128.man    i128.4
}

symlink_driver_i740() {
    src_dir programs/Xserver/hw/xfree86/drivers/i740
    dst_dir driver/xf86-video-i740/src

    action      i740.h
    action      i740_accel.c
    action      i740_cursor.c
    action      i740_dga.c
    action      i740_dga.h
    action      i740_driver.c
    action      i740_i2c.c
    action      i740_io.c
    action      i740_macros.h
    action      i740_reg.h
    action      i740_video.c

    dst_dir driver/xf86-video-i740/man

    action      i740.man    i740.4
}

symlink_driver_i810() {
    src_dir programs/Xserver/hw/xfree86/drivers/i810
    dst_dir driver/xf86-video-i810/src

    action      common.h
    action      i810.h
    action      i810_accel.c
    action      i810_common.h
    action      i810_cursor.c
    action      i810_dga.c
    action      i810_dri.c
    action      i810_dri.h
    action      i810_driver.c
    action      i810_hwmc.c
    action      i810_io.c
    action      i810_memory.c
    action      i810_reg.h
    action      i810_video.c
    action      i810_wmark.c
    action      i830.h
    action      i830_accel.c
    action      i830_common.h
    action      i830_cursor.c
    action      i830_dga.c
    action      i830_dri.c
    action      i830_dri.h
    action      i830_driver.c
    action      i830_memory.c
    action      i830_modes.c
    action      i830_shadow.c
    action      i830_video.c

    dst_dir driver/xf86-video-i810/man

    action      i810.man    i810.4

    src_dir lib/XvMC/hw/i810
    dst_dir driver/xf86-video-i810/src/xvmc

    action I810XvMC.c
    action I810XvMC.h
}

symlink_driver_imstt() {
    src_dir programs/Xserver/hw/xfree86/drivers/imstt
    dst_dir driver/xf86-video-imstt/src

    action      imstt.h
    action      imstt_accel.c
    action      imstt_driver.c
    action      imstt_reg.h

    dst_dir driver/xf86-video-imstt/man

    action      imstt.man   imstt.4
}

symlink_driver_mga() {
    src_dir programs/Xserver/hw/xfree86/drivers/mga
    dst_dir driver/xf86-video-mga

    action	mga_PInS.txt
    action	README_HALLIB

    src_dir programs/Xserver/hw/xfree86/drivers/mga/util
    dst_dir driver/xf86-video-mga/util

    action	README
    action	stormdwg.c

    src_dir programs/Xserver/hw/xfree86/drivers/mga
    dst_dir driver/xf86-video-mga/src

    action      client.h
    action      clientlx.c
    action      mga.h
    action      mga_arc.c
    action      mga_bios.c
    action      mga_common.h
    action      mga_dac3026.c
    action      mga_dacG.c
    action      mga_dga.c
    action      mga_dh.c
    action      mga_dri.c
    action      mga_dri.h
    action      mga_dripriv.h
    action      mga_driver.c
    action      mga_esc.c
    action      mga_g450pll.c
    action      mga_halmod.c
    action      mga_hwcurs.c
    action      mga_macros.h
    action      mga_map.h
    action      mga_maven.h
    action      mga_merge.c
    action      mga_merge.h
    action      mga_reg.h
    action      mga_sarea.h
    action      mga_shadow.c
    action      mga_storm.c
    action      mga_ucode.h
    action      mga_video.c
    action      mgareg_flags.h

    src_dir programs/Xserver/hw/xfree86/drivers/mga/HALlib

    action	binding.h

    src_dir programs/Xserver/hw/xfree86/drivers/mga
    dst_dir driver/xf86-video-mga/man

    action      mga.man     mga.4
}

symlink_driver_neomagic() {
    src_dir programs/Xserver/hw/xfree86/drivers/neomagic
    dst_dir driver/xf86-video-neomagic

    action	NM-reg.txt
    action	README
    action	TODO

    src_dir programs/Xserver/hw/xfree86/drivers/neomagic
    dst_dir driver/xf86-video-neomagic/src

    action      neo.h
    action      neo_2070.c
    action      neo_2090.c
    action      neo_2097.c
    action      neo_2200.c
    action      neo_bank.c
    action      neo_cursor.c
    action      neo_dga.c
    action      neo_driver.c
    action      neo_i2c.c
    action      neo_macros.h
    action      neo_reg.h
    action      neo_shadow.c
    action      neo_video.c
    action      neo_video.h

    dst_dir driver/xf86-video-neomagic/man

    action      neomagic.man    neomagic.4
}

symlink_driver_newport() {
    src_dir programs/Xserver/hw/xfree86/drivers/newport
    dst_dir driver/xf86-video-newport

    action	XF86Config.indy

    src_dir programs/Xserver/hw/xfree86/drivers/newport
    dst_dir driver/xf86-video-newport/src

    action      newport.h
    action      newport_accel.c
    action      newport_cmap.c
    action      newport_cursor.c
    action      newport_driver.c
    action      newport_regs.c
    action      newport_regs.h
    action      newport_shadow.c

    dst_dir driver/xf86-video-newport/man

    action      newport.man     newport.4
}

symlink_driver_nsc() {
    src_dir programs/Xserver/hw/xfree86/drivers/nsc
    dst_dir driver/xf86-video-nsc/src

    action      durango.c
    action      nsc.h
    action      nsc_driver.c
    action      nsc_fourcc.h
    action      nsc_galfns.c
    action      nsc_galstub.c
    action      nsc_gx1_accel.c
    action      nsc_gx1_cursor.c
    action      nsc_gx1_dga.c
    action      nsc_gx1_driver.c
    action      nsc_gx1_shadow.c
    action      nsc_gx1_video.c
    action      nsc_gx2_accel.c
    action      nsc_gx2_cursor.c
    action      nsc_gx2_dga.c
    action      nsc_gx2_driver.c
    action      nsc_gx2_shadow.c
    action      nsc_gx2_vga.c
    action      nsc_gx2_video.c
    action      nsc_regacc.c
    action	nsc_msr_asm.S
    action      panel.c

    dst_dir driver/xf86-video-nsc/man

    action      nsc.man     nsc.4

    src_dir programs/Xserver/hw/xfree86/drivers/nsc/gfx
    dst_dir driver/xf86-video-nsc/src/gfx

    action	disp_gu1.c
    action	disp_gu2.c
    action	gfx_dcdr.c
    action	gfx_defs.h
    action	gfx_disp.c
    action	gfx_i2c.c
    action	gfx_init.c
    action	gfx_mode.h
    action	gfx_msr.c
    action	gfx_regs.h
    action	gfx_rndr.c
    action	gfx_rtns.h
    action	gfx_tv.c
    action	gfx_type.h
    action	gfx_vga.c
    action	gfx_vid.c
    action	gfx_vip.c
    action	i2c_acc.c
    action	i2c_gpio.c
    action	init_gu1.c
    action	init_gu2.c
    action	msr_rdcl.c
    action	rndr_gu1.c
    action	rndr_gu2.c
    action	saa7114.c
    action	tv_1200.c
    action	vga_gu1.c
    action	vid_1200.c
    action	vid_5530.c
    action	vid_rdcl.c
    action	vip_1200.c

    # These files are not actually used, but it probably makes sense to
    # distribute them along with the rest of gfx
    
    action	durango.c
    action	gfx_tv.h
    action	history.h
    action	release.txt
    action	tv_fs450.c
    action	tv_fs450.h
    action	tv_fs451.c
    action	tv_geode.c
    action	vid_1400.c
    action	vip_1400.c

    src_dir programs/Xserver/hw/xfree86/drivers/nsc/panel
    dst_dir driver/xf86-video-nsc/src/panel

    action	92xx.h
    action	cen9211.c
    action	cen9211.h
    action	dora9211.c
    action	dora9211.h
    action	drac9210.c
    action	drac9210.h
    action	gx2_9211.c
    action	gx2_9211.h
    action	panel.c
    action	panel.h
    action	platform.c
    action	pnl_bios.c
    action	pnl_defs.h
    action	pnl_init.c

    action	readme.txt
}

symlink_driver_nv() {
    src_dir programs/Xserver/hw/xfree86/drivers/nv
    dst_dir driver/xf86-video-nv/src

    action      nv_const.h
    action      nv_cursor.c
    action      nv_dac.c
    action      nv_dga.c
    action      nv_dma.h
    action      nv_driver.c
    action      nv_hw.c
    action      nv_include.h
    action      nv_local.h
    action      nv_proto.h
    action      nv_setup.c
    action      nv_shadow.c
    action      nv_type.h
    action      nv_video.c
    action      nv_xaa.c
    action      nvreg.h
    action      nvvga.h
    action      riva_const.h
    action      riva_cursor.c
    action      riva_dac.c
    action      riva_dga.c
    action      riva_driver.c
    action      riva_hw.c
    action      riva_hw.h
    action      riva_include.h
    action      riva_local.h
    action      riva_proto.h
    action      riva_setup.c
    action      riva_shadow.c
    action      riva_tbl.h
    action      riva_type.h
    action      riva_xaa.c

    dst_dir driver/xf86-video-nv/man
    action      nv.man  nv.4

    src_dir programs/Xserver/hw/xfree86/doc
    dst_dir driver/xf86-video-nv
    action	README.NV1
}

symlink_driver_rendition() {
    src_dir programs/Xserver/hw/xfree86/drivers/rendition
    dst_dir driver/xf86-video-rendition/src

    action      README.uc
    action      accel.h
    action      accelX.c
    action      cmd2d.h
    action      commonregs.h
    action      cscode.h
    action      hwcursor.c
    action      hwcursor.h
    action      rendition.c
    action      rendition.h
    action      rendition_options.h
    action      rendition_shadow.c
    action      rendition_shadow.h
    action      v10002d.uc
    action      v20002d.uc
    action      v1kregs.h
    action      v1krisc.c
    action      v1krisc.h
    action      v2kregs.h
    action      vboard.c
    action      vboard.h
    action      vloaduc.c
    action      vloaduc.h
    action      vmisc.c
    action      vmisc.h
    action      vmodes.c
    action      vmodes.h
    action      vos.h
    action      vramdac.c
    action      vramdac.h
    action      vtypes.h

    action	vgafont-std.data
    action	vgafont-vrx.data
    action	vgapalette.data

    dst_dir driver/xf86-video-rendition/man

    action      rendition.man   rendition.4
}

symlink_driver_s3() {
    src_dir programs/Xserver/hw/xfree86/drivers/s3
    dst_dir driver/xf86-video-s3/src

    action      newmmio.h
    action      s3.h
    action      s3_IBMRGB.c
    action      s3_Ti.c
    action      s3_Trio64DAC.c
    action      s3_accel.c
    action      s3_bios.c
    action      s3_cursor.c
    action      s3_dga.c
    action      s3_driver.c
    action      s3_reg.h
    action      s3_video.c

    dst_dir driver/xf86-video-s3/man

}

symlink_driver_s3virge() {
    src_dir programs/Xserver/hw/xfree86/drivers/s3virge
    dst_dir driver/xf86-video-s3virge

    action	CALLMAP
    action	README
    action	TODO_NOTES

    src_dir programs/Xserver/hw/xfree86/drivers/s3virge
    dst_dir driver/xf86-video-s3virge/src

    action      newmmio.h
    action      regs3v.h
    action      s3v.h
    action      s3v_accel.c
    action      s3v_dac.c
    action      s3v_dga.c
    action      s3v_driver.c
    action      s3v_hwcurs.c
    action      s3v_i2c.c
    action      s3v_macros.h
    action      s3v_rop.h
    action      s3v_shadow.c
    action      s3v_xv.c

    dst_dir driver/xf86-video-s3virge/man

    action      s3virge.man     s3virge.4
}

symlink_driver_savage() {
    src_dir programs/Xserver/hw/xfree86/drivers/savage
    dst_dir driver/xf86-video-savage/src

    action      savage_accel.c
    action      savage_bci.h
    action      savage_common.h
    action      savage_cursor.c
    action      savage_dga.c
    action      savage_dri.c
    action      savage_dri.h
    action      savage_dripriv.h
    action      savage_driver.c
    action      savage_driver.h
    action      savage_drm.h
    action      savage_hwmc.c
    action      savage_i2c.c
    action      savage_image.c
    action      savage_regs.h
    action      savage_sarea.h
    action      savage_shadow.c
    action      savage_streams.c
    action      savage_streams.h
    action      savage_vbe.c
    action      savage_vbe.h
    action      savage_video.c

    dst_dir driver/xf86-video-savage/man

    action      savage.man      savage.4
}

symlink_driver_siliconmotion() {
    src_dir programs/Xserver/hw/xfree86/drivers/siliconmotion
    dst_dir driver/xf86-video-siliconmotion

    action	README
    action	CALLMAP
    action	Release.txt

    src_dir programs/Xserver/hw/xfree86/drivers/siliconmotion
    dst_dir driver/xf86-video-siliconmotion/src

    action      regsmi.h
    action      smi.h
    action      smi_accel.c
    action      smi_dac.c
    action      smi_dga.c
    action      smi_driver.c
    action      smi_hwcurs.c
    action      smi_i2c.c
    action      smi_shadow.c
    action      smi_video.c
    action      smi_video.h

    dst_dir driver/xf86-video-siliconmotion/man

    action      siliconmotion.man   siliconmotion.4
}

symlink_driver_sis() {
    src_dir programs/Xserver/hw/xfree86/drivers/sis
    dst_dir driver/xf86-video-sis/src

    action      300vtbl.h
    action      310vtbl.h
    action      init.c
    action      init.h
    action      init301.c
    action      init301.h
    action      initdef.h
    action      initextx.c
    action      initextx.h
    action      oem300.h
    action      oem310.h
    action      osdef.h
    action      sis.h
    action      sis300_accel.c
    action      sis300_accel.h
    action      sis310_accel.c
    action      sis310_accel.h
    action      sis6326_video.c
    action      sis_accel.c
    action      sis_accel.h
    action      sis_common.h
    action      sis_cursor.c
    action      sis_cursor.h
    action      sis_dac.c
    action      sis_dac.h
    action      sis_dga.c
    action      sis_dri.c
    action      sis_dri.h
    action      sis_driver.c
    action      sis_driver.h
    action      sis_memcpy.c
    action      sis_opt.c
    action      sis_regs.h
    action      sis_setup.c
    action      sis_shadow.c
    action      sis_utility.c
    action      sis_vb.c
    action      sis_vga.c
    action      sis_video.c
    action      sis_video.h
    action      sis_videostr.h
    action      vgatypes.h
    action      vstruct.h

    dst_dir driver/xf86-video-sis/man

    action      sis.man     sis.4
}

symlink_driver_sisusb() {
    src_dir programs/Xserver/hw/xfree86/drivers/sisusb
    dst_dir driver/xf86-video-sisusb/src

    action      sisusb.h
    action      sisusb_accel.c
    action      sisusb_accel.h
    action      sisusb_cursor.c
    action      sisusb_cursor.h
    action      sisusb_dac.c
    action      sisusb_dac.h
    action      sisusb_driver.c
    action      sisusb_driver.h
    action      sisusb_init.c
    action      sisusb_init.h
    action      sisusb_opt.c
    action      sisusb_osdef.h
    action      sisusb_regs.h
    action      sisusb_setup.c
    action      sisusb_shadow.c
    action      sisusb_struct.h
    action      sisusb_types.h
    action      sisusb_utility.c
    action      sisusb_vga.c
    action      sisusb_video.c
    action      sisusb_video.h
    action      sisusb_videostr.h

    dst_dir driver/xf86-video-sisusb/man

    action      sisusb.man      sisusb.4
}

symlink_driver_sunbw2() {
    src_dir programs/Xserver/hw/xfree86/drivers/sunbw2
    dst_dir driver/xf86-video-sunbw2/src

    action      bw2.h
    action      bw2_driver.c

    dst_dir driver/xf86-video-sunbw2/man

    action      sunbw2.man  sunbw2.4
}

symlink_driver_suncg14() {
    src_dir programs/Xserver/hw/xfree86/drivers/suncg14
    dst_dir driver/xf86-video-suncg14/src

    action      cg14.h
    action      cg14_driver.c

    dst_dir driver/xf86-video-suncg14/man

    action      suncg14.man     subcg14.4
}

symlink_driver_suncg3() {
    src_dir programs/Xserver/hw/xfree86/drivers/suncg3
    dst_dir driver/xf86-video-suncg3/src

    action      cg3.h
    action      cg3_driver.c

    dst_dir driver/xf86-video-suncg3/man

    action      suncg3.man  subcg3.4
}

symlink_driver_suncg6() {
    src_dir programs/Xserver/hw/xfree86/drivers/suncg6
    dst_dir driver/xf86-video-suncg6/src

    action      cg6.h
    action      cg6_cursor.c
    action      cg6_driver.c
    action      cg6_regs.h

    dst_dir driver/xf86-video-suncg6/man

    action      suncg6.man  subcg6.4
}

symlink_driver_sunffb() {
    src_dir programs/Xserver/hw/xfree86/drivers/sunffb
    dst_dir driver/xf86-video-sunffb/src

    action      ffb.h
    action      ffb_accel.c
    action      ffb_attr.c
    action      ffb_bcopy.c
    action      ffb_checks.c
    action      ffb_circle.c
    action      ffb_clip.c
    action      ffb_clip.h
    action      ffb_cplane.c
    action      ffb_cursor.c
    action      ffb_dac.c
    action      ffb_dac.h
    action      ffb_dbe.c
    action      ffb_ddc.c
    action      ffb_dga.c
    action      ffb_dri.c
    action      ffb_drishare.h
    action      ffb_driver.c
    action      ffb_fifo.h
    action      ffb_frect.c
    action      ffb_fspans.c
    action      ffb_gc.c
    action      ffb_gc.h
    action      ffb_glyph.c
    action      ffb_gspans.c
    action      ffb_line.c
    action      ffb_loops.h
    action      ffb_plygon.c
    action      ffb_point.c
    action      ffb_rcache.h
    action      ffb_rect.c
    action      ffb_regs.h
    action      ffb_seg.c
    action      ffb_sspans.c
    action      ffb_stip.c
    action      ffb_stip.h
    action      ffb_stubs.c
    action      ffb_wid.c
    action      ffb_wline.c
    action      ffb_zeroarc.c
    action	ffb_asm.s
    action	VISmoveImage.s

    dst_dir driver/xf86-video-sunffb/man

    action      sunffb.man      sunffb.4
}

symlink_driver_sunleo() {
    src_dir programs/Xserver/hw/xfree86/drivers/sunleo
    dst_dir driver/xf86-video-sunleo/src

    action      leo.h
    action      leo_accel.c
    action      leo_checks.c
    action      leo_cursor.c
    action      leo_driver.c
    action      leo_frect.c
    action      leo_frectsp.c
    action      leo_fspans.c
    action      leo_fspanssp.c
    action      leo_glyph.c
    action      leo_regs.h

    dst_dir driver/xf86-video-sunleo/man

    action      sunleo.man  sunleo.4
}

symlink_driver_suntcx() {
    src_dir programs/Xserver/hw/xfree86/drivers/suntcx
    dst_dir driver/xf86-video-suntcx/src

    action      tcx.h
    action      tcx_cursor.c
    action      tcx_driver.c
    action      tcx_regs.h

    dst_dir driver/xf86-video-suntcx/man

    action      suntcx.man  suntcx.4
}

symlink_driver_tdfx() {
    src_dir programs/Xserver/hw/xfree86/drivers/tdfx
    dst_dir driver/xf86-video-tdfx/src

    action      tdfx.h
    action      tdfx_accel.c
    action      tdfx_dga.c
    action      tdfx_dri.c
    action      tdfx_dri.h
    action      tdfx_dripriv.h
    action      tdfx_driver.c
    action      tdfx_hwcurs.c
    action      tdfx_io.c
    action      tdfx_priv.c
    action      tdfx_priv.h
    action      tdfx_sli.c
    action      tdfx_video.c
    action      tdfxdefs.h

    dst_dir driver/xf86-video-tdfx/man

    action      tdfx.man    tdfx.4
}

symlink_driver_tga() {
    src_dir programs/Xserver/hw/xfree86/drivers/tga
    dst_dir driver/xf86-video-tga/src

    action      BT463ramdac.c
    action      BTramdac.c
    action      IBM561ramdac.c
    action      ICS1562.c
    action      tga.h
    action      tga_accel.c
    action      tga_cursor.c
    action      tga_dac.c
    action      tga_driver.c
    action      tga_line.c
    action      tga_regs.h

    dst_dir driver/xf86-video-tga/man

}

symlink_driver_trident() {
    src_dir programs/Xserver/hw/xfree86/drivers/trident
    dst_dir driver/xf86-video-trident/src

    action      blade_accel.c
    action      image_accel.c
    action      trident.h
    action      trident_accel.c
    action      trident_bank.c
    action      trident_dac.c
    action      trident_dga.c
    action      trident_driver.c
    action      trident_i2c.c
    action      trident_regs.h
    action      trident_shadow.c
    action      trident_tv.c
    action      trident_video.c
    action      tridenthelper.c
    action      tridentramdac.c
    action      tvga_dac.c
    action      xp_accel.c

    dst_dir driver/xf86-video-trident/man

    action      trident.man     trident.4
}

symlink_driver_tseng() {
    src_dir programs/Xserver/hw/xfree86/drivers/tseng
    dst_dir driver/xf86-video-tseng/src

    action	README

    src_dir programs/Xserver/hw/xfree86/drivers/tseng
    dst_dir driver/xf86-video-tseng/src

    action      tseng.h
    action      tseng_accel.c
    action      tseng_acl.c
    action      tseng_acl.h
    action      tseng_bank.c
    action      tseng_clock.c
    action      tseng_colexp.c
    action      tseng_cursor.c
    action      tseng_dga.c
    action      tseng_dpms.c
    action      tseng_driver.c
    action      tseng_inline.h
    action      tseng_ramdac.c

    dst_dir driver/xf86-video-tseng/man

    action      tseng.man   tseng.4
}

symlink_driver_v4l() {
    src_dir programs/Xserver/hw/xfree86/drivers/v4l
    dst_dir driver/xf86-video-v4l

    action      README

    dst_dir driver/xf86-video-v4l/src

    action      v4l.c
    action      videodev.h

    dst_dir driver/xf86-video-v4l/man

    action      v4l.man     v4l.4
}

symlink_driver_vesa() {
    src_dir programs/Xserver/hw/xfree86/drivers/vesa
    dst_dir driver/xf86-video-vesa/src

    action      vesa.c
    action      vesa.h

    dst_dir driver/xf86-video-vesa/man

    action      vesa.man    vesa.4
}

symlink_driver_vga() {
    src_dir programs/Xserver/hw/xfree86/drivers/vga
    dst_dir driver/xf86-video-vga/src

    action      generic.c

    dst_dir driver/xf86-video-vga/man

    action      vga.man     vga.4
}

symlink_driver_via() {
    src_dir programs/Xserver/hw/xfree86/drivers/via
    dst_dir driver/xf86-video-via/src

    action      via.h
    action      via_accel.c
    action	via_bios.h
    action      via_bandwidth.c
    action      via_cursor.c
    action      via_dga.c
    action      via_dri.c
    action      via_dri.h
    action      via_driver.c
    action      via_driver.h
    action      via_i2c.c
    action      via_id.c
    action      via_id.h
    action      via_memcpy.c
    action      via_memcpy.h
    action      via_memory.c
    action      via_mode.c
    action      via_mode.h
    action      via_priv.h
    action      via_regs.h
    action      via_shadow.c
    action      via_swov.c
    action      via_swov.h
    action      via_vgahw.c
    action      via_vgahw.h
    action      via_video.c
    action      via_video.h
    action      via_vt162x.c
    action      via_vt162x.h
    action      via_xvmc.c
    action      via_xvmc.h
    action      via_xvpriv.h
    action	via_drmclient.h
    action	via_vbe.c

    dst_dir driver/xf86-video-via/man

    action      via.man     via.4

    src_dir lib/XvMC/hw/via
    dst_dir driver/xf86-video-via/src/xvmc

    action	driDrawable.c
    action	driDrawable.h
    action	viaLowLevel.h
    action	viaXvMC.c
    action	viaXvMCPriv.h
    action	xf86dri.c
    action	xf86dri.h
    action	xf86dristr.h

    src_dir lib/XvMC/hw/via/unichrome
    dst_dir driver/xf86-video-via/src/xvmc/unichrome
    
    action	viaLowLevel.c

    src_dir lib/XvMC/hw/via/unichromeProA
    dst_dir driver/xf86-video-via/src/xvmc/unichromeProA
    
    action	viaLowLevelPro.c
}

symlink_driver_vmware() {
    src_dir programs/Xserver/hw/xfree86/drivers/vmware
    dst_dir driver/xf86-video-vmware
    
    action	README

    src_dir programs/Xserver/hw/xfree86/drivers/vmware
    dst_dir driver/xf86-video-vmware/src

    action      bits2pixels.c
    action      bits2pixels.h
    action      guest_os.h
    action      includeCheck.h
    action      offscreen_manager.c
    action      offscreen_manager.h
    action      svga_limits.h
    action      svga_reg.h
    action      svga_struct.h
    action      vm_basic_types.h
    action      vm_device_version.h
    action      vmware.c
    action      vmware.h
    action      vmwarecurs.c
    action      vmwarexaa.c

    dst_dir driver/xf86-video-vmware/man

    action      vmware.man  vmware.4
}

symlink_driver_voodoo() {
    src_dir programs/Xserver/hw/xfree86/drivers/voodoo
    dst_dir driver/xf86-video-voodoo

    action	README
    action	TODO

    src_dir programs/Xserver/hw/xfree86/drivers/voodoo
    dst_dir driver/xf86-video-voodoo/src

    action      voodoo.h
    action      voodoo_dga.c
    action      voodoo_driver.c
    action      voodoo_hardware.c

    dst_dir driver/xf86-video-voodoo/man

    action      voodoo.man  voodoo.4
}

symlink_driver_wsfb() {
    src_dir programs/Xserver/hw/xfree86/drivers/wsfb
    dst_dir driver/xf86-video-wsfb/src

    action      wsfb_driver.c

    dst_dir driver/xf86-video-wsfb/man

    action      wsfb.man    wsfb.4
}

symlink_driver_acecad() {
    src_dir programs/Xserver/hw/xfree86/input/acecad
    dst_dir driver/xf86-input-acecad/src

    action      acecad.c
    action      acecad.h

    dst_dir driver/xf86-input-acecad/man

    action      acecad.man  acecad.4
}

symlink_driver_aiptek() {
    src_dir programs/Xserver/hw/xfree86/input/aiptek
    dst_dir driver/xf86-input-aiptek/src

    action      xf86Aiptek.c
    action      xf86Aiptek.h

    dst_dir driver/xf86-input-aiptek/man

    action      aiptek.man  aiptek.4
}

symlink_driver_calcomp() {
    src_dir programs/Xserver/hw/xfree86/input/calcomp
    dst_dir driver/xf86-input-calcomp/src

    action      xf86Calcomp.c
    action      xf86Calcomp.h

    dst_dir driver/xf86-input-calcomp/man

    action      calcomp.man     calcomp.4
}

symlink_driver_citron() {
    src_dir programs/Xserver/hw/xfree86/input/citron
    dst_dir driver/xf86-input-citron/src

    action      citron.c
    action      citron.h

    dst_dir driver/xf86-input-citron/man

    action      citron.man  citron.4
}

symlink_driver_digitaledge() {
    src_dir programs/Xserver/hw/xfree86/input/digitaledge
    dst_dir driver/xf86-input-digitaledge/src

    action      DigitalEdge.c

    dst_dir driver/xf86-input-digitaledge/man

}

symlink_driver_dmc() {
    src_dir programs/Xserver/hw/xfree86/input/dmc
    dst_dir driver/xf86-input-dmc/src

    action      xf86DMC.c
    action      xf86DMC.h

    dst_dir driver/xf86-input-dmc/man

    action      dmc.man     dmc.4
}

symlink_driver_dynapro() {
    src_dir programs/Xserver/hw/xfree86/input/dynapro
    dst_dir driver/xf86-input-dynapro/src

    action      xf86Dyna.c
    action      xf86Dyna.h

    dst_dir driver/xf86-input-dynapro/man

    action      dynapro.man     dynapro.4
}

symlink_driver_elo2300() {
    src_dir programs/Xserver/hw/xfree86/input/elo2300
    dst_dir driver/xf86-input-elo2300/src

    action      elo.c
    action      elo.h

    dst_dir driver/xf86-input-elo2300/man

}

symlink_driver_elographics() {
    src_dir programs/Xserver/hw/xfree86/input/elographics
    dst_dir driver/xf86-input-elographics/src

    action      xf86Elo.c

    dst_dir driver/xf86-input-elographics/man

    action      elographics.man     elographics.4
}

symlink_driver_evdev() {
    src_dir programs/Xserver/hw/xfree86/input/evdev
    dst_dir driver/xf86-input-evdev/src

    action      evdev.c

    dst_dir driver/xf86-input-evdev/man

}

symlink_driver_fpit() {
    src_dir programs/Xserver/hw/xfree86/input/fpit

    dst_dir driver/xf86-input-fpit
    action      readme.txt
    
    dst_dir driver/xf86-input-fpit/src
    action      xf86Fpit.c

    dst_dir driver/xf86-input-fpit/man
    action      fpit.man    fpit.4
}

symlink_driver_hyperpen() {
    src_dir programs/Xserver/hw/xfree86/input/hyperpen
    dst_dir driver/xf86-input-hyperpen/src

    action      xf86HyperPen.c

    dst_dir driver/xf86-input-hyperpen/man

}

symlink_driver_jamstudio() {
    src_dir programs/Xserver/hw/xfree86/input/jamstudio
    dst_dir driver/xf86-input-jamstudio/src

    action      js_x.c

    dst_dir driver/xf86-input-jamstudio/man

    action      js_x.man    js_x.4
}

symlink_driver_joystick() {
    src_dir programs/Xserver/hw/xfree86/input/joystick
    dst_dir driver/xf86-input-joystick/src

    action      xf86Jstk.c

    dst_dir driver/xf86-input-joystick/man

}

symlink_driver_keyboard() {
    src_dir programs/Xserver/hw/xfree86/input/keyboard
    dst_dir driver/xf86-input-keyboard/src

    action      kbd.c

    dst_dir driver/xf86-input-keyboard/man

    action      kbd.man         kbd.4
    action      keyboard.man    keyboard.4
}

symlink_driver_magellan() {
    src_dir programs/Xserver/hw/xfree86/input/magellan
    dst_dir driver/xf86-input-magellan/src

    action      magellan.c
    action      magellan.h

    dst_dir driver/xf86-input-magellan/man

}

symlink_driver_magictouch() {
    src_dir programs/Xserver/hw/xfree86/input/magictouch
    dst_dir driver/xf86-input-magictouch/src

    action      xf86MagicTouch.c

    dst_dir driver/xf86-input-magictouch/man

    action      magictouch.man  magictouch.4
}

symlink_driver_microtouch() {
    src_dir programs/Xserver/hw/xfree86/input/microtouch
    dst_dir driver/xf86-input-microtouch/src

    action      microtouch.c
    action      microtouch.h

    dst_dir driver/xf86-input-microtouch/man

    action      microtouch.man  microtouch.4
}

symlink_driver_mouse() {
    src_dir programs/Xserver/hw/xfree86/input/mouse
    dst_dir driver/xf86-input-mouse/src

    action	mouse.c
    action	mouse.h
    action	mousePriv.h
    action	pnp.c

    dst_dir driver/xf86-input-mouse/man

    action	mouse.man   mouse.4
}

symlink_driver_mutouch() {
    src_dir programs/Xserver/hw/xfree86/input/mutouch
    dst_dir driver/xf86-input-mutouch/src

    action      xf86MuTouch.c

    dst_dir driver/xf86-input-mutouch/man

    action      mutouch.man     mutouch.4
}

symlink_driver_palmax() {
    src_dir programs/Xserver/hw/xfree86/input/palmax
    dst_dir driver/xf86-input-palmax/src

    action      xf86Palmax.c

    dst_dir driver/xf86-input-palmax/man

    action      palmax.man  palmax.4
}

symlink_driver_penmount() {
    src_dir programs/Xserver/hw/xfree86/input/penmount
    dst_dir driver/xf86-input-penmount/src

    action      xf86PM.c
    action      xf86PM.h

    dst_dir driver/xf86-input-penmount/man

    action      penmount.man    penmount.4
}

symlink_driver_spaceorb() {
    src_dir programs/Xserver/hw/xfree86/input/spaceorb
    dst_dir driver/xf86-input-spaceorb/src

    action      spaceorb.c
    action      spaceorb.h

    dst_dir driver/xf86-input-spaceorb/man

}

symlink_driver_summa() {
    src_dir programs/Xserver/hw/xfree86/input/summa
    dst_dir driver/xf86-input-summa/src

    action      xf86Summa.c

    dst_dir driver/xf86-input-summa/man

}

symlink_driver_tek4957() {
    src_dir programs/Xserver/hw/xfree86/input/tek4957
    dst_dir driver/xf86-input-tek4957/src

    action      xf86Tek4957.c

    dst_dir driver/xf86-input-tek4957/man

    action      tek4957.man     tek4957.4
}

symlink_driver_ur98() {
    src_dir programs/Xserver/hw/xfree86/input/ur98
    dst_dir driver/xf86-input-ur98/src

    action      xf86Ur-98.c

    dst_dir driver/xf86-input-ur98/man

    action      ur98.man    ur98.4
}

symlink_driver_void() {
    src_dir programs/Xserver/hw/xfree86/input/void
    dst_dir driver/xf86-input-void/src

    action      void.c

    dst_dir driver/xf86-input-void/man

    action      void.man    void.4
}

symlink_driver() {
    symlink_driver_apm
    symlink_driver_ark
    symlink_driver_ati
    symlink_driver_chips
    symlink_driver_cirrus
    symlink_driver_cyrix
    symlink_driver_dummy
    symlink_driver_fbdev
    symlink_driver_glide
    symlink_driver_glint
    symlink_driver_i128
    symlink_driver_i740
    symlink_driver_i810
    symlink_driver_imstt
    symlink_driver_mga
    symlink_driver_neomagic
    symlink_driver_newport
    symlink_driver_nsc
    symlink_driver_nv
    symlink_driver_rendition
    symlink_driver_s3
    symlink_driver_s3virge
    symlink_driver_savage
    symlink_driver_siliconmotion
    symlink_driver_sis
    symlink_driver_sisusb
    symlink_driver_sunbw2
    symlink_driver_suncg14
    symlink_driver_suncg3
    symlink_driver_suncg6
    symlink_driver_sunffb
    symlink_driver_sunleo
    symlink_driver_suntcx
    symlink_driver_tdfx
    symlink_driver_tga
    symlink_driver_trident
    symlink_driver_tseng
    symlink_driver_v4l
    symlink_driver_vesa
    symlink_driver_vga
    symlink_driver_via
    symlink_driver_vmware
    symlink_driver_voodoo
    symlink_driver_wsfb

    symlink_driver_acecad
    symlink_driver_aiptek
    symlink_driver_calcomp
    symlink_driver_citron
    symlink_driver_digitaledge
    symlink_driver_dmc
    symlink_driver_dynapro
    symlink_driver_elo2300
    symlink_driver_elographics
    symlink_driver_evdev
    symlink_driver_fpit
    symlink_driver_hyperpen
    symlink_driver_jamstudio
    symlink_driver_joystick
    symlink_driver_keyboard
    symlink_driver_magellan
    symlink_driver_magictouch
    symlink_driver_microtouch
    symlink_driver_mouse
    symlink_driver_mutouch
    symlink_driver_palmax
    symlink_driver_penmount
    symlink_driver_spaceorb
    symlink_driver_summa
    symlink_driver_tek4957
    symlink_driver_ur98
    symlink_driver_void
#    ...
}


#########
#
#	The font module
#
#########

symlink_font_adobe_100dpi() {
    src_dir fonts/bdf/100dpi
    dst_dir font/adobe-100dpi

    action	courB08.bdf
    action	courB10.bdf
    action	courB12.bdf
    action	courB14.bdf
    action	courB18.bdf
    action	courB24.bdf
    action	courBO08.bdf
    action	courBO10.bdf
    action	courBO12.bdf
    action	courBO14.bdf
    action	courBO18.bdf
    action	courBO24.bdf
    action	courO08.bdf
    action	courO10.bdf
    action	courO12.bdf
    action	courO14.bdf
    action	courO18.bdf
    action	courO24.bdf
    action	courR08.bdf
    action	courR10.bdf
    action	courR12.bdf
    action	courR14.bdf
    action	courR18.bdf
    action	courR24.bdf
    action	helvB08.bdf
    action	helvB10.bdf
    action	helvB12.bdf
    action	helvB14.bdf
    action	helvB18.bdf
    action	helvB24.bdf
    action	helvBO08.bdf
    action	helvBO10.bdf
    action	helvBO12.bdf
    action	helvBO14.bdf
    action	helvBO18.bdf
    action	helvBO24.bdf
    action	helvO08.bdf
    action	helvO10.bdf
    action	helvO12.bdf
    action	helvO14.bdf
    action	helvO18.bdf
    action	helvO24.bdf
    action	helvR08.bdf
    action	helvR10.bdf
    action	helvR12.bdf
    action	helvR14.bdf
    action	helvR18.bdf
    action	helvR24.bdf
    action	ncenB08.bdf
    action	ncenB10.bdf
    action	ncenB12.bdf
    action	ncenB14.bdf
    action	ncenB18.bdf
    action	ncenB24.bdf
    action	ncenBI08.bdf
    action	ncenBI10.bdf
    action	ncenBI12.bdf
    action	ncenBI14.bdf
    action	ncenBI18.bdf
    action	ncenBI24.bdf
    action	ncenI08.bdf
    action	ncenI10.bdf
    action	ncenI12.bdf
    action	ncenI14.bdf
    action	ncenI18.bdf
    action	ncenI24.bdf
    action	ncenR08.bdf
    action	ncenR10.bdf
    action	ncenR12.bdf
    action	ncenR14.bdf
    action	ncenR18.bdf
    action	ncenR24.bdf
    action	symb08.bdf
    action	symb10.bdf
    action	symb12.bdf
    action	symb14.bdf
    action	symb18.bdf
    action	symb24.bdf
    action	timB08.bdf
    action	timB10.bdf
    action	timB12.bdf
    action	timB14.bdf
    action	timB18.bdf
    action	timB24.bdf
    action	timBI08.bdf
    action	timBI10.bdf
    action	timBI12.bdf
    action	timBI14.bdf
    action	timBI18.bdf
    action	timBI24.bdf
    action	timI08.bdf
    action	timI10.bdf
    action	timI12.bdf
    action	timI14.bdf
    action	timI18.bdf
    action	timI24.bdf
    action	timR08.bdf
    action	timR10.bdf
    action	timR12.bdf
    action	timR14.bdf
    action	timR18.bdf
    action	timR24.bdf
}

symlink_font_adobe_utopia_100dpi() {
    src_dir fonts/bdf/100dpi
    dst_dir font/adobe-utopia-100dpi

# XXX These fonts are copyright Adobe, but all rights reserved
    action	UTB___10.bdf
    action	UTB___12.bdf
    action	UTB___14.bdf
    action	UTB___18.bdf
    action	UTB___24.bdf
    action	UTBI__10.bdf
    action	UTBI__12.bdf
    action	UTBI__14.bdf
    action	UTBI__18.bdf
    action	UTBI__24.bdf
    action	UTI___10.bdf
    action	UTI___12.bdf
    action	UTI___14.bdf
    action	UTI___18.bdf
    action	UTI___24.bdf
    action	UTRG__10.bdf
    action	UTRG__12.bdf
    action	UTRG__14.bdf
    action	UTRG__18.bdf
    action	UTRG__24.bdf
}

symlink_font_bh_100dpi() {
    src_dir fonts/bdf/100dpi
    dst_dir font/bh-100dpi

    action	lubB08.bdf
    action	lubB10.bdf
    action	lubB12.bdf
    action	lubB14.bdf
    action	lubB18.bdf
    action	lubB19.bdf
    action	lubB24.bdf
    action	lubBI08.bdf
    action	lubBI10.bdf
    action	lubBI12.bdf
    action	lubBI14.bdf
    action	lubBI18.bdf
    action	lubBI19.bdf
    action	lubBI24.bdf
    action	lubI08.bdf
    action	lubI10.bdf
    action	lubI12.bdf
    action	lubI14.bdf
    action	lubI18.bdf
    action	lubI19.bdf
    action	lubI24.bdf
    action	luBIS08.bdf
    action	luBIS10.bdf
    action	luBIS12.bdf
    action	luBIS14.bdf
    action	luBIS18.bdf
    action	luBIS19.bdf
    action	luBIS24.bdf
    action	lubR08.bdf
    action	lubR10.bdf
    action	lubR12.bdf
    action	lubR14.bdf
    action	lubR18.bdf
    action	lubR19.bdf
    action	lubR24.bdf
    action	luBS08.bdf
    action	luBS10.bdf
    action	luBS12.bdf
    action	luBS14.bdf
    action	luBS18.bdf
    action	luBS19.bdf
    action	luBS24.bdf
    action	luIS08.bdf
    action	luIS10.bdf
    action	luIS12.bdf
    action	luIS14.bdf
    action	luIS18.bdf
    action	luIS19.bdf
    action	luIS24.bdf
    action	luRS08.bdf
    action	luRS10.bdf
    action	luRS12.bdf
    action	luRS14.bdf
    action	luRS18.bdf
    action	luRS19.bdf
    action	luRS24.bdf

    action	LU_LEGALNOTICE
}

symlink_font_bh_lucidatypewriter_100dpi() {
    src_dir fonts/bdf/100dpi
    dst_dir font/bh-lucidatypewriter-100dpi

    action	lutBS08.bdf
    action	lutBS10.bdf
    action	lutBS12.bdf
    action	lutBS14.bdf
    action	lutBS18.bdf
    action	lutBS19.bdf
    action	lutBS24.bdf
    action	lutRS08.bdf
    action	lutRS10.bdf
    action	lutRS12.bdf
    action	lutRS14.bdf
    action	lutRS18.bdf
    action	lutRS19.bdf
    action	lutRS24.bdf
}

symlink_font_bitstream_100dpi() {
    src_dir fonts/bdf/100dpi
    dst_dir font/bitstream-100dpi

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
    action	tech14.bdf
    action	techB14.bdf
    action	term14.bdf
    action	termB14.bdf
}

symlink_font_adobe_75dpi() {
    src_dir fonts/bdf/75dpi
    dst_dir font/adobe-75dpi

    action	courB08.bdf
    action	courB10.bdf
    action	courB12.bdf
    action	courB14.bdf
    action	courB18.bdf
    action	courB24.bdf
    action	courBO08.bdf
    action	courBO10.bdf
    action	courBO12.bdf
    action	courBO14.bdf
    action	courBO18.bdf
    action	courBO24.bdf
    action	courO08.bdf
    action	courO10.bdf
    action	courO12.bdf
    action	courO14.bdf
    action	courO18.bdf
    action	courO24.bdf
    action	courR08.bdf
    action	courR10.bdf
    action	courR12.bdf
    action	courR14.bdf
    action	courR18.bdf
    action	courR24.bdf
    action	helvB08.bdf
    action	helvB10.bdf
    action	helvB12.bdf
    action	helvB14.bdf
    action	helvB18.bdf
    action	helvB24.bdf
    action	helvBO08.bdf
    action	helvBO10.bdf
    action	helvBO12.bdf
    action	helvBO14.bdf
    action	helvBO18.bdf
    action	helvBO24.bdf
    action	helvO08.bdf
    action	helvO10.bdf
    action	helvO12.bdf
    action	helvO14.bdf
    action	helvO18.bdf
    action	helvO24.bdf
    action	helvR08.bdf
    action	helvR10.bdf
    action	helvR12.bdf
    action	helvR14.bdf
    action	helvR18.bdf
    action	helvR24.bdf
    action	ncenB08.bdf
    action	ncenB10.bdf
    action	ncenB12.bdf
    action	ncenB14.bdf
    action	ncenB18.bdf
    action	ncenB24.bdf
    action	ncenBI08.bdf
    action	ncenBI10.bdf
    action	ncenBI12.bdf
    action	ncenBI14.bdf
    action	ncenBI18.bdf
    action	ncenBI24.bdf
    action	ncenI08.bdf
    action	ncenI10.bdf
    action	ncenI12.bdf
    action	ncenI14.bdf
    action	ncenI18.bdf
    action	ncenI24.bdf
    action	ncenR08.bdf
    action	ncenR10.bdf
    action	ncenR12.bdf
    action	ncenR14.bdf
    action	ncenR18.bdf
    action	ncenR24.bdf
    action	symb08.bdf
    action	symb10.bdf
    action	symb12.bdf
    action	symb14.bdf
    action	symb18.bdf
    action	symb24.bdf
    action	timB08.bdf
    action	timB10.bdf
    action	timB12.bdf
    action	timB14.bdf
    action	timB18.bdf
    action	timB24.bdf
    action	timBI08.bdf
    action	timBI10.bdf
    action	timBI12.bdf
    action	timBI14.bdf
    action	timBI18.bdf
    action	timBI24.bdf
    action	timI08.bdf
    action	timI10.bdf
    action	timI12.bdf
    action	timI14.bdf
    action	timI18.bdf
    action	timI24.bdf
    action	timR08.bdf
    action	timR10.bdf
    action	timR12.bdf
    action	timR14.bdf
    action	timR18.bdf
    action	timR24.bdf
}

symlink_font_adobe_utopia_75dpi() {
    src_dir fonts/bdf/75dpi
    dst_dir font/adobe-utopia-75dpi

# XXX These fonts are copyright Adobe, but all rights reserved
    action	UTB___10.bdf
    action	UTB___12.bdf
    action	UTB___14.bdf
    action	UTB___18.bdf
    action	UTB___24.bdf
    action	UTBI__10.bdf
    action	UTBI__12.bdf
    action	UTBI__14.bdf
    action	UTBI__18.bdf
    action	UTBI__24.bdf
    action	UTI___10.bdf
    action	UTI___12.bdf
    action	UTI___14.bdf
    action	UTI___18.bdf
    action	UTI___24.bdf
    action	UTRG__10.bdf
    action	UTRG__12.bdf
    action	UTRG__14.bdf
    action	UTRG__18.bdf
    action	UTRG__24.bdf
}

symlink_font_bh_75dpi() {
    src_dir fonts/bdf/75dpi
    dst_dir font/bh-75dpi

    action	lubB08.bdf
    action	lubB10.bdf
    action	lubB12.bdf
    action	lubB14.bdf
    action	lubB18.bdf
    action	lubB19.bdf
    action	lubB24.bdf
    action	lubBI08.bdf
    action	lubBI10.bdf
    action	lubBI12.bdf
    action	lubBI14.bdf
    action	lubBI18.bdf
    action	lubBI19.bdf
    action	lubBI24.bdf
    action	lubI08.bdf
    action	lubI10.bdf
    action	lubI12.bdf
    action	lubI14.bdf
    action	lubI18.bdf
    action	lubI19.bdf
    action	lubI24.bdf
    action	luBIS08.bdf
    action	luBIS10.bdf
    action	luBIS12.bdf
    action	luBIS14.bdf
    action	luBIS18.bdf
    action	luBIS19.bdf
    action	luBIS24.bdf
    action	lubR08.bdf
    action	lubR10.bdf
    action	lubR12.bdf
    action	lubR14.bdf
    action	lubR18.bdf
    action	lubR19.bdf
    action	lubR24.bdf
    action	luBS08.bdf
    action	luBS10.bdf
    action	luBS12.bdf
    action	luBS14.bdf
    action	luBS18.bdf
    action	luBS19.bdf
    action	luBS24.bdf
    action	luIS08.bdf
    action	luIS10.bdf
    action	luIS12.bdf
    action	luIS14.bdf
    action	luIS18.bdf
    action	luIS19.bdf
    action	luIS24.bdf
    action	luRS08.bdf
    action	luRS10.bdf
    action	luRS12.bdf
    action	luRS14.bdf
    action	luRS18.bdf
    action	luRS19.bdf
    action	luRS24.bdf

    action	LU_LEGALNOTICE
}

symlink_font_bh_lucidatypewriter_75dpi() {
    src_dir fonts/bdf/75dpi
    dst_dir font/bh-lucidatypewriter-75dpi

    action	lutBS08.bdf
    action	lutBS10.bdf
    action	lutBS12.bdf
    action	lutBS14.bdf
    action	lutBS18.bdf
    action	lutBS19.bdf
    action	lutBS24.bdf
    action	lutRS08.bdf
    action	lutRS10.bdf
    action	lutRS12.bdf
    action	lutRS14.bdf
    action	lutRS18.bdf
    action	lutRS19.bdf
    action	lutRS24.bdf
}

symlink_font_bitstream_75dpi() {
    src_dir fonts/bdf/75dpi
    dst_dir font/bitstream-75dpi

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
    action	tech14.bdf
    action	techB14.bdf
    action	term14.bdf
    action	termB14.bdf
}

symlink_font_cronyx_cyrillic() {
    src_dir fonts/bdf/cyrillic
    dst_dir font/cronyx-cyrillic

    action	crox1cb.bdf
    action	crox1c.bdf
    action	crox1cbo.bdf
    action	crox1co.bdf
    action	crox1hb.bdf
    action	crox1h.bdf
    action	crox1hbo.bdf
    action	crox1ho.bdf
    action	crox1tb.bdf
    action	crox1t.bdf
    action	crox1tbo.bdf
    action	crox1to.bdf
    action	crox2cb.bdf
    action	crox2c.bdf
    action	crox2cbo.bdf
    action	crox2co.bdf
    action	crox2hb.bdf
    action	crox2h.bdf
    action	crox2hbo.bdf
    action	crox2ho.bdf
    action	crox2tb.bdf
    action	crox2t.bdf
    action	crox2tbo.bdf
    action	crox2to.bdf
    action	crox3cb.bdf
    action	crox3c.bdf
    action	crox3cbo.bdf
    action	crox3co.bdf
    action	crox3hb.bdf
    action	crox3h.bdf
    action	crox3hbo.bdf
    action	crox3ho.bdf
    action	crox3tb.bdf
    action	crox3t.bdf
    action	crox3tbo.bdf
    action	crox3to.bdf
    action	crox4hb.bdf
    action	crox4h.bdf
    action	crox4hbo.bdf
    action	crox4ho.bdf
    action	crox4tb.bdf
    action	crox4t.bdf
    action	crox4tbo.bdf
    action	crox4to.bdf
    action	crox5hb.bdf
    action	crox5h.bdf
    action	crox5hbo.bdf
    action	crox5ho.bdf
    action	crox5tb.bdf
    action	crox5t.bdf
    action	crox5tbo.bdf
    action	crox5to.bdf
    action	crox6hb.bdf
    action	crox6h.bdf
    action	crox6hbo.bdf
    action	crox6ho.bdf
    action	crox6tb.bdf
    action	crox6t.bdf
    action	crox6tbo.bdf
    action	crox6to.bdf
    action	koi10x16b.bdf
    action	koi10x20.bdf
    action	koi6x10.bdf
    action	koinil2.bdf

    action	COPYRIGHT
}

symlink_font_misc_cyrillic() {
    src_dir fonts/bdf/cyrillic
    dst_dir font/misc-cyrillic

# XXX Should these be broken into three different components?

# XXX "May be distributed and modified without restrictions"
    action	koi12x24b.bdf
    action	koi8x16b.bdf
    action	koi8x16.bdf

# XXX Same license as cronyx-cyrillic 
    action	koi12x24.bdf
    action	koi6x13.bdf

# XXX public domain
    action	koi5x8.bdf
    action	koi6x13b.bdf
    action	koi6x9.bdf
    action	koi7x14b.bdf
    action	koi7x14.bdf
    action	koi8x13.bdf
    action	koi9x15b.bdf
    action	koi9x15.bdf
    action	koi9x18b.bdf
    action	koi9x18.bdf
}

symlink_font_screen_cyrillic() {
    src_dir fonts/bdf/cyrillic
    dst_dir font/screen-cyrillic

# XXX no copyright/license at all
    action	screen8x16b.bdf
    action	screen8x16.bdf
}

symlink_font_winitzki_cyrillic() {
    src_dir fonts/bdf/cyrillic
    dst_dir font/winitzki-cyrillic

    action	proof9x16.bdf
}

symlink_font_cursor_misc() {
    src_dir fonts/bdf/misc
    dst_dir font/cursor-misc

# XXX Does "unencumbered" mean the same thing as public domain
#     in this context?
    action	cursor.bdf
}

symlink_font_daewoo_misc() {
    src_dir fonts/bdf/misc
    dst_dir font/daewoo-misc

# XXX These fonts are copyright, but no permissions are given
    action	hanglg16.bdf
    action	hanglm16.bdf
    action	hanglm24.bdf
}

symlink_font_dec_misc() {
    src_dir fonts/bdf/misc
    dst_dir font/dec-misc

    action	deccurs.bdf
    action	decsess.bdf
}

symlink_font_isas_misc() {
    src_dir fonts/bdf/misc
    dst_dir font/isas-misc

    action	gb16fs.bdf
    action	gb16st.bdf
    action	gb24st.bdf
}

symlink_font_jis_misc() {
    src_dir fonts/bdf/misc
    dst_dir font/jis-misc

# XXX Verify license restrictions
    action	jiskan16.bdf
    action	jiskan24.bdf
}

symlink_font_micro_misc() {
    src_dir fonts/bdf/misc
    dst_dir font/micro-misc

    action	micro.bdf
}

symlink_font_misc_misc() {
    src_dir fonts/bdf/misc
    dst_dir font/misc-misc

    action	10x20.bdf
    action	12x13ja.bdf
    action	18x18ja.bdf
    action	18x18ko.bdf
    action	4x6.bdf
    action	5x7.bdf
    action	5x8.bdf
    action	6x10.bdf
    action	6x12.bdf
    action	6x13B.bdf
    action	6x13.bdf
    action	6x13O.bdf
    action	6x9.bdf
    action	7x13B.bdf
    action	7x13.bdf
    action	7x13O.bdf
    action	7x14B.bdf
    action	7x14.bdf
    action	8x13B.bdf
    action	8x13.bdf
    action	8x13O.bdf
    action	9x15B.bdf
    action	9x15.bdf
    action	9x18B.bdf
    action	9x18.bdf
    action	k14.bdf

# XXX This font does not have any COPYRIGHT
    action	nil2.bdf
}

symlink_font_schumacher_misc() {
    src_dir fonts/bdf/misc
    dst_dir font/schumacher-misc

    action	clB6x10.bdf
    action	clB6x12.bdf
    action	clB8x10.bdf
    action	clB8x12.bdf
    action	clB8x13.bdf
    action	clB8x14.bdf
    action	clB8x16.bdf
    action	clB8x8.bdf
    action	clB9x15.bdf
    action	clI6x12.bdf
    action	clI8x8.bdf
    action	clR4x6.bdf
    action	clR5x10.bdf
    action	clR5x6.bdf
    action	clR5x8.bdf
    action	clR6x10.bdf
    action	clR6x12.bdf
    action	clR6x13.bdf
    action	clR6x6.bdf
    action	clR6x8.bdf
    action	clR7x10.bdf
    action	clR7x12.bdf
    action	clR7x14.bdf
    action	clR7x8.bdf
    action	clR8x10.bdf
    action	clR8x12.bdf
    action	clR8x13.bdf
    action	clR8x14.bdf
    action	clR8x16.bdf
    action	clR8x8.bdf
    action	clR9x15.bdf
}

symlink_font_sony_misc() {
    src_dir fonts/bdf/misc
    dst_dir font/sony-misc

    action	12x24.bdf
    action	12x24rk.bdf
    action	8x16.bdf
    action	8x16rk.bdf
}

symlink_font_sun_misc() {
    src_dir fonts/bdf/misc
    dst_dir font/sun-misc

    action	olcursor.bdf
    action	olgl10.bdf
    action	olgl12.bdf
    action	olgl14.bdf
    action	olgl19.bdf
}

symlink_font_bh_ttf() {
    src_dir fonts/scaled/TTF
    dst_dir font/bh-ttf

    action	luximbi.ttf
    action	luximb.ttf
    action	luximri.ttf
    action	luximr.ttf
    action	luxirbi.ttf
    action	luxirb.ttf
    action	luxirri.ttf
    action	luxirr.ttf
    action	luxisbi.ttf
    action	luxisb.ttf
    action	luxisri.ttf
    action	luxisr.ttf

    action	COPYRIGHT.BH
}

symlink_font_adobe_utopia_type1() {
    src_dir fonts/scaled/Type1
    dst_dir font/adobe-utopia-type1

# XXX These fonts are copyright Adobe, but all rights reserved
    action	UTB_____.afm
    action	UTBI____.afm
    action	UTBI____.pfa
    action	UTB_____.pfa
    action	UTI_____.afm
    action	UTI_____.pfa
    action	UTRG____.afm
    action	UTRG____.pfa
}

symlink_font_bh_type1() {
    src_dir fonts/scaled/Type1
    dst_dir font/bh-type1

    action	l047013t.afm
    action	l047013t.pfa
    action	l047016t.afm
    action	l047016t.pfa
    action	l047033t.afm
    action	l047033t.pfa
    action	l047036t.afm
    action	l047036t.pfa
    action	l048013t.afm
    action	l048013t.pfa
    action	l048016t.afm
    action	l048016t.pfa
    action	l048033t.afm
    action	l048033t.pfa
    action	l048036t.afm
    action	l048036t.pfa
    action	l049013t.afm
    action	l049013t.pfa
    action	l049016t.afm
    action	l049016t.pfa
    action	l049033t.afm
    action	l049033t.pfa
    action	l049036t.afm
    action	l049036t.pfa

    action	COPYRIGHT.BH
}

symlink_font_bitstream_type1() {
    src_dir fonts/scaled/Type1
    dst_dir font/bitstream-type1

    action	c0419bt_.afm
    action	c0419bt_.pfb
    action	c0582bt_.afm
    action	c0582bt_.pfb
    action	c0583bt_.afm
    action	c0583bt_.pfb
    action	c0611bt_.afm
    action	c0611bt_.pfb
    action	c0632bt_.afm
    action	c0632bt_.pfb
    action	c0633bt_.afm
    action	c0633bt_.pfb
    action	c0648bt_.afm
    action	c0648bt_.pfb
    action	c0649bt_.afm
    action	c0649bt_.pfb

    action	Copyright
}

symlink_font_ibm_type1() {
    src_dir fonts/scaled/Type1
    dst_dir font/ibm-type1

    action	cour.afm
    action	courb.afm
    action	courbi.afm
    action	courbi.pfa
    action	courb.pfa
    action	couri.afm
    action	couri.pfa
    action	cour.pfa

    action	COPYRIGHT.IBM
}

symlink_font_xfree86_type1() {
    src_dir fonts/scaled/Type1
    dst_dir font/xfree86-type1

    action	cursor.pfa
}

symlink_font_arabic_misc() {
    src_dir extras/fonts/arabic24
    dst_dir font/arabic-misc

    action	arabic24.bdf

    action	README
    action	uniarab.txt
}

symlink_font_mutt_misc() {
    src_dir extras/fonts/ClearlyU
    dst_dir font/mutt-misc

    action	cu12.bdf
    action	cu-alt12.bdf
    action	cu-arabic12.bdf
    action	cuarabic12.bdf
    action	cu-devnag12.bdf
    action	cudevnag12.bdf
    action	cu-lig12.bdf
    action	cu-pua12.bdf

    action	README
}


symlink_font_misc_ethiopic() {
    src_dir fonts/scaled/Ethiopic
    dst_dir font/misc-ethiopic

    action	GohaTibebZemen.otf
    action	GohaTibebZemen.ttf

    action	license.txt
}

symlink_font_misc_meltho() {
    src_dir fonts/scaled/Meltho
    dst_dir font/misc-meltho

    action	SyrCOMAdiabene.otf
    action	SyrCOMAntioch.otf
    action	SyrCOMBatnanBold.otf
    action	SyrCOMBatnan.otf
    action	SyrCOMCtesiphon.otf
    action	SyrCOMEdessa.otf
    action	SyrCOMJerusalemBold.otf
    action	SyrCOMJerusalemItalic.otf
    action	SyrCOMJerusalem.otf
    action	SyrCOMJerusalemOutline.otf
    action	SyrCOMKharput.otf
    action	SyrCOMMalankara.otf
    action	SyrCOMMardinBold.otf
    action	SyrCOMMardin.otf
    action	SyrCOMMidyat.otf
    action	SyrCOMNisibin.otf
    action	SyrCOMNisibinOutline.otf
    action	SyrCOMQenNeshrin.otf
    action	SyrCOMTalada.otf
    action	SyrCOMTurAbdin.otf
    action	SyrCOMUrhoyBold.otf
    action	SyrCOMUrhoy.otf

    action	license.txt
    action	README
}

symlink_font_bistream_speedo() {
    src_dir fonts/scaled/Speedo
    dst_dir font/bitstream-speedo

    action	font0419.spd
    action	font0582.spd
    action	font0583.spd
    action	font0611.spd
    action	font0648.spd
    action	font0649.spd
    action	font0709.spd
    action	font0710.spd

    action	fonts.scale
    action	COPYRIGHT
}


symlink_font_alias() {
    src_dir fonts/bdf/100dpi
    dst_dir font/alias/100dpi

    action	fonts.alias

    src_dir fonts/bdf/75dpi
    dst_dir font/alias/75dpi

    action	fonts.alias

    src_dir fonts/bdf/cyrillic
    dst_dir font/alias/cyrillic

    action	fonts.alias

    src_dir fonts/bdf/misc
    dst_dir font/alias/misc

    action	fonts.alias
}

symlink_font_util() {
    src_dir fonts/util
    dst_dir font/util

    action	8859-1.TXT	map-ISO8859-1
    action	8859-2.TXT	map-ISO8859-2
    action	8859-3.TXT	map-ISO8859-3
    action	8859-4.TXT	map-ISO8859-4
    action	8859-5.TXT	map-ISO8859-5
    action	8859-6.TXT	map-ISO8859-6
    action	8859-7.TXT	map-ISO8859-7
    action	8859-8.TXT	map-ISO8859-8
    action	8859-9.TXT	map-ISO8859-9
    action	8859-10.TXT	map-ISO8859-10
    action	8859-11.TXT	map-ISO8859-11
    action	8859-13.TXT	map-ISO8859-13
    action	8859-14.TXT	map-ISO8859-14
    action	8859-15.TXT	map-ISO8859-15
    action	8859-16.TXT	map-ISO8859-16
    action	JIS0201.TXT	map-JISX0201.1976-0
    action	KOI8-R.TXT	map-KOI8-R

    action	bdftruncate.man
    action	bdftruncate.pl

    action	ucs2any.c
    action	ucs2any.man
}

symlink_font_encodings() {
    src_dir fonts/encodings
    dst_dir font/encodings

    action	adobe-dingbats.enc
    action	adobe-standard.enc
    action	adobe-symbol.enc
    action	ansi-1251.enc
    action	armscii-8.enc
    action	ascii-0.enc
    action	dec-special.enc
    action	ibm-cp437.enc
    action	ibm-cp850.enc
    action	ibm-cp852.enc
    action	ibm-cp866.enc
    action	iso8859-11.enc
    action	iso8859-13.enc
    action	iso8859-16.enc
    action	iso8859-6.16.enc
    action	iso8859-6.8x.enc
    action	microsoft-cp1250.enc
    action	microsoft-cp1251.enc
    action	microsoft-cp1252.enc
    action	microsoft-cp1253.enc
    action	microsoft-cp1254.enc
    action	microsoft-cp1255.enc
    action	microsoft-cp1256.enc
    action	microsoft-cp1257.enc
    action	microsoft-cp1258.enc
    action	microsoft-win3.1.enc
    action	mulearabic-0.enc
    action	mulearabic-1.enc
    action	mulearabic-2.enc
    action	mulelao-1.enc
    action	suneu-greek.enc
    action	tcvn-0.enc
    action	tis620-2.enc
    action	viscii1.1-1.enc

    src_dir fonts/encodings/large
    dst_dir font/encodings/large

    action	big5.eten-0.enc
    action	big5hkscs-0.enc
    action	cns11643-1.enc
    action	cns11643-2.enc
    action	cns11643-3.enc
    action	gb18030-0.enc
    action	gb18030.2000-0.enc
    action	gb18030.2000-1.enc
    action	gb2312.1980-0.enc
    action	gbk-0.enc
    action	jisx0201.1976-0.enc
    action	jisx0208.1990-0.enc
    action	jisx0212.1990-0.enc
    action	ksc5601.1987-0.enc
    action	ksc5601.1992-3.enc
    action	sun.unicode.india-0.enc
}

symlink_font() {
    symlink_font_adobe_100dpi
    symlink_font_adobe_utopia_100dpi
    symlink_font_bh_100dpi
    symlink_font_bh_lucidatypewriter_100dpi
    symlink_font_bitstream_100dpi

    symlink_font_adobe_75dpi
    symlink_font_adobe_utopia_75dpi
    symlink_font_bh_75dpi
    symlink_font_bh_lucidatypewriter_75dpi
    symlink_font_bitstream_75dpi

    symlink_font_cronyx_cyrillic
    symlink_font_misc_cyrillic
    symlink_font_screen_cyrillic
    symlink_font_winitzki_cyrillic

    symlink_font_cursor_misc
    symlink_font_daewoo_misc
    symlink_font_dec_misc
    symlink_font_isas_misc
    symlink_font_jis_misc
    symlink_font_micro_misc
    symlink_font_misc_misc
    symlink_font_schumacher_misc
    symlink_font_sony_misc
    symlink_font_sun_misc

    symlink_font_bh_ttf

    symlink_font_adobe_utopia_type1
    symlink_font_bh_type1
    symlink_font_bitstream_type1
    symlink_font_ibm_type1
    symlink_font_xfree86_type1

    symlink_font_mutt_misc
    symlink_font_arabic_misc

    symlink_font_misc_meltho
    symlink_font_misc_ethiopic

    symlink_font_bistream_speedo

    symlink_font_alias
    symlink_font_util

    symlink_font_encodings
}


#########
#
#	The doc module
#
#########

symlink_doc_old() {
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
    action	Xprint.sgml
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

    src_dir
    dst_dir doc/old
    action	registry
}

symlink_doc() {
    symlink_doc_old
#    symlink_doc_man
#    ...
}


#########
#
#	The util module
#
#########

symlink_util_xmkmf() {
    src_dir config/util
    dst_dir util/xmkmf

    action	xmkmf.cpp
    action	xmkmf.man
}

symlink_util_cf() {
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

symlink_util_imake() {
    src_dir config/imake
    dst_dir util/imake

    action	imake.c
    action	imake.man
    action	imakemdep.h
}

symlink_util_makedepend() {
    src_dir config/makedepend
    dst_dir util/makedepend

    action	cppsetup.c
    action	def.h
    action	ifparser.c
    action	ifparser.h
    action	include.c
    action	main.c
    action	mkdepend.man	makedepend.man
    action	parse.c
    action	pr.c

    src_dir config/imake
    dst_dir util/makedepend

    action	imakemdep.h
}

symlink_util() {
    symlink_util_cf
    symlink_util_imake
    symlink_util_makedepend
    symlink_util_xmkmf
#    ...
}

symlink_data_cursors_handhelds() {
    src_dir programs/xcursorgen/handhelds
    dst_dir data/cursors/handhelds

    action	X_cursor.cfg
    action	based_arrow_down.cfg
    action	based_arrow_up.cfg
    action	bottom_left_corner.cfg
    action	bottom_right_corner.cfg
    action	bottom_side.cfg
    action	bottom_tee.cfg
    action	center_ptr.cfg
    action	circle.cfg
    action	cross.cfg
    action	dot.cfg
    action	dotbox.cfg
    action	double_arrow.cfg
    action	draped_box.cfg
    action	fleur.cfg
    action	gumby.cfg
    action	hand2.cfg
    action	left_ptr.cfg
    action	left_ptr_watch.cfg
    action	left_side.cfg
    action	left_tee.cfg
    action	ll_angle.cfg
    action	pencil.cfg
    action	right_ptr.cfg
    action	right_side.cfg
    action	right_tee.cfg
    action	sb_h_double_arrow.cfg
    action	sb_right_arrow.cfg
    action	sb_up_arrow.cfg
    action	sb_v_double_arrow.cfg
    action	shuttle.cfg
    action	top_left_corner.cfg
    action	top_right_corner.cfg
    action	top_side.cfg
    action	top_tee.cfg
    action	watch.cfg
    action	xterm.cfg
}

symlink_data_cursors_redglass() {
    src_dir programs/xcursorgen/redglass
    dst_dir data/cursors/redglass

    action	X_cursor-16.png
    action	X_cursor-24.png
    action	X_cursor-32.png
    action	X_cursor-48.png
    action	X_cursor-64.png
    action	based_arrow_down-16.png
    action	based_arrow_down-24.png
    action	based_arrow_down-32.png
    action	based_arrow_down-48.png
    action	based_arrow_down-64.png
    action	based_arrow_up-16.png
    action	based_arrow_up-24.png
    action	based_arrow_up-32.png
    action	based_arrow_up-48.png
    action	based_arrow_up-64.png
    action	bottom_left_corner-16.png
    action	bottom_left_corner-24.png
    action	bottom_left_corner-32.png
    action	bottom_left_corner-48.png
    action	bottom_left_corner-64.png
    action	bottom_right_corner-16.png
    action	bottom_right_corner-24.png
    action	bottom_right_corner-32.png
    action	bottom_right_corner-48.png
    action	bottom_right_corner-64.png
    action	bottom_side-16.png
    action	bottom_side-24.png
    action	bottom_side-32.png
    action	bottom_side-48.png
    action	bottom_side-64.png
    action	bottom_tee-16.png
    action	bottom_tee-24.png
    action	bottom_tee-32.png
    action	bottom_tee-48.png
    action	bottom_tee-64.png
    action	center_ptr-16.png
    action	center_ptr-24.png
    action	center_ptr-32.png
    action	center_ptr-48.png
    action	center_ptr-64.png
    action	circle-16.png
    action	circle-24.png
    action	circle-32.png
    action	circle-48.png
    action	circle-64.png
    action	cross-16.png
    action	cross-24.png
    action	cross-32.png
    action	cross-48.png
    action	cross-64.png
    action	dot-16.png
    action	dot-24.png
    action	dot-32.png
    action	dot-48.png
    action	dot-64.png
    action	dotbox-16.png
    action	dotbox-24.png
    action	dotbox-32.png
    action	dotbox-48.png
    action	dotbox-64.png
    action	double_arrow-16.png
    action	double_arrow-24.png
    action	double_arrow-32.png
    action	double_arrow-48.png
    action	double_arrow-64.png
    action	draped_box-16.png
    action	draped_box-24.png
    action	draped_box-32.png
    action	draped_box-48.png
    action	draped_box-64.png
    action	fleur-16.png
    action	fleur-24.png
    action	fleur-32.png
    action	fleur-48.png
    action	fleur-64.png
    action	gumby-128.png
    action	gumby-16.png
    action	gumby-24.png
    action	gumby-32.png
    action	gumby-48.png
    action	gumby-64.png
    action	hand2-16.png
    action	hand2-24.png
    action	hand2-32.png
    action	hand2-48.png
    action	hand2-64.png
    action	hourglass-135-16.png
    action	hourglass-135-24.png
    action	hourglass-135-32.png
    action	hourglass-135-48.png
    action	hourglass-135-64.png
    action	hourglass-25-16.png
    action	hourglass-25-24.png
    action	hourglass-25-32.png
    action	hourglass-25-48.png
    action	hourglass-25-64.png
    action	hourglass-45-16.png
    action	hourglass-45-24.png
    action	hourglass-45-32.png
    action	hourglass-45-48.png
    action	hourglass-45-64.png
    action	hourglass-50-16.png
    action	hourglass-50-24.png
    action	hourglass-50-32.png
    action	hourglass-50-48.png
    action	hourglass-50-64.png
    action	hourglass-75-16.png
    action	hourglass-75-24.png
    action	hourglass-75-32.png
    action	hourglass-75-48.png
    action	hourglass-75-64.png
    action	hourglass-90-16.png
    action	hourglass-90-24.png
    action	hourglass-90-32.png
    action	hourglass-90-48.png
    action	hourglass-90-64.png
    action	hourglass-empty-16.png
    action	hourglass-empty-24.png
    action	hourglass-empty-32.png
    action	hourglass-empty-48.png
    action	hourglass-empty-64.png
    action	hourglass-full-16.png
    action	hourglass-full-24.png
    action	hourglass-full-32.png
    action	hourglass-full-48.png
    action	hourglass-full-64.png
    action	left_ptr-16.png
    action	left_ptr-24.png
    action	left_ptr-32.png
    action	left_ptr-48.png
    action	left_ptr-64.png
    action	left_ptr_watch-16.png
    action	left_ptr_watch-24.png
    action	left_ptr_watch-32.png
    action	left_ptr_watch-48.png
    action	left_ptr_watch-64.png
    action	left_side-16.png
    action	left_side-24.png
    action	left_side-32.png
    action	left_side-48.png
    action	left_side-64.png
    action	left_tee-16.png
    action	left_tee-24.png
    action	left_tee-32.png
    action	left_tee-48.png
    action	left_tee-64.png
    action	ll_angle-16.png
    action	ll_angle-24.png
    action	ll_angle-32.png
    action	ll_angle-48.png
    action	ll_angle-64.png
    action	pencil-16.png
    action	pencil-24.png
    action	pencil-32.png
    action	pencil-48.png
    action	pencil-64.png
    action	right_ptr-16.png
    action	right_ptr-24.png
    action	right_ptr-32.png
    action	right_ptr-48.png
    action	right_ptr-64.png
    action	right_side-16.png
    action	right_side-24.png
    action	right_side-32.png
    action	right_side-48.png
    action	right_side-64.png
    action	right_tee-16.png
    action	right_tee-24.png
    action	right_tee-32.png
    action	right_tee-48.png
    action	right_tee-64.png
    action	sb_h_double_arrow-16.png
    action	sb_h_double_arrow-24.png
    action	sb_h_double_arrow-32.png
    action	sb_h_double_arrow-48.png
    action	sb_h_double_arrow-64.png
    action	sb_right_arrow-16.png
    action	sb_right_arrow-24.png
    action	sb_right_arrow-32.png
    action	sb_right_arrow-48.png
    action	sb_right_arrow-64.png
    action	sb_up_arrow-16.png
    action	sb_up_arrow-24.png
    action	sb_up_arrow-32.png
    action	sb_up_arrow-48.png
    action	sb_up_arrow-64.png
    action	sb_v_double_arrow-16.png
    action	sb_v_double_arrow-24.png
    action	sb_v_double_arrow-32.png
    action	sb_v_double_arrow-48.png
    action	sb_v_double_arrow-64.png
    action	shuttle-16.png
    action	shuttle-24.png
    action	shuttle-32.png
    action	shuttle-48.png
    action	shuttle-64.png
    action	top_left_corner-16.png
    action	top_left_corner-24.png
    action	top_left_corner-32.png
    action	top_left_corner-48.png
    action	top_left_corner-64.png
    action	top_right_corner-16.png
    action	top_right_corner-24.png
    action	top_right_corner-32.png
    action	top_right_corner-48.png
    action	top_right_corner-64.png
    action	top_side-16.png
    action	top_side-24.png
    action	top_side-32.png
    action	top_side-48.png
    action	top_side-64.png
    action	top_tee-16.png
    action	top_tee-24.png
    action	top_tee-32.png
    action	top_tee-48.png
    action	top_tee-64.png
    action	watch-16.png
    action	watch-24.png
    action	watch-32.png
    action	watch-48.png
    action	watch-64.png
    action	xterm-16.png
    action	xterm-24.png
    action	xterm-32.png
    action	xterm-48.png
    action	xterm-64.png

    action	X_cursor.cfg
    action	based_arrow_down.cfg
    action	based_arrow_up.cfg
    action	bottom_left_corner.cfg
    action	bottom_right_corner.cfg
    action	bottom_side.cfg
    action	bottom_tee.cfg
    action	center_ptr.cfg
    action	circle.cfg
    action	cross.cfg
    action	dot.cfg
    action	dotbox.cfg
    action	double_arrow.cfg
    action	draped_box.cfg
    action	fleur.cfg
    action	gumby.cfg
    action	hand2.cfg
    action	left_ptr.cfg
    action	left_ptr_watch.cfg
    action	left_side.cfg
    action	left_tee.cfg
    action	ll_angle.cfg
    action	pencil.cfg
    action	right_ptr.cfg
    action	right_side.cfg
    action	right_tee.cfg
    action	sb_h_double_arrow.cfg
    action	sb_right_arrow.cfg
    action	sb_up_arrow.cfg
    action	sb_v_double_arrow.cfg
    action	shuttle.cfg
    action	top_left_corner.cfg
    action	top_right_corner.cfg
    action	top_side.cfg
    action	top_tee.cfg
    action	watch.cfg
    action	xterm.cfg

    action	based_arrow_down.xcf
    action	based_arrow_up.xcf
    action	basic_arrow.xcf
    action	bottom_left_corner.xcf
    action	bottom_right_corner.xcf
    action	bottom_side.xcf
    action	bottom_tee.xcf
    action	center_ptr.xcf
    action	circle.xcf
    action	cross.xcf
    action	dotbox.xcf
    action	dot.xcf
    action	double_arrow.xcf
    action	draped_box.xcf
    action	fleur.xcf
    action	gumby.xcf
    action	hand2.xcf
    action	hourglass-135.xcf
    action	hourglass-25.xcf
    action	hourglass-45.xcf
    action	hourglass-50.xcf
    action	hourglass-75.xcf
    action	hourglass-90.xcf
    action	hourglass-empty.xcf
    action	hourglass-full.xcf
    action	hourglass-plain.xcf
    action	left_ptr_watch.xcf
    action	left_ptr.xcf
    action	left_side.xcf
    action	left_tee.xcf
    action	ll_angle.xcf
    action	pencil.xcf
    action	right_ptr.xcf
    action	right_side.xcf
    action	right_tee.xcf
    action	sb_h_double_arrow.xcf
    action	sb_right_arrow.xcf
    action	sb_up_arrow.xcf
    action	sb_v_double_arrow.xcf
    action	shuttle.xcf
    action	top_left_corner.xcf
    action	top_right_corner.xcf
    action	top_side.xcf
    action	top_tee.xcf
    action	watch.xcf
    action	X_cursor.xcf
    action	xterm.xcf

    action	gumby.svg
}

symlink_data_cursors_whiteglass() {
    src_dir programs/xcursorgen/whiteglass
    dst_dir data/cursors/whiteglass

    action	X_cursor-16.png
    action	X_cursor-24.png
    action	X_cursor-32.png
    action	X_cursor-48.png
    action	X_cursor-64.png
    action	base_arrow_down-16.png
    action	base_arrow_down-24.png
    action	base_arrow_down-32.png
    action	base_arrow_down-48.png
    action	base_arrow_down-64.png
    action	base_arrow_up-16.png
    action	base_arrow_up-24.png
    action	base_arrow_up-32.png
    action	base_arrow_up-48.png
    action	base_arrow_up-64.png
    action	basic_arrow-16.png
    action	basic_arrow-24.png
    action	basic_arrow-32.png
    action	basic_arrow-48.png
    action	basic_arrow-64.png
    action	boat-16.png
    action	boat-24.png
    action	boat-32.png
    action	boat-48.png
    action	boat-64.png
    action	bottom_left_corner-16.png
    action	bottom_left_corner-24.png
    action	bottom_left_corner-32.png
    action	bottom_left_corner-48.png
    action	bottom_left_corner-64.png
    action	bottom_right_corner-16.png
    action	bottom_right_corner-24.png
    action	bottom_right_corner-32.png
    action	bottom_right_corner-48.png
    action	bottom_right_corner-64.png
    action	bottom_side-16.png
    action	bottom_side-24.png
    action	bottom_side-32.png
    action	bottom_side-48.png
    action	bottom_side-64.png
    action	bottom_tee-16.png
    action	bottom_tee-24.png
    action	bottom_tee-32.png
    action	bottom_tee-48.png
    action	bottom_tee-64.png
    action	center_ptr-16.png
    action	center_ptr-24.png
    action	center_ptr-32.png
    action	center_ptr-48.png
    action	center_ptr-64.png
    action	circle-16.png
    action	circle-24.png
    action	circle-32.png
    action	circle-48.png
    action	circle-64.png
    action	cross-16.png
    action	cross-24.png
    action	cross-32.png
    action	cross-48.png
    action	cross-64.png
    action	dot-16.png
    action	dot-24.png
    action	dot-32.png
    action	dot-48.png
    action	dot-64.png
    action	dot_box_mask-16.png
    action	dot_box_mask-24.png
    action	dot_box_mask-32.png
    action	dot_box_mask-48.png
    action	dot_box_mask-64.png
    action	double_arrow-16.png
    action	double_arrow-24.png
    action	double_arrow-32.png
    action	double_arrow-48.png
    action	double_arrow-64.png
    action	draped_box-16.png
    action	draped_box-24.png
    action	draped_box-32.png
    action	draped_box-48.png
    action	draped_box-64.png
    action	exchange-16.png
    action	exchange-24.png
    action	exchange-32.png
    action	exchange-48.png
    action	exchange-64.png
    action	fleur-16.png
    action	fleur-24.png
    action	fleur-32.png
    action	fleur-48.png
    action	fleur-64.png
    action	gumby-128.png
    action	gumby-16.png
    action	gumby-24.png
    action	gumby-32.png
    action	gumby-48.png
    action	gumby-64.png
    action	hand1-16.png
    action	hand1-24.png
    action	hand1-32.png
    action	hand1-48.png
    action	hand1-64.png
    action	hand2-16.png
    action	hand2-24.png
    action	hand2-32.png
    action	hand2-48.png
    action	hand2-64.png
    action	left_ptr-16.png
    action	left_ptr-24.png
    action	left_ptr-32.png
    action	left_ptr-48.png
    action	left_ptr-64.png
    action	left_ptr_watch-16.png
    action	left_ptr_watch-24.png
    action	left_ptr_watch-32.png
    action	left_ptr_watch-48.png
    action	left_ptr_watch-64.png
    action	left_side-16.png
    action	left_side-24.png
    action	left_side-32.png
    action	left_side-48.png
    action	left_side-64.png
    action	left_tee-16.png
    action	left_tee-24.png
    action	left_tee-32.png
    action	left_tee-48.png
    action	left_tee-64.png
    action	ll_angle-16.png
    action	ll_angle-24.png
    action	ll_angle-32.png
    action	ll_angle-48.png
    action	ll_angle-64.png
    action	lr_angle-16.png
    action	lr_angle-24.png
    action	lr_angle-32.png
    action	lr_angle-48.png
    action	lr_angle-64.png
    action	pencil-16.png
    action	pencil-24.png
    action	pencil-32.png
    action	pencil-48.png
    action	pencil-64.png
    action	pirate-16.png
    action	pirate-24.png
    action	pirate-32.png
    action	pirate-48.png
    action	pirate-64.png
    action	question_arrow-16.png
    action	question_arrow-24.png
    action	question_arrow-32.png
    action	question_arrow-48.png
    action	question_arrow-64.png
    action	right_ptr-16.png
    action	right_ptr-24.png
    action	right_ptr-32.png
    action	right_ptr-48.png
    action	right_ptr-64.png
    action	right_side-16.png
    action	right_side-24.png
    action	right_side-32.png
    action	right_side-48.png
    action	right_side-64.png
    action	right_tee-16.png
    action	right_tee-24.png
    action	right_tee-32.png
    action	right_tee-48.png
    action	right_tee-64.png
    action	sailboat-16.png
    action	sailboat-24.png
    action	sailboat-32.png
    action	sailboat-48.png
    action	sailboat-64.png
    action	sb_down_arrow-16.png
    action	sb_down_arrow-24.png
    action	sb_down_arrow-32.png
    action	sb_down_arrow-48.png
    action	sb_down_arrow-64.png
    action	sb_h_double_arrow-16.png
    action	sb_h_double_arrow-24.png
    action	sb_h_double_arrow-32.png
    action	sb_h_double_arrow-48.png
    action	sb_h_double_arrow-64.png
    action	sb_left_arrow-16.png
    action	sb_left_arrow-24.png
    action	sb_left_arrow-32.png
    action	sb_left_arrow-48.png
    action	sb_left_arrow-64.png
    action	sb_right_arrow-16.png
    action	sb_right_arrow-24.png
    action	sb_right_arrow-32.png
    action	sb_right_arrow-48.png
    action	sb_right_arrow-64.png
    action	sb_up_arrow-16.png
    action	sb_up_arrow-24.png
    action	sb_up_arrow-32.png
    action	sb_up_arrow-48.png
    action	sb_up_arrow-64.png
    action	sb_v_double_arrow-16.png
    action	sb_v_double_arrow-24.png
    action	sb_v_double_arrow-32.png
    action	sb_v_double_arrow-48.png
    action	sb_v_double_arrow-64.png
    action	shuttle-16.png
    action	shuttle-24.png
    action	shuttle-32.png
    action	shuttle-48.png
    action	shuttle-64.png
    action	sizing-16.png
    action	sizing-24.png
    action	sizing-32.png
    action	sizing-48.png
    action	sizing-64.png
    action	target-16.png
    action	target-24.png
    action	target-32.png
    action	target-48.png
    action	target-64.png
    action	top_left_corner-16.png
    action	top_left_corner-24.png
    action	top_left_corner-32.png
    action	top_left_corner-48.png
    action	top_left_corner-64.png
    action	top_right_corner-16.png
    action	top_right_corner-24.png
    action	top_right_corner-32.png
    action	top_right_corner-48.png
    action	top_right_corner-64.png
    action	top_side-16.png
    action	top_side-24.png
    action	top_side-32.png
    action	top_side-48.png
    action	top_side-64.png
    action	top_tee-16.png
    action	top_tee-24.png
    action	top_tee-32.png
    action	top_tee-48.png
    action	top_tee-64.png
    action	trek-16.png
    action	trek-24.png
    action	trek-32.png
    action	trek-48.png
    action	trek-64.png
    action	ul_angle-16.png
    action	ul_angle-24.png
    action	ul_angle-32.png
    action	ul_angle-48.png
    action	ul_angle-64.png
    action	ur_angle-16.png
    action	ur_angle-24.png
    action	ur_angle-32.png
    action	ur_angle-48.png
    action	ur_angle-64.png
    action	watch-16.png
    action	watch-24.png
    action	watch-32.png
    action	watch-48.png
    action	watch-64.png
    action	xterm-16.png
    action	xterm-24.png
    action	xterm-32.png
    action	xterm-48.png
    action	xterm-64.png

    action	X_cursor.cfg
    action	base_arrow_down.cfg
    action	base_arrow_up.cfg
    action	basic_arrow.cfg
    action	boat.cfg
    action	bottom_left_corner.cfg
    action	bottom_right_corner.cfg
    action	bottom_side.cfg
    action	bottom_tee.cfg
    action	center_ptr.cfg
    action	circle.cfg
    action	cross.cfg
    action	dot.cfg
    action	dot_box_mask.cfg
    action	double_arrow.cfg
    action	draped_box.cfg
    action	exchange.cfg
    action	fleur.cfg
    action	gumby.cfg
    action	hand1.cfg
    action	hand2.cfg
    action	left_ptr.cfg
    action	left_ptr_watch.cfg
    action	left_side.cfg
    action	left_tee.cfg
    action	ll_angle.cfg
    action	lr_angle.cfg
    action	pencil.cfg
    action	pirate.cfg
    action	question_arrow.cfg
    action	right_ptr.cfg
    action	right_side.cfg
    action	right_tee.cfg
    action	sailboat.cfg
    action	sb_down_arrow.cfg
    action	sb_h_double_arrow.cfg
    action	sb_left_arrow.cfg
    action	sb_right_arrow.cfg
    action	sb_up_arrow.cfg
    action	sb_v_double_arrow.cfg
    action	shuttle.cfg
    action	sizing.cfg
    action	target.cfg
    action	top_left_corner.cfg
    action	top_right_corner.cfg
    action	top_side.cfg
    action	top_tee.cfg
    action	trek.cfg
    action	ul_angle.cfg
    action	ur_angle.cfg
    action	watch.cfg
    action	xterm.cfg

    action	base_arrow_down.xcf
    action	base_arrow_up.xcf
    action	basic_arrow.xcf
    action	boat.xcf
    action	bottom_left_corner.xcf
    action	bottom_right_corner.xcf
    action	bottom_side.xcf
    action	bottom_tee.xcf
    action	center_ptr.xcf
    action	circle.xcf
    action	cross.xcf
    action	dot_box_mask.xcf
    action	dot.xcf
    action	double_arrow.xcf
    action	draped_box.xcf
    action	exchange.xcf
    action	fleur.xcf
    action	gumby.xcf
    action	hand1.xcf
    action	hand2.xcf
    action	left_ptr_watch.xcf
    action	left_ptr.xcf
    action	left_side.xcf
    action	left_tee.xcf
    action	ll_angle.xcf
    action	lr_angle.xcf
    action	pencil.xcf
    action	pirate.xcf
    action	question_arrow.xcf
    action	right_ptr.xcf
    action	right_side.xcf
    action	right_tee.xcf
    action	sailboat.xcf
    action	sb_down_arrow.xcf
    action	sb_h_double_arrow.xcf
    action	sb_left_arrow.xcf
    action	sb_right_arrow.xcf
    action	sb_up_arrow.xcf
    action	sb_v_double_arrow.xcf
    action	shuttle.xcf
    action	sizing.xcf
    action	target.xcf
    action	top_left_corner.xcf
    action	top_right_corner.xcf
    action	top_side.xcf
    action	top_tee.xcf
    action	trek.xcf
    action	ul_angle.xcf
    action	ur_angle.xcf
    action	watch.xcf
    action	X_cursor.xcf
    action	xterm.xcf
}

symlink_data_cursors() {
    symlink_data_cursors_handhelds
    symlink_data_cursors_redglass
    symlink_data_cursors_whiteglass
}

symlink_data_bitmaps() {
    src_dir include/bitmaps
    dst_dir data/bitmaps

    action	1x1
    action	2x2
    action	black
    action	boxes
    action	calculator
    action	cntr_ptr
    action	cntr_ptrmsk
    action	cross_weave
    action	dimple1
    action	dimple3
    action	dot
    action	dropbar7
    action	dropbar8
    action	escherknot
    action	flagdown
    action	flagup
    action	flipped_gray
    action	gray
    action	gray1
    action	gray3
    action	grid16
    action	grid2
    action	grid4
    action	grid8
    action	hlines2
    action	hlines3
    action	icon
    action	keyboard16
    action	left_ptr
    action	left_ptrmsk
    action	letters
    action	light_gray
    action	mailempty
    action	mailemptymsk
    action	mailfull
    action	mailfullmsk
    action	mensetmanus
    action	menu10
    action	menu12
    action	menu16
    action	menu6
    action	menu8
    action	noletters
    action	opendot
    action	opendotMask
    action	plaid
    action	right_ptr
    action	right_ptrmsk
    action	root_weave
    action	scales
    action	sipb
    action	star
    action	starMask
    action	stipple
    action	target
    action	terminal
    action	tie_fighter
    action	vlines2
    action	vlines3
    action	weird_size
    action	wide_weave
    action	wingdogs
    action	woman
    action	xfd_icon
    action	xlogo11
    action	xlogo16
    action	xlogo32
    action	xlogo64
    action	xsnow
}

symlink_data_xkbdata() {
    src_dir programs/xkbcomp/torture
    dst_dir data/xkbdata/torture

    action	indicator
    action	indicator1
    action	indicator2
    action	indicator3
    action	mod_compat
    action	mod_compat1
    action	mod_compat2
    action	mod_compat3
    action	mod_compat4
    action	sym_interp
    action	sym_interp1
    action	sym_interp2
    action	sym_interp3
    action	sym_interp4
    action	types

    src_dir programs/xkbcomp/types
    dst_dir data/xkbdata/types

    action	README

    action	basic
    action	cancel
    action	caps
    action	complete
    action	default
    action	extra
    action	iso9995
    action	mousekeys
    action	numpad
    action	pc

    src_dir programs/xkbcomp/keycodes
    dst_dir data/xkbdata/keycodes

    action	aliases
    action	amiga
    action	ataritt
    action	fujitsu
    action	hp
    action	ibm
    action	macintosh
    action	powerpcps2
    action	README
    action	sony
    action	sun
    action	xfree86
    action	xfree98

    src_dir programs/xkbcomp/keycodes/digital
    dst_dir data/xkbdata/keycodes/digital
    
    action	lk
    action	pc
    
    src_dir programs/xkbcomp/keycodes/sgi
    dst_dir data/xkbdata/keycodes/sgi
    
    action	indigo
    action	iris
    action	indy
    
    src_dir programs/xkbcomp/rules
    dst_dir data/xkbdata/rules
    
    action	README
    action	sgi
    action	sgi.lst
    action	sun
    action	sun.lst
    action	xfree98
    action	xfree98.lst
    action	xkb.dtd
    action	xml2lst.pl
    action	xorg
    action	xorg-it.lst
    action	xorg.lst
    action	xorg.xml
    
    src_dir programs/xkbcomp/compat
    dst_dir data/xkbdata/compat

    action	accessx
    action	basic
    action	complete
    action	default
    action	iso9995
    action	japan
    action	keypad
    action	ledcaps
    action	lednum
    action	ledscroll
    action	misc
    action	mousekeys
    action	norepeat
    action	pc
    action	pc98
    action	README
    action	xfree86
    action	xtest

    src_dir programs/xkbcomp/geometry
    dst_dir data/xkbdata/geometry
    
    action	amiga
    action	ataritt
    action	chicony
    action	dell
    action	everex
    action	fujitsu
    action	hp
    action	keytronic
    action	kinesis
    action	macintosh
    action	microsoft
    action	nec
    action	northgate
    action	pc
    action	README
    action	sony
    action	sun
    action	winbook
    
    src_dir programs/xkbcomp/geometry/sgi
    dst_dir data/xkbdata/geometry/sgi
    
    action	indigo
    action	indy
    action	O2
    
    src_dir programs/xkbcomp/geometry/ibm
    dst_dir data/xkbdata/geometry/ibm
    
    action	thinkpad
    
    src_dir programs/xkbcomp/geometry/digital
    dst_dir data/xkbdata/geometry/digital
    
    action	lk
    action	pc 
    action	unix
    
    src_dir programs/xkbcomp/semantics
    dst_dir data/xkbdata/semantics
    
    action	basic
    action	complete
    action	default
    action	xtest
    
    src_dir programs/xkbcomp/keymap
    dst_dir data/xkbdata/keymap
    
    action	amiga
    action	ataritt
    action	macintosh
    action	README
    action	sony
    action	xfree86
    action	xfree98
    
    src_dir programs/xkbcomp/keymap/digital
    dst_dir data/xkbdata/keymap/digital
    
    action	us
    
    src_dir programs/xkbcomp/keymap/sgi
    dst_dir data/xkbdata/keymap/sgi
    
    action	be
    action	bg
    action	ca
    action	cz
    action	cz_qwerty
    action	de
    action	de_CH
    action	dk
    action	dvorak
    action	en_US
    action	es
    action	fi
    action	fr
    action	fr_CH
    action	gb
    action	hu
    action	it
    action	jp
    action	no
    action	pl
    action	pt
    action	ru
    action	se
    action	sk
    action	sk_qwerty
    action	th
    action	us
    
    src_dir programs/xkbcomp/keymap/sun
    dst_dir data/xkbdata/keymap/sun
    
    action	de
    action	es
    action	fi
    action	fr
    action	no
    action	pl
    action	ru
    action	se
    action	uk
    action	us
    
    src_dir programs/xkbcomp/symbols
    dst_dir data/xkbdata/symbols
    
    action	al
    action	altwin
    action	am
    action	apple
    action	ar
    action	az
    action	be
    action	ben
    action	bg
    action	br
    action	bs
    action	by
    action	ca
    action	ca_enhanced
    action	capslock
    action	compose
    action	ctrl
    action	cz
    action	cz_qwerty
    action	czsk
    action	de
    action	de_CH
    action	dev
    action	dk
    action	dvorak
    action	ee
    action	el
    action	en_US
    action	es
    action	eurosign
    action	fi
    action	fo
    action	fr
    action	fr_CH
    action	gb
    action	ge_la
    action	ge_ru
    action	group
    action	guj
    action	gur
    action	hr
    action	hr_US
    action	hu
    action	hu_qwerty
    action	hu_US
    action	ie
    action	il
    action	il_phonetic
    action	inet
    action	ir
    action	is
    action	iso9995-3
    action	it
    action	iu
    action	jp
    action	kan
    action	keypad
    action	la
    action	level3
    action	lo
    action	lock
    action	lt
    action	lt_a
    action	lt_p
    action	lt_std
    action	lv
    action	mk
    action	ml
    action	mm
    action	mn
    action	mt
    action	mt_us
    action	nl
    action	no
    action	ogham
    action	ori
    action	pc104
    action	pl
    action	pl2
    action	pt
    action	ralt
    action	README
    action	ro
    action	ro2
    action	ru
    action	sapmi
    action	se
    action	se_FI
    action	se_NO
    action	se_SE
    action	si
    action	sk
    action	sk_qwerty
    action	sr
    action	srvr_ctrl
    action	syr
    action	syr_phonetic
    action	tel
    action	th
    action	th_pat
    action	th_tis
    action	tj
    action	tml
    action	tr
    action	tr_f
    action	ua
    action	us
    action	us_group2
    action	us_group3
    action	us_intl
    action	uz
    action	vn
    action	yu
    
    src_dir programs/xkbcomp/symbols/sun
    dst_dir data/xkbdata/symbols/sun
    
    action	se
    action	us
    action	usb
    
    src_dir programs/xkbcomp/symbols/hp
    dst_dir data/xkbdata/symbols/hp
    
    action	us
    
    src_dir programs/xkbcomp/symbols/macintosh
    dst_dir data/xkbdata/symbols/macintosh
    
    action	de
    action	de_CH
    action	dk
    action	es
    action	fi
    action	fr
    action	fr_CH
    action	gb
    action	it
    action	nl
    action	no
    action	pt
    action	se
    action	us
    
    src_dir programs/xkbcomp/symbols/pc
    dst_dir data/xkbdata/symbols/pc
    
    action	al
    action	am
    action	ara
    action	az
    action	ba
    action	bd
    action	be
    action	bg
    action	br
    action	bt
    action	by
    action	ca
    action	ch
    action	cz
    action	de
    action	dk
    action	ee
    action	es
    action	fi
    action	fo
    action	fr
    action	gb
    action	ge
    action	gr
    action	hr
    action	hu
    action	ie
    action	il
    action	in
    action	ir
    action	is
    action	it
    action	jp
    action	kg
    action	la
    action	latam
    action	latin
    action	lk
    action	lt
    action	lv
    action	mao
    action	mkd
    action	mm
    action	mn
    action	mt
    action	nl
    action	no
    action	pc
    action	pk
    action	pl
    action	pt
    action	ro
    action	ru
    action	se
    action	si
    action	sk
    action	srp
    action	sy
    action	th
    action	tj
    action	tr
    action	ua
    action	us
    action	uz
    action	vn
    
    src_dir programs/xkbcomp/symbols/sgi
    dst_dir data/xkbdata/symbols/sgi
    
    action	jp
    
    src_dir programs/xkbcomp/symbols/xfree68
    dst_dir data/xkbdata/symbols/xfree68
    
    action	amiga
    action	ataritt
    
    src_dir programs/xkbcomp/symbols/fujitsu
    dst_dir data/xkbdata/symbols/fujitsu
    
    action	jp
    action	us
    
    src_dir programs/xkbcomp/symbols/digital
    dst_dir data/xkbdata/symbols/digital
    
    action	lk
    action	pc
    action	us
    action	vt
    
    src_dir programs/xkbcomp/symbols/sony
    dst_dir data/xkbdata/symbols/sony
    
    action	us
    
    src_dir programs/xkbcomp/symbols/nec
    dst_dir data/xkbdata/symbols/nec
    
    action	jp
}

symlink_data() {
    symlink_data_cursors		  
    symlink_data_bitmaps
    symlink_data_xkbdata
}


########
#
#     List of files that are deliberately not symlinked into
#     the modular tree
#
#########

# exclude $1 and everything in it
exclude_directory()
{
    for dir in `find $SRC_DIR/$1 -type d` ; do
	dir=`echo $dir | sed s,$SRC_DIR,, | sed s,^/,,`
	src_dir $dir

#       Some versions of find do not support -maxdepth
#	for file in `find $SRC_DIR/$dir -maxdepth 1 -type f `; do
#	    action `basename $file`
#	done
	for file in $SRC_DIR/$dir/*; do
	    if [ -f $file ]; then
		action `basename $file`
	    fi
	done
    done
}

exclude_glob()
{
    for file in `find $SRC_DIR -name "$1"` ; do
	src_dir `dirname $file | sed s,$SRC_DIR,, | sed s,^/,,`
	action `basename $file`
    done
}

exclude_xft_buildsystem()
{
    src_dir lib/Xft

    action	aclocal.m4
    action	autogen.sh
    action	config.guess
    action	config.h.in
    action	config.sub
    action	configure
    action	configure.ac
    action	depcomp
    action	install-sh
    action	ltmain.sh
    action	Makefile.am
    action	Makefile.in
    action	missing
    action	mkinstalldirs
    action	Xft-def.cpp

    src_dir lib/Xft/config
    action	config-subst
}

exclude_render_buildsystem()
{
    src_dir lib/Xrender

    action	AUTHORS
    action	autogen.sh
    action	ChangeLog
    action	config.h
    action	configure.ac
    action	COPYING
    action	INSTALL
    action	NEWS
    action	README
    action	Xrender-def.cpp
    action	xrender.pc.in
}

exclude_composite_buildsystem()
{
    src_dir lib/Xcomposite

    action	AUTHORS
    action	autogen.sh
    action	ChangeLog
    action	configure.ac
    action	COPYING
    action	.cvsignore
    action	INSTALL
    action	Makefile.am
    action	NEWS
    action	README
    action	xcomposite.pc.in
}

exclude_cursor_buildsystem()
{
    src_dir lib/Xcursor

    action	AUTHORS
    action	autogen.sh
    action	ChangeLog
    action	config.h
    action	config-subst
    action	configure.ac
    action	COPYING
    action	INSTALL
    action	Makefile.am
    action	NEWS
    action	README
    action	xcursor-config.in
    action	Xcursor-def.cpp
    action	xcursor.pc.in
}

exclude_damage_buildsystem()
{
    src_dir lib/Xdamage
    
    action	AUTHORS
    action	autogen.sh
    action	ChangeLog
    action	configure.ac
    action	COPYING
    action	.cvsignore
    action	INSTALL
    action	Makefile.am
    action	NEWS
    action	README
    action	xdamage.pc.in
}

exclude_fixes_buildsystem()
{
    src_dir lib/Xfixes

    action	AUTHORS
    action	autogen.sh
    action	ChangeLog
    action	configure.ac
    action	COPYING
    action	.cvsignore
    action	INSTALL
    action	Makefile.am
    action	NEWS
    action	README
    action	Xfixes-def.cpp
    action	xfixes.pc.in
}

exclude_gl_apple()
{
    # These files should be part of Mesa, 
    # according to Adam
    src_dir lib/GL/apple

    action	appledri.c
    action	appledri.h
    action	appledristr.h
    action	build-dispatch
    action	dri_dispatch.c
    action	dri_dispatch.defs
    action	dri_dispatch.h
    action	dri_driver.c
    action	dri_driver.h
    action	dri_glx.c
    action	dri_glx.h
}

symlink_non_linked_files()
{
    # SGI is upstream for these files. Not sure what to about them, but
    # one place they absolutely do _not_ belong, is in the X tree.
    exclude_directory doc/man/GL
    exclude_directory doc/man/GLU
    
    # This stuff is used to build binary distributions of the monolith.
    # It would have to be redone to do something similar for the modular.
    exclude_directory programs/Xserver/hw/xfree86/etc/bindist

    # DPS is not part of the modular tree 
    exclude_directory lib/dps
    exclude_directory programs/dpsexec
    exclude_directory programs/dpsinfo
    exclude_directory programs/texteroids
    exclude_directory include/DPS
    exclude_directory config/pswrap
    exclude_directory lib/dpstk
    exclude_directory lib/psres

    # Speedo font support is deprecated in 7.0
    exclude_directory lib/font/Speedo

    # Exclude unmaintained sun and sunLynx
    exclude_directory programs/Xserver/hw/sun
    exclude_directory programs/Xserver/hw/sunLynx

    # Exclude deprecated wacom(4)
    exclude_directory programs/Xserver/hw/xfree86/input/wacom

    # Exclude old and known-broken sample(4)
    exclude_directory programs/Xserver/hw/xfree86/input/sample

    # Exclude xterm
    exclude_directory programs/xterm

    # Nobody should really care about Xft1 anymore
    exclude_directory lib/Xft1

    # these are included with Mesa
    exclude_directory programs/glxgears
    exclude_directory programs/glxinfo
    exclude_directory lib/GLw
    exclude_directory include/GL
    
    # exclude config/util - I don't think it's relevant for the modular tree
    exclude_directory config/util

    # These all have their own build systems in the modular tree
    exclude_xft_buildsystem
    exclude_render_buildsystem
    exclude_composite_buildsystem
    exclude_cursor_buildsystem
    exclude_damage_buildsystem
    exclude_fixes_buildsystem

    # By definition the monolith is not upstream for this
    exclude_directory extras

    # Exclude memleak (verified by keithp)
    exclude_directory util/memleak

    # Use upstream packaging of expat
    exclude_directory lib/expat

    # Exclude fontconfig
    exclude_directory programs/fc-cache
    exclude_directory programs/fc-list
    exclude_directory lib/fontconfig

    # Stuff that may be resurrected if someone complains enough
    exclude_directory programs/Xserver/hw/xfree86/etc

    # Exclude empty directory that just has README saying kdrive doesn't
    # live here any more
    exclude_directory programs/Xserver/hw/kdrive

    # Empty stubs for projects not yet checked into CVS
    exclude_directory programs/Xserver/Xprint/pdf
    exclude_directory programs/Xserver/Xprint/svg
    exclude_directory programs/Xserver/Xprint/windows
    
    # Exclude monolithic tree SDK
    exclude_directory programs/Xserver/hw/xfree86/sdk

    # Exclude platforms that are no longer maintained
    src_dir programs/Xserver/hw/xfree86/etc
    action	install.sv3
    action	mmapSVR3.shar
    action	svr3_patch
    action	svr3_rem_pch
    action	svr4_patch
    action	svr4_rem_pch

    # Upgrades stone age (pre-1994) config files to bronze age (1994) 
    # config files.  Not built in the monolith since XFree86 3.9 series 
    # in 1998 and XFree86 has even deleted from their monolith.
    exclude_directory programs/Xserver/hw/xfree86/reconfig

    # These fonts are not needed because they are generated
    exclude_glob "*-L1.bdf"
    exclude_glob "*-JISX0201.bdf"

    # These files are not needed
    exclude_glob "Imakefile*"
    exclude_glob "jump_*"
    exclude_glob ".cvsignore"

    exclude_gl_apple

    # These files are only used by OS/2 and can be added back if a
    # maintainer steps up
    exclude_glob "*-def.cpp"
    src_dir programs/Xserver
    action	XFree86.def
    action	Xnest.def
    action	Xorg.def
    action	Xvfb.def
    src_dir programs/Xserver/hw/xfree86/xf86config
    action	xf86config.cmd
    src_dir programs/Xserver/hw/xfree86/loader
    action      os2funcs.c

    # This file is replaced by httptransport.c in the modular tree
    src_dir programs/xrx/helper
    action	httptran.c

    # Some toplevel monolithic stuff
    src_dir
    action	BUILD		# description of the monolithic build system
    action	ChangeLog	# irrelevant to modular
    action	Makefile	# Only useful for monolith

    # These files generate the list of drivers (input and video) for the
    # monolithic build system and are not needed for the modular build
    src_dir programs/Xserver/hw/xfree86/drivers
    action	confdrv.sh
    src_dir programs/Xserver/hw/xfree86/input
    action	confdrv.sh

    # expat is external now
    src_dir lib/expat
    action expat_config.h
    
    # This file is replaced by a Makefile.am
    src_dir programs/Xserver/hw/xfree86/drivers/mga/util
    action	Makefile

    # The via_drm.h file belongs in libdrm
    src_dir programs/Xserver/hw/xfree86/drivers/via
    action	via_drm.h

    # This file is only useful in the monolith
    src_dir programs/Xserver/hw/dmx/doc
    action	Makefile.linux

    # No longer needed as dlopen modules are default
    src_dir programs/Xserver/hw/xfree86/os-support/sunos
    action	find_deps.pl

    # Obsolete docs
    src_dir programs/Xserver/hw/xfree86/doc/sgml
    action	BUILD.sgml		# - specific to the monolith
					#   build system
    action	Status.sgml		# - obsolete
    action	README.build-docs	# - specific to monolith build

    src_dir programs/Xserver/hw/xfree86
    action	XF86Conf.man
    action	XF98Conf.cpp

    # These docs are only useful for monolith
    src_dir
    action	LABEL
    action	README
    action	README.crypto
    action	RELNOTES

    # This file is not used by in modular tree
    src_dir
    action	xf86Date.h

    # This should be distributed to various font components
    src_dir fonts/bdf/misc
    action	README

    # Using upstream version from Gnome
    src_dir fonts/scaled/TTF
    action	COPYRIGHT.Vera

    # This file is not used by makedepend in the monolith
    src_dir config/makedepend
    action	cpp.ed

    # This file is not used in the monolith
    src_dir config/docbook
    action	docbookconv.sh

    # The following files are simple test files that should not be
    # included with the library
    src_dir lib/Xrandr
    action	test.c
    src_dir lib/font/Type1
    action	minimain.c
    action	t1test.c

    # Don't symlink XFree86 xpm logos or sequent .Xdefaults from xdm
    src_dir programs/xdm/config
    action	XFree86.xpm
    action	XFree86bw.xpm
    action	system.Xdefaults.sequent
    action	system.xsession.sequent

    # Dead source file from cfb, never built in monolith
    src_dir programs/Xserver/cfb
    action      stipple68k.s
    
    # Generated html, so don't symlink
    src_dir programs/xphelloworld/xphelloworld
    action      xphelloworld.html

    src_dir programs/xphelloworld/xpsimplehelloworld
    action      xpsimplehelloworld.html

    src_dir programs/xphelloworld/xpxmhelloworld
    action      xpxmhelloworld.html

    src_dir programs/xphelloworld/xpxthelloworld
    action      xpxthelloworld.html

    src_dir programs/xplsprinters
    action      xplsprinters.html

    src_dir programs/xprehashprinterlist
    action      xprehashprinterlist.html

    src_dir doc/man/general
    action	Xprint.html

    # Unused symbol export control thing. No clue how this ever worked.
    exclude_glob "*.elist"

    # Highly non-free reimplementation of snprintf.  If your libc is so
    # crippled as to need this, steal it from BSD's libc instead, thanks.
    src_dir lib/misc
    action      snprintf.c
    action      snprintf.h

    # A do-nothing header in Xevie.  Take a drink.
    src_dir lib/Xevie
    action      xevieplaceholder.h

    # Script to generate the list of widgets in the Xaw set.  Hopefully
    # no one is adding new ones anymore...
    src_dir lib/Xaw
    action      genlist.sh

    # Workarounds for long forgotten bugs in SunOS 4.1 & Solaris 2.3
    src_dir util/misc
    action	dlsym.c
    action	thr_stubs.c
    action	rt.stdarg.h

    # Generated README files for the drivers
    src_dir programs/Xserver/hw/xfree86/doc
    action	README.DECtga
    action	README.I128
    action	README.SiS
    action	README.apm
    action	README.chips
    action	README.cyrix
    action	README.i740
    action	README.i810
    action	README.mouse
    action	README.newport
    action	README.rendition
    action	README.s3virge
    action	README.ati
    action	README.r128
    
    src_dir programs/Xserver/hw/xfree86/drivers/i740
    action	README

    # We use the compiled version of ucs2any, so the perl version is no
    # longer needed or used
    src_dir	fonts/util
    action	ucs2any.pl

    # The .cf and .rules files are used only in the local xedit Imakefiles
    src_dir programs/xedit/lisp
    action	lisp.cf
    action	lisp.rules

    # The following file is duplicates the copyright that is already
    # present in the source files
    src_dir programs/rstart
    action	c

    # These files are copies of FreeType source code
    src_dir lib/font/FreeType/module
    action	ft2build.h
    action	ftheader.h
    action	ftmodule.h
    action	ftoption.h
    action	ftstdlib.h
    action	fttypes.h
    action	myftstdlib.h

    # This file is an older version of the README file already linked into
    # the neomagic driver
    src_dir programs/Xserver/hw/xfree86/doc
    action	README.neomagic

    # This is just random libc implementations
    src_dir lib/Xbsd
    action	Berklib.c

    # A file with no entries - and we already have an empty file
    # in the modular tree
    src_dir nls/Compose
    action	zh_CN

    # These files are all generated from the sgml files in doc/old/sgml
    # When/if those files are converted to xml, we can maybe do something
    # with the generated results
    src_dir programs/Xserver/hw/xfree86/doc

    action	README.Darwin
    action	README.dps
    action	OS2.Notes
    action	LICENSE
    action	Install
    action	README.LynxOS
    action	README.NetBSD
    action	README.OpenBSD
    action	README.SCO
    action	README.Solaris
    action	Versions
    action	README.XKB-Config
    action	README.XKB-Enhancing
    action	BUILD
    action	README
    action	RELNOTES

    # Not really useful given bugzilla
    action	BugReport.cpp

    # like anybody cared
    action	CODING

    # Pc98 doc - FIXME maybe this is actually useful
    action	VideoBoard98

    # Generated from sgml/DESIGN.sgml
    action	DESIGN

    src_dir programs/Xserver/hw/xfree86/doc/Japanese
    action	README98
    action	README98.1st

    # These files are not even used by the monolith
    src_dir lib/X11/xlibi18n/im/ximcp
    action	Ximcp.mapfile
    src_dir lib/X11/xlibi18n/lc/def
    action	Xlc.mapfile
    src_dir lib/X11/xlibi18n/lc/gen
    action	Xlc.mapfile
    src_dir lib/X11/xlibi18n/om/generic
    action	Xom.mapfile

    # This file is part of the monolithic build system
    src_dir lib/X11/xlibi18n
    action	Xi18nLib.conf

    # These files are needed for cross compilation and OS/2
    src_dir config/imake
    action	ccimake.c
    action	imakesvc.cmd
    action	Makefile.ini
}

print_source()
{
    echo $1 >> symlink-processed-files
}

generate_monolith_files()
{
    for cvsdir in `find $SRC_DIR -name "CVS"` ; do
	for file in `cat $cvsdir/Entries | grep -v "^D" | cut -d"/" -f2 `; do
	    echo `echo $cvsdir | sed s/CVS//`$file >> all-monolith-files
	done
    done
}

list_missing()
{
    rm -f symlink-processed-files
    rm -f symlink-processed-files.sorted
    rm -f all-monolith-files
    rm -f all-monolith-files.sorted

    # make sure we are not excluding anything that doesn't exist
    ACTION=check_exist EXPLANATION="Checking that excluded files exist" run_module non_linked_files

    # generate a list of all files that this script is going to link
    run print_source "Generating list of linked files" 

    # generate a list of all files that this script is explicityly *not* going to link
    ACTION=print_source EXPLANATION="Generating list of non-linked files" run_module non_linked_files

    # generate a list of all files in the xc directory, except those that
    # we already know we don't care about

    echo -n Generating list of all monolithic files ...\ 

    generate_monolith_files

    echo DONE

    echo -n Generating list of missing files in file \"missing-files\" ...\ 

    sort symlink-processed-files > symlink-processed-files.sorted
    sort all-monolith-files > all-monolith-files.sorted

    diff -u symlink-processed-files.sorted all-monolith-files.sorted  | grep -v "^-" | grep "^\+" | cut -d "+" -f2 > missing-files

    echo DONE
}


#########
#
#    Helper functions
#
#########

error() {
	echo
	echo \ \ \ error:\ \ \ $1
	exit
}

# printing out what's going on
run_module() {
    # $1 module
    # $2 explanation
    echo -n $EXPLANATION for $1 module ...\ 
    symlink_$1
    echo DONE
}

run() {
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
    ACTION=$1 EXPLANATION=$2 run_module data
}

src_dir() {
    if [ x$1 = x ]; then
	REAL_SRC_DIR=$SRC_DIR
    else
	REAL_SRC_DIR=$SRC_DIR/$1
    fi
    if [ ! -d $REAL_SRC_DIR ] ; then
	error "Source directory $REAL_SRC_DIR does not exist"
    fi
}

dst_dir() {
    REAL_DST_DIR=$DST_DIR/$1
    if [ ! -d $REAL_DST_DIR ] ; then
	mkdir -p $REAL_DST_DIR
    fi
}

action() {
    if [ -z $2 ] ; then
	$ACTION	$REAL_SRC_DIR/$1	$REAL_DST_DIR/$1
    else
	$ACTION	$REAL_SRC_DIR/$1	$REAL_DST_DIR/$2
    fi
}

usage() {
    echo
    echo Usage:
    echo \  symlink.sh [ -m ]  src-dir dst-dir
    echo  
    echo \  src-dir: the xc directory of the monolithic source tree
    echo \  dst-dir: the modular source tree containing proto, app, lib, ...
    echo  
    echo \  -m: Instead of symlinking the files, list the files from the source
    echo \ \ \ \ \ \ directory that are not processed by this script
}

# Check commandline args
check_args() {
    MISSING_FILES=no
    if [ x$1 = "x-m" ] ; then
	MISSING_FILES=yes
	shift
    fi

    if [ -z $1 ] ; then
	echo Missing source dir
	usage
	exit 1
    fi

    if [ -z $2 ] ; then
	echo Missing destination dir
	usage
	exit 1
    fi
     
    if [ ! -d $1 ] ; then
	echo $1 is not a dir
	usage
	exit 1
    fi

    if [ ! -d $2 ] ; then
	echo $2 is not a dir
	usage
	exit 1
    fi

    if [ $1 = $2 ] ; then
	echo source and destination can\'t be the same
	usage
	exit 1
    fi

    D=`dirname "$relpath"`
    B=`basename "$relpath"`
    abspath="`cd \"$D\" 2>/dev/null && pwd || echo \"$D\"`/$B"

    SRC_DIR=`( cd $1 ; pwd )`
    DST_DIR=`( cd $2 ; pwd )`
}

check_args $1 $2 $3

if [ $MISSING_FILES = yes ] ; then
    list_missing
else
    run_symlink
fi
