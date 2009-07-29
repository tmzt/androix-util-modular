#!/bin/sh

set -e

announce_list="xorg-announce@lists.freedesktop.org"
xorg_list="xorg@lists.freedesktop.org"
dri_list="dri-devel@lists.freedesktop.org"
host_people=annarchy.freedesktop.org
host_xorg=xorg.freedesktop.org
host_dri=dri.freedesktop.org
user=`whoami`

usage()
{
    cat <<HELP
Usage: `basename $0` [options] <section> <tag_previous> <tag_current>

Options:
  --force       force overwritting an existing release
  --user <name> username on $host_people (default "`whoami`")
  --help        this help message
  --ignore-local-changes        don't abort on uncommitted local changes
HELP
}

abort_for_changes()
{
    cat <<ERR
Uncommitted changes found. Did you forget to commit? Aborting.
Use --ignore-local-changes to skip this check.
ERR
    exit 1
}

gen_announce_mail()
{
case "$tag_previous" in
initial)
	range="$tag_current"
	;;
*)
	range="$tag_previous".."$tag_current"
	;;
esac

MD5SUM=`which md5sum || which gmd5sum`
SHA1SUM=`which sha1sum || which gsha1sum`

if [ $section = libdrm ]; then
    host=$host_dri
    list=$dri_list
else
    host=$host_xorg
    list=$xorg_list
fi

    cat <<RELEASE
Subject: [ANNOUNCE] $module $version
To: $announce_list
CC: $list

`git log --no-merges "$range" | git shortlog`

git tag: $tag_current

http://$host/$section_path/$tarbz2
MD5: `cd $tarball_dir && $MD5SUM $tarbz2`
SHA1: `cd $tarball_dir && $SHA1SUM $tarbz2`

http://$host/$section_path/$targz
MD5: `cd $tarball_dir && $MD5SUM $targz`
SHA1: `cd $tarball_dir && $SHA1SUM $targz`

RELEASE
}

export LC_ALL=C

while [ $# != 0 ]; do
    case "$1" in
    --force)
        force="yes"
        shift
        ;;
    --help)
        usage
        exit 0
        ;;
    --user)
	shift
	user=$1
	shift
	;;
    --ignore-local-changes)
        ignorechanges=1
        shift
        ;;
    --*)
        echo "error: unknown option"
        usage
        exit 1
        ;;
    *)
        section="$1"
        tag_previous="$2"
        tag_current="$3"
        shift 3
        if [ $# != 0 ]; then
            echo "error: unknown parameter"
            usage
            exit 1
        fi
        ;;
    esac
done

# Check for uncommitted/queued changes.
if [ "x$ignorechanges" != "x1" ]; then
    set +e
    git diff --exit-code > /dev/null 2>&1
    if [ $? -ne 0 ]; then
        abort_for_changes
    fi

    git status > /dev/null 2>&1
    if [ $? -eq 0 ]; then
        abort_for_changes
    fi
    set -e
fi

tarball_dir="$(dirname $(find . -name config.status))"
module="${tag_current%-*}"
if [ "x$module" = "x$tag_current" ]; then
    # version-number-only tag.
    pwd=`pwd`
    module=`basename $pwd`
    version="$tag_current"
else
    # module-and-version style tag
    version="${tag_current##*-}"
fi

detected_module=`grep 'PACKAGE = ' Makefile | sed 's|PACKAGE = ||'`
if [ -f $detected_module-$version.tar.bz2 ]; then
    module=$detected_module
fi

modulever=$module-$version
tarbz2="$modulever.tar.bz2"
targz="$modulever.tar.gz"
announce="$tarball_dir/$modulever.announce"

echo "checking parameters"
if ! [ -f "$tarball_dir/$tarbz2" ] ||
   ! [ -f "$tarball_dir/$targz" ] ||
     [ -z "$tag_previous" ] ||
     [ -z "$section" ]; then
    echo "error: incorrect parameters!"
    usage
    exit 1
fi

if [ "$section" = "libdrm" ]; then
    section_path="libdrm"
    srv_path="/srv/$host_dri/www/$section_path"
else
    section_path="archive/individual/$section"
    srv_path="/srv/$host_xorg/$section_path"
fi

echo "checking for proper current dir"
if ! [ -d .git ]; then
    echo "error: do this from your git dir, weenie"
    exit 1
fi

echo "checking for an existing tag"
if ! git tag -l $tag_current >/dev/null; then
    echo "error: you must tag your release first!"
    exit 1
fi

echo "checking for an existing release"
if ssh $user@$host_people ls $srv_path/$targz >/dev/null 2>&1 ||
   ssh $user@$host_people ls $srv_path/$tarbz2 >/dev/null 2>&1; then
    if [ "x$force" = "xyes" ]; then
        echo "warning: overriding released file ... here be dragons."
    else
        echo "error: file already exists!"
        exit 1
    fi
fi

echo "generating announce mail template, remember to sign it"
gen_announce_mail >$announce
echo "    at: $announce"

echo "installing release into server"
scp $tarball_dir/$targz $tarball_dir/$tarbz2 $user@$host_people:$srv_path

echo "pushing changes upstream"
git push origin
git push origin $tag_current

