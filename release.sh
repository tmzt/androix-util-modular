#!/bin/sh

set -e

section="$1"
tag_previous="$2"
tag_current="$3"

shift 3

announce_list="xorg-announce@lists.freedesktop.org"
host_people=annarchy.freedesktop.org
host_xorg=xorg.freedesktop.org

usage()
{
    cat <<HELP
Usage: `basename $0` [options] <section> <tag_previous> <tag_current>

Options:
  --force       force overwritting an existing release
  --help        this help message
HELP
}

gen_announce_mail()
{
    cat <<RELEASE
Subject: [ANNOUNCE] $module $version
To: $announce_list

`git-log --no-merges $tag_previous..'HEAD^1' | git shortlog`

git tag: $tag_current

http://$host_xorg/$section_path/$targz
MD5: `cd $tarball_dir && md5sum $tarbz2`
SHA1: `cd $tarball_dir && sha1sum $tarbz2`

http://$host_xorg/$section_path/$targz
MD5: `cd $tarball_dir && md5sum $targz`
SHA1: `cd $tarball_dir && sha1sum $targz`

RELEASE
}

for arg do
    case "$arg" in
    --force)
        force="yes"
        ;;
    --help)
        usage
        exit 0
        ;;
    *)
        echo "error: unknown option"
        usage
        exit 1
        ;;
    esac
done

tarball_dir="$(dirname $(find -name config.status))"
module="${tag_current%-*}"
version="${tag_current##*-}"
tarbz2="$tag_current.tar.bz2"
targz="$tag_current.tar.bz2"
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

echo "checking for existing releases"
if ssh $host_people ls $srv_path/$targz >/dev/null 2>&1 ||
   ssh $host_people ls $srv_path/$tarbz2 >/dev/null 2>&1; then
    if [ "x$force" = "xyes" ]; then
        echo "warning: overriding released file ... here be dragons."
    else
        echo "error: file already exists!"
        exit 1
    fi
fi

echo "checking for proper current dir"
if ! [ -d .git ]; then
    echo "error: do this from your git dir, weenie"
    exit 1
fi

echo "generating announce mail template, remember to sign it"
gen_announce_mail >$announce
echo "    at: $announce"

echo "installing release into server"
scp $tarball_dir/$targz $tarball_dir/$tarbz2 $host_people:$section_path

echo "pushing changes upstream"
git push origin
git push --tags origin
