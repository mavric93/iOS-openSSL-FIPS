#---------------------------------------------------------
# build FIPS Capable library
#---------------------------------------------------------
ARCH=$1
# move to Source dir
cd Source

# make incore_macho available to build
export PATH="/usr/local/bin":$PATH

# delete old artifacts
rm -Rf openssl-1.0.2h/

# unpack fresh files
tar xzf openssl-1.0.2h.tar.gz 

# move to ssl' dir
cd openssl-1.0.2h/

# remove references to ERR_load_COMP_strings in err_all.c
sed  s/ERR_load_COMP_strings\(\)\;// <crypto/err/err_all.c >crypto/err/err_all.c.new
mv crypto/err/err_all.c.new crypto/err/err_all.c

# setup environment
. ../setenv-reset.sh
# . ../setenv-ios-11.sh
cross_arch="-${ARCH}"
MACHINE=`echo "$cross_arch" | sed -e 's/^-//'`
SYSTEM="iphoneos"
BUILD="build"

export MACHINE
export SYSTEM
export BUILD
#
# fips/sha/Makefile uses HOSTCC for building fips_standalone_sha1
#
export HOSTCC=/usr/bin/cc
export HOSTCFLAGS="-arch i386"
	export IOS_MIN_SDK_VERSION="8.0"
	export DEVELOPER=`xcode-select -print-path`
	export PLATFORM="iPhoneOS"
	export CROSS_TOP="${DEVELOPER}/Platforms/${PLATFORM}.platform/Developer"
	export CROSS_SDK="${PLATFORM}${IOS_SDK_VERSION}.sdk"
	export BUILD_TOOLS="${DEVELOPER}"
	export CC="${BUILD_TOOLS}/usr/bin/gcc -fembed-bitcode -arch ${ARCH}"

# configure and make FIPS Capable library
./config fips -no-shared -no-comp -no-dso -no-hw -no-engines -no-sslv2 -no-sslv3 --with-fipsdir=/usr/local/ssl/Release-iphoneos
sed s/MAKEDEPPROG\=makedepend/MAKEDEPPROG\=\$\(CC\)\ -M/ Makefile
sed -ie "s!^CFLAG=!CFLAG=-isysroot ${CROSS_TOP}/SDKs/${CROSS_SDK} -miphoneos-version-min=${IOS_MIN_SDK_VERSION} !" "Makefile"
make depend
make build_libs
make install

mv /usr/local/ssl/Release-iphoneos/libcrypto.a /usr/local/ssl/Release-iphoneos/libcrypto_"${ARCH}".a
mv /usr/local/ssl/Release-iphoneos/libssl.a /usr/local/ssl/Release-iphoneos/libssl_"${ARCH}".a