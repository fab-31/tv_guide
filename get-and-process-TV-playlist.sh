#!/bin/sh
# ================== INSTALL  ==================
# Create a secret file : secret.env with following element
# (personalize marker < ... >
# #Full URL to your tv list
# URL_RAW_PLAYLIST_TV="<your url tvguide>"
# #Destination folder with filename to the TV playlist
# TARGET="<full path th playlist>"
#
# ================== /INSTALL  ==================

# === Temporary tvguide file ===
TMP_FOLDER="/tmp/tvguide.$$"
WORKING_FILE="TV.m3u"
WORKING_FILELOGO="${TMP_FOLDER}/TV_with-logo.m3u"

# === Functions ===

# === Main ===

#load secret
FOLDER_SECRET="$(dirname $0)"
secret=$(cat ${FOLDER_SECRET}/secret.env)
eval "$secret"

#create tempary
mkdir ${TMP_FOLDER}; cd ${TMP_FOLDER}
> ${WORKING_FILELOGO}

echo "Get TV List"
wget -q "${URL_RAW_PLAYLIST_TV}" -O ${WORKING_FILE}
dos2unix -q ${WORKING_FILE}

echo "filter"
#Suppression des chaines
	sed -i '/AR./,+1d'         				        	${WORKING_FILE}
	sed -i '/|IT|/,+1d'        		    	        	${WORKING_FILE}
	sed -i '/#EXTINF:-1,IT|/,+1d'          	        	${WORKING_FILE}
	sed -i '/|PT|/,+1d'          					 	${WORKING_FILE}
	sed -i '/#EXTINF:-1,PT|/,+1d'          		 		${WORKING_FILE}
	sed -i '/|BE|/,+1d'         						${WORKING_FILE}
	sed -i '/|ES|/,+1d'         						${WORKING_FILE}
	sed -i '/-----------/,+1d'  						${WORKING_FILE}
	sed -i '/|SUI|/,+1d'          						${WORKING_FILE}
	sed -i '/xXx/,+1d'          						${WORKING_FILE}
	sed -i '/TOONAMI/,+1d'      						${WORKING_FILE}
	sed -i '/CARTOON/,+1d'      						${WORKING_FILE}
	sed -i '/TELETOON/,+1d'      						${WORKING_FILE}
	sed -i '/ZOUZOU/,+1d'       						${WORKING_FILE}
	sed -i '/golf/,+1d'          						${WORKING_FILE}
	sed -i '/NICKELODEON/,+1d'      					${WORKING_FILE}
	sed -i '/DISNEY/,+1d'      					 		${WORKING_FILE}
	sed -i '/PIWI/,+1d'      						 	${WORKING_FILE}
	sed -i '/golf/,+1d'      						 	${WORKING_FILE}
	sed -i '/BOOMERANG/,+1d'     					 	${WORKING_FILE}
	sed -i '/BOING/,+1d'      						 	${WORKING_FILE}
	sed -i '/TIJI/,+1d'      						 	${WORKING_FILE}
	sed -i '/GULLI/,+1d'      						 	${WORKING_FILE}
	sed -i '/WEO/,+1d'      						 	${WORKING_FILE}
	sed -i '/CANAL J/,+1d'     					 		${WORKING_FILE}
	sed -i '/FHD$/,+1d'         					 	${WORKING_FILE}
	sed -i '/BEIN /,+1d'         					 	${WORKING_FILE}
	sed -i '/SFR /,+1d'         					 	${WORKING_FILE}
	sed -i '/FOOT+ /,+1d'         					 	${WORKING_FILE}
	sed -i '/EQUIDIA/,+1d'         				 		${WORKING_FILE}
	sed -i '/^#EXTINF:-1,|FR| CANAL+  HD$/,+1d'     	${WORKING_FILE}
	sed -i '/^#EXTINF:-1,FR| CANAL+ CINEMA$/,+1d'   	${WORKING_FILE}
	sed -i '/^#EXTINF:-1,|FR| CANAL+ SERIE$/,+1d'   	${WORKING_FILE}
	sed -i '/^#EXTINF:-1,|FR| CANAL+ FAMILY$/,+1d'  	${WORKING_FILE}
	sed -i '/^#EXTINF:-1,|FR| CANAL+ DECALE$/,+1d'  	${WORKING_FILE}
	sed -i '/^#EXTINF:-1,|FR| CINE+  PREMIER$/,+1d' 	${WORKING_FILE}
	sed -i '/^#EXTINF:-1,|FR| GOLF+ HD$/,+1d'     		${WORKING_FILE}
	sed -i 's/HD$//' 							     	${WORKING_FILE}
	sed -i 's/FRANCE/France/' 							${WORKING_FILE}
	sed -i 's/CANAL/Canal/' 							${WORKING_FILE}
	sed -i 's/^#EXTINF:-1,|FR| /#EXTINF:-1,/' 	   	    ${WORKING_FILE}
	
#ajout des logos	
cat ${WORKING_FILE}|while read line
do
	echo $line|grep -v "VOD"|grep -e '^#EXTINF' >/dev/null
	if [ $? -eq 0 ]; then
		chaine="$(echo $line|cut -d',' -f2)"
		chaine_lower="$(echo ${chaine}|tr '[:upper:]' '[:lower:]')"
        echo "$(echo $line|cut -d',' -f1) tvg-logo=\"${chaine_lower}.png\", ${chaine}" >> ${WORKING_FILELOGO}
	else
		echo ${line} >> ${WORKING_FILELOGO}
	fi
done

#Un peu de nettyage
sed -i 's/ *$//' ${WORKING_FILELOGO}
sed -i 's/  / /' ${WORKING_FILELOGO}
sed -i 's/, /,/' ${WORKING_FILELOGO}

#Final copy
mv ${WORKING_FILELOGO} ${TARGET}

#Final clean
rm -rf ${TMP_FOLDER}
