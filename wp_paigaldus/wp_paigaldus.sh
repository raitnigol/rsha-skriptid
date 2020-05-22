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
			tar xzvf latest.tar.gz
			cp $wp_folder/wp-config-sample.php $wp_folder/wp-config.php
			cp -r $wp_folder /var/www/html
			echo "Wordpressi arhiiv on alla laetud."
			echo "$wp_folder liigutatud asukohta /var/www/html/wordpress"
		fi
	else
		#wordpressi kaust on olemas asukohas $currentdir/wordpress
		echo "antud asukohas eksisteerib juba wordpress kaust."
	fi
else
	#wordpressi kaust juba asub /var/www/html kaustas
	echo "wordpressi kaust juba eksisteerib asukohas /var/www/html."
fi
