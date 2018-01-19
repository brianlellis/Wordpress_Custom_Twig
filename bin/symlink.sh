#!/bin/sh
if [ -d "./theme" ]; then
	echo "Since you already have a theme let's remove the custom one from Timber"
	rm -r wp/wp-content/themes/customtheme
else
	mv wp/wp-content/themes/customtheme theme
fi


#FULL THEME
cd wp/wp-content/themes
ln -s ../../../theme customtheme && cd ../../../theme

#CSS
ln -s ../css ./css

#JS
ln -s ../js ./js

cd ..