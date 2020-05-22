#!/bin/sh
#php paigaldusskript

#kontrollime, kas php7.0 on masinasse paigaldatud
php=$(dpkg-query -W -f='${Status}' php7.0 2>/dev/null | grep -c 'ok installed')
# kui php pole masinasse paigaldatud
if [ $php -eq 0 ]; then
	# ok installed puudub
	# paigaldame teenuse
	echo "Paigaldame php ja vajalikud lisad"
	apt install php7.0 libapache2-mod-php7.0 php7.0-mysql -y
	echo "php on paigaldatud"
# kui php on juba paigaldatud
elif [ $php -eq 1 ]; then
	# ok installed on juba olemas
	echo "php on juba paigaldatud"
	# kontrollime olemasolu
	which php
# lopetame tingimuslause
fi
#skripti lopp
