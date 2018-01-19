#!/usr/bin/env bash
clear
echo "============================================"
echo "WordPress Install Script"
echo "============================================"

# echo "Database Name: " && read -e dbname
# echo "Database User: " && read -e dbuser
# echo "Database Password: " && read -s dbpass
# echo "run install? (y/n)" && read -e run

if [ "$run" == n ] ; then
	exit
else
	echo "============================================"
	echo "A robot is now installing WordPress for you."
	echo "============================================"

	#download wordpress
	curl -O https://wordpress.org/latest.tar.gz

	#unzip wordpress
	tar -zxvf latest.tar.gz

	#change dir to wordpress
	mkdir wp && mv wordpress wp/wp-core && cd wp/wp-core

	#create wp config
	cp wp-config-sample.php wp-config.php

	#set database details with perl find and replace
	perl -pi -e "s/database_name_here/$dbname/g" wp-config.php
	perl -pi -e "s/localhost/127.0.0.1/g" wp-config.php
	perl -pi -e "s/username_here/$dbuser/g" wp-config.php
	perl -pi -e "s/password_here/$dbpass/g" wp-config.php

	#set WP salts
	# perl -i -pe'
	#   BEGIN {
	#     @chars = ("a" .. "z", "A" .. "Z", 0 .. 9);
	#     push @chars, split //, "!@#$%^&*()-_ []{}<>~\`+=,.;:/?|";
	#     sub salt { join "", map $chars[ rand @chars ], 1 .. 64 }
	#   }
	#   s/put your unique phrase here/salt()/ge
	# ' wp-config.php

	#create uploads folder and set permissions
	# mkdir wp-content/uploads && chmod 775 wp-content/uploads && echo "Cleaning..."

	#remove zip file
	cd ../.. && rm latest.tar.gz

	#remove bash script
	echo "========================="
	echo "Installation is complete."
	echo "========================="
fi

#SET UP WP WITH COMPOSER AND MV FILES AS NEEDED
composer install #&& mv wp/wp-core/wp-content wp/wp-content && mv wp/wp-core/wp-config-sample.php wp/wp-config.php

#CREATE WP-CONFIG IN CORE TO INCLUDE THE OUTER WP-CONFIG
#touch wp/wp-core/wp-config.php && printf "<?php\ninclude('../wp-config.php');" >> wp/wp-core/wp-config.php

#EDIT WP-CONFIG WITH DEFINED OUT DIRs PREV MV
#printf "\n//DEFINE ABSTRACTED ASSET PATHS\ndefine( 'WP_CONTENT_DIR', dirname(__FILE__) . '../wp-content' );" >> wp/wp-core/wp-config-sample.php

#FIX FILE PERMISSIONS
find wp -type d -exec chmod 755 {} \;
find wp -type f -exec chmod 644 {} \;

#CHECK IF WP-CLI IS GLOBALLY ACCESSIBLE && IF NOT THEN INSTALL
if ! type wp > /dev/null ; then
		curl -O https://raw.githubusercontent.com/wp-cli/builds/gh-pages/phar/wp-cli.phar
		php wp-cli.phar --info
		chmod +x wp-cli.phar
		sudo mv wp-cli.phar /usr/local/bin/wp
		echo "Wordpress Command Line Tools is ready to go"
	else
		echo "Wordpress Command Line Tools already installed"
fi

#HARDEN WORDPRESS
cd wp/wp-core && mkdir wp-content/uploads && sudo ./../../bin/harden.sh

#FIX FILE PERMISSIONS SO ONLY WP-CONTENT/UPLOADS IS WRITABLE
sudo ./../../bin/perms.sh