#!/bin/bash
# saame kasutaja praeguse asukoha
currentdir=$(pwd)
# saame skriptid folderi
skriptid=$currentdir/skriptid
# paigaldame skriptid /skriptid kaustast vastavas jarjekorras
sh $skriptid/apache_paigaldus.sh
sh $skriptid/php_paigaldus.sh
sh $skriptid/mysql_paigaldus.sh
sh $skriptid/pma_paigaldus.sh

#seejarel paigaldame wordpressi
#kontrolli, kas juba eksisteerib latest.tar.gz arhiiv
#samuti kontrollime, kas kaust wordpress juba eksisteerib
wp_archive=$currentdir/latest.tar.gz
wp_folder=$currentdir/wordpress
apache_wp_folder=/var/www/html/wordpress

if [ ! -d $apache_wp_folder ]; then
	#kontrolli, kas wordpressi kaust on olemas asukohas $currentdir/wordpress
	if [ ! -d $wp_folder ]; then
		#kontrolli, kas arhiiv on olemas
		if [ -f $wp_archive ]; then
			#arhiiv on olemas
			echo "arhiivi latest.tar.gz juba eksisteerib"
		else
			wget https://wordpress.org/latest.tar.gz
			tar xzf latest.tar.gz
			cp $wp_folder/wp-config-sample.php $wp_folder/wp-config.php
		fi
	else
		#wordpressi kaust on olemas asukohas $currentdir/wordpress
		echo "antud asukohas eksisteerib juba wordpress kaust."
	fi
else
	#wordpressi kaust juba asub /var/www/html kaustas
	echo "wordpressi kaust juba eksisteerib asukohas /var/www/html."
fi

# muudame wp-config.php failis andmed umber
wp_config=$wp_folder/wp-config.php
db_array=('database_name_here' 'username_here' 'password_here')
value_array=('wordpress' 'wordpressuser' 'qwerty')

for index in ${!db_array[*]}; do
	sed -i "s/${db_array[$index]}/${value_array[$index]}/g" $wp_config
done

# teeme andmebaasi wordpress
mysql <<EOF
CREATE DATABASE wordpress;
CREATE USER 'wordpressuser'@'localhost' IDENTIFIED BY 'qwerty';
GRANT ALL PRIVILEGES ON wordpress.* TO 'wordpressuser'@'localhost';
FLUSH PRIVILEGES;
EOF

# liigutame wordpressi failid oigesse asukohta ja kustutame arhiivi
rm $currentdir/latest.tar.gz
echo "Wordpressi arhiiv eemaldatud."
cp -r $wp_folder /var/www/html
echo "$wp_folder kopeeritud asukohta /var/www/html"
rm -rf $wp_folder
echo "eemaldatud wordpressi kaust."

ip_addr=$(ip route get 8.8.8.8 | sed -n '/src/{s/.*src *\([^ ]*\).*/\1/p;q}')
