#!/bin/sh

set -e

announce_list="xorg-announce@lists.freedesktop.org"
host_people=annarchy.freedesktop.org
host_xorg=xorg.freedesktop.org
user=`whoami`

usage()
{
    cat <<HELP
Usage: `basename $0` [options] <section> <tag_previous> <tag_current>

Options:
  --force       force overwritting an existing release
  --user <name> username on $host_people (default "`whoami`")
  --help        this help message
HELP
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

    cat <<RELEASE
Subject: [ANNOUNCE] $module $version
To: $announce_list

`git log --no-merges "$range" | git shortlog`

git tag: $tag_current

http://$host_xorg/$section_path/$tarbz2
MD5: `cd $tarball_dir && md5sum $tarbz2`
SHA1: `cd $tarball_dir && sha1sum $tarbz2`

http://$host_xorg/$section_path/$targz
MD5: `cd $tarball_dir && md5sum $targz`
SHA1: `cd $tarball_dir && sha1sum $targz`

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

tarball_dir="$(dirname $(find . -name config.status))"
module="${tag_current%-*}"
version="${tag_current##*-}"
tarbz2="$tag_current.tar.bz2"
targz="$tag_current.tar.gz"
announce="$tarball_dir/$tag_current.announce"

section_path="archive/individual/$section"
srv_path="/srv/$host_xorg/$section_path"

echo "checking parameters"
if ! [ -f "$tarball_dir/$tarbz2" ] ||
   ! [ -f "$tarball_dir/$targz" ] ||
     [ -z "$tag_previous" ] ||
     [ -z "$section" ]; then
    echo "error: incorrect parameters!"
    usage
    exit 1
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

