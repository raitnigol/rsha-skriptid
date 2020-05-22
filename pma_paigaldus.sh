#!/bin/bash

#kontrollime, kas phpmyadmin on juba masinasse paigaldatud
pma=$(dpkg-query -W -f='${Status}' phpmyadmin 2>/dev/null | grep -c 'ok installed')

#kui phpmyadmin pole paigaldatud, siis paigaldame selle
if [ $pma -eq 0 ]; then
	#paigaldame phpmyadmini
	echo "Paigaldame phpmyadmini"
	apt install phpmyadmin -y
	echo "phpmyadmin on paigaldatud."

#kui phpmyadmin on juba paigaldatud
elif [ $pma -eq 1 ]; then
	echo "phpmyadmin on juba paigaldatud"
#lopetame tingimuslause
fi

#skripti lopp
