#----------------------------------------------------------------------
#
# Build iOS FIPS module and library
#

LOGFILE=FIPS_build.log
RETURN_CODE=0

#----------------------------------------------------------------------
echo "Step 1 remove quarantine"
#----------------------------------------------------------------------
./step1_remove_Quarantine.sh 1>$LOGFILE 2>&1
#----------------------------------------------------------------------
echo "Step 2 build and install Incore Utility"
#----------------------------------------------------------------------
./step2_build_Incore_utility.sh 1>>$LOGFILE 2>&1
#----------------------------------------------------------------------
echo "Step 3 build FIPS Object Module"
#----------------------------------------------------------------------
./step3_build_FIPS_module.sh 1>>$LOGFILE 2>&1
if [ $? -eq 0 ] ; then
  RETURN_CODE=0
else
  echo "\t***error***"
  RETURN_CODE=1
fi

if [ "$RETURN_CODE" -eq "0" ] ; then
#----------------------------------------------------------------------
echo "Step 4 install FIPS Object Module (/usr/local/ssl/Release-iphoneos/)"
#----------------------------------------------------------------------
./step4_install_FIPS_module.sh 1>>$LOGFILE 2>&1

	if [ $? -eq 0 ] ; then
	  RETURN_CODE=0
	else
	  echo "\t***error***"
	  RETURN_CODE=1
	fi
fi

if [ "$RETURN_CODE" -eq "0" ] ; then
#----------------------------------------------------------------------
echo "Step 5 build FIPS Capable library"
#----------------------------------------------------------------------
	



if [ $RETURN_CODE -eq 0 ] ; then
	echo "\t* Arch armv7..."
	./step5_build_FIPS_capable_library.sh armv7 1>>$LOGFILE 2>&1
	
	if [ $? -ne 0 ] ; then
		echo "\t***error***"
	  RETURN_CODE=1
	fi
fi

if [ $RETURN_CODE -eq 0 ] ; then
	echo "\t* Arch arm64..."
	./step5_build_FIPS_capable_library.sh arm64 1>>$LOGFILE 2>&1

	if [ $? -ne 0 ] ; then
		echo "\t***error***"
	  RETURN_CODE=1
	fi
fi

if [ "$RETURN_CODE" -eq "0" ] ; then
	echo "\t* Arch armv7s..."
	./step5_build_FIPS_capable_library.sh armv7s 1>>$LOGFILE 2>&1
	
	if [ $? -ne 0 ] ; then
		echo "\t***error***"
	  RETURN_CODE=1
	fi
fi

if [ $RETURN_CODE -eq 0 ] ; then
	echo "\t* Arch x86_64..."
	./step5_build_FIPS_capable_library.sh x86_64 1>>$LOGFILE 2>&1
	
	if [ $? -ne 0 ] ; then
		echo "\t***error***"
	  RETURN_CODE=1
	fi
fi

if [ "$RETURN_CODE" -eq "0" ] ; then
	echo "\tDone building archs"
  RETURN_CODE=0

fi

fi

if [ "$RETURN_CODE" -eq "0" ] ; then
#----------------------------------------------------------------------
echo "Step 6 install FIPS Capable library (/usr/local/ssl/Release-iphoneos/)"
#----------------------------------------------------------------------
./step6_install_FIPS_capable_library.sh 1>>$LOGFILE 2>&1

	if [ $? -ne 0 ] ; then
	  echo "\t***error***"
	fi
fi