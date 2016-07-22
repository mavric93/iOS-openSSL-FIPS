#---------------------------------------------------------
# build FIPS Object Module
#---------------------------------------------------------

# move to Source dir
cd Source

# delete old artifacts
rm -Rf openssl-fips-ecp-2.0.12/

# make incore_macho available to build
export PATH="/usr/local/bin":$PATH

# unpack fresh files
tar xzf openssl-fips-ecp-2.0.12.tar.gz 
tar xzf ios-incore-2.0.1.tar.gz
cp -R openssl-fips-2.0.1/ openssl-fips-ecp-2.0.12/
rm -rf openssl-fips-2.0.1/

# move to fips' dir
cd openssl-fips-ecp-2.0.12

# setup environment
. ../setenv-reset.sh
. ../setenv-ios-11.sh

# configure and make
./config
make


