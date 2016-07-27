#---------------------------------------------------------
# install FIPS Capable library
#---------------------------------------------------------

# move to Source dir
cd Source

# move to ssl' dir
cd openssl-1.0.2h/

# setup environment
. ../setenv-reset.sh
. ../setenv-ios-11.sh
# pushd /usr/local/ssl/Release-iphoneos > /dev/null
# lipo \
# 	"/tmp/openssl-iOS-armv7/lib/libcrypto.a" \
# 	"/tmp/openssl-iOS-i386/lib/libcrypto.a" \
# 	-create -output lib/libcrypto_iOS.a
# lipo \
# 	"/tmp/openssl-iOS-armv7/lib/libssl.a" \
# 	"/tmp/openssl-iOS-i386/lib/libssl.a" \
# 	-create -output lib/libssl_iOS.a
# 	echo "Adding 64-bit libraries"
# 	lipo \
# 		"lib/libcrypto_iOS.a" \
# 		"/tmp/openssl-iOS-arm64/lib/libcrypto.a" \
# 		"/tmp/openssl-iOS-x86_64/lib/libcrypto.a" \
# 		-create -output lib/libcrypto_iOS.a
# 	lipo \
# 		"lib/libssl_iOS.a" \
# 		"/tmp/openssl-iOS-arm64/lib/libssl.a" \
# 		"/tmp/openssl-iOS-x86_64/lib/libssl.a" \
# 		-create -output lib/libssl_iOS.a
# 
# popd > /dev/null

FIPSDIR=/usr/local/ssl/Release-iphoneos
INCDIR=/usr/local/ssl/Release-iphoneos/include/openssl

# install - may require root...
# libraries
cp libssl.a $FIPSDIR
cp libcrypto.a $FIPSDIR
# headers
cp crypto/stack/stack.h     $INCDIR
cp crypto/stack/safestack.h $INCDIR
cp crypto/err/err.h         $INCDIR
cp crypto/bio/bio.h         $INCDIR
cp crypto/lhash/lhash.h     $INCDIR
cp crypto/rand/rand.h       $INCDIR
cp crypto/evp/evp.h         $INCDIR
cp crypto/objects/objects.h $INCDIR
cp crypto/objects/obj_mac.h $INCDIR
cp crypto/asn1/asn1.h       $INCDIR

