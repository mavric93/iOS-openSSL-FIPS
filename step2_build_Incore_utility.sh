#---------------------------------------------------------
# steps to build the Incore utility 
#---------------------------------------------------------

# move to Source dir
cd Source

# delete old artifacts
rm -Rf openssl-fips-2.0.12/

# unpack fresh files
tar xzf openssl-fips-ecp-2.0.12.tar.gz 
tar xzf ios-incore-2.0.1.tar.gz
cp -R openssl-fips-2.0.1/ openssl-fips-ecp-2.0.12/
rm -rf openssl-fips-2.0.1/

# setup environment
. ./setenv-reset.sh
. ./setenv-darwin-i386.sh

# verify paths set by darwin script
env

# move to fips' dir
cd openssl-fips-ecp-2.0.12

# configure and make
./config
make

# move to incore's dir and make
cd iOS/
make

# install /usr/local/bin
cp ./incore_macho /usr/local/bin
