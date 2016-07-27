#---------------------------------------------------------
# remove quarantine bit and ensure the execute bit is set
#---------------------------------------------------------

# move to Source dir
cd Source

xattr -r -d "com.apple.quarantine" *.tar *.gz
xattr -r -d "com.apple.quarantine" *.sh
chmod +x *.sh