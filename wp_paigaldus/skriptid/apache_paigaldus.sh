#!/bin/bash



#skript apache paigaldamiseks

#leiame, kas apache2 on paigaldatud



apache2=$(dpkg-query -W -f='${Status}' apache2 2>/dev/null | grep -c 'ok installed')



# käivita käsud, kui apache2 muutuja väärtus on 0 ehk apachet pole paigaldatud

if [ $apache2 -eq 0 ]; then

	#apachet pole paigaldatud, paigaldame selle

	echo "Paigaldame teenuse apache2."

	apt install apache2 -y

	echo "Apache2 on edukalt paigaldatud."

# juhul kui apache2 on juba paigaldatud

elif [ $apache2 -eq 1 ]; then

	# apache2 on paigaldatud

	echo "Teenus apache2 on juba paigaldatud."

	# käivitame selle ja kuvame kasutajale staatuse

	service apache2 start

	service apache2 status

fi

#skripti lopp
