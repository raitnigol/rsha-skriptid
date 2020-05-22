#!/bin/bash
#mysql-paigaldus.sh skript

#vaatame, kas mysql on masinasse paigaldatud
mysql=$(dpkg-query -W -f='${Status}' mysql-server 2>/dev/null | grep -c 'ok installed')

#kui mysqli pole paigaldatud
if [ $mysql -eq 0 ]; then
	#paigaldame mysqli
	echo "Paigaldame mysqli koos vajalike lisadega"
	apt install mysql-server -y
	echo "mysql server on paigaldatud."
	# voimalus sqli kasutada ilma parooli ja kasutaja lisamiseta
	touch $HOME/.my.cnf #konfiguratsioonifail skripti k2ivitaja kodukausta
	echo "[client]" >> $HOME/.my.cnf
	echo "host = localhost" >> $HOME/.my.cnf
	echo "user = root" >> $HOME/.my.cnf
	echo "password = qwerty" >> $HOME/.my.cnf

#kui mysql on juba paigaldatud
elif [ $mysql -eq 1 ]; then
	# teenus on juba paigaldatud
	echo "mysql-server on juba paigalatud"
	# kontrollime  olemasolu
	mysql
# lopetame tingimuslause
fi

#skripti lopp
