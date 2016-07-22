#---------------------------------------------------------
# install FIPS Object Module
#
# /usr/local/ssl/Release-iphoneos/
#---------------------------------------------------------

# move to Source dir
cd Source

# move to fips' dir
cd openssl-fips-ecp-2.0.12

# install - may require root...
make install

# delete artifacts
rm -Rf openssl-fips-ecp-2.0.12/
