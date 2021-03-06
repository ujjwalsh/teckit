#!/bin/sh
set -ev

# This is how the Mac binaries for release are built, so I don't forget!
# Any existing mac-build and teckit-mac/{bin,lib} directories will be deleted.
# then go to mac-installer/ and run ./create-pkg.sh to generate the pkg and dmg.

rm -rf mac-build teckit-mac

mkdir mac-build
cd mac-build

../configure --enable-final --disable-dependency-tracking
make
(make check || cat test/dotests.pl.log)
make install DESTDIR=`pwd`/inst

cd ..
mkdir -p teckit-mac/bin
mkdir -p teckit-mac/lib
cp -pRf mac-build/inst/usr/local/bin/* teckit-mac/bin
cp -pRf mac-build/inst/usr/local/lib/* teckit-mac/lib

echo '###'
echo '### Built products:'
echo '###'
ls -l teckit-mac/bin teckit-mac/lib
