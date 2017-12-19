#!/bin/bash

# ================== INSTALL  ==================
# Create a secret file : secret.env with following element
# personalize marker < ... > 
# #Destination folder with filename to the tv guide file
# TVGUIDE="<full path th tvguide.xml>"
#
# ================== /INSTALL  ==================

# === Temporary tvguide file ===
TMP_FOLDER="/tmp/tvguide.$$"
WORKING="tvguide.xml"

# === Main ===

#load secret
secret=$(cat secret.env)
eval "$secret"

mkdir ${TMP_FOLDER}; cd ${TMP_FOLDER}

URL='http://www.xmltv.fr/guide/tvguide.zip'
wget -q $URL
if [ $? -ne 0 ]; then
	echo "erreur de telechargement"
	exit 2
fi

unzip tvguide.zip

sed -i '/id="TF12.kazer.org"/,+2d'   			${WORKING}
sed -i 's=France Ô=FRANCE O=g' 		 			${WORKING}
sed -i 's=TF12.kazer.org=TF11.kazer.org=g' 		${WORKING}

#Final copy
mv ${WORKING} ${TVGUIDE}

#Final clean
rm -rf ${TMP_FOLDER}