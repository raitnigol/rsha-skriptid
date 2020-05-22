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
[ -f "$wp_archive" ]
wpa_result=$?
if [ $wpa_result -eq 0 ]; then
	#fail eksisteerib, pole uuesti vaja alla laadida
	echo "Fail latest.tar.gz eksisteerib juba, jatan vahele"
else
	#faili ei eksisteeri, laeme alla
	wget https://wordpress.org/latest.tar.gz
fi

if [ -d "$wp_folder" ]; then
	#Kaust on minema liigutatud antud asukohast
	echo "Kaust wordpress juba eksisteerib."
elif [ -d "$apache_wp_folder" ]; then
	# wordpress kaust eksisteerib juba /var/www/html-is
	echo "Kaust wordpress juba eksisteerib asukohas /var/www/html"
else
	#pakime arhiivi lahti
	tar xzvf latest.tar.gz
	cp $wp_folder/wp-config-sample.php $wp_folder/wp-config.php
	cp -r $wp_folder /var/www/html/
fi
