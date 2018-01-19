#!/usr/bin/env bash
mv wp/wp-content/themes/customtheme theme
cd wp/wp-content/themes

#FULL THEME
ln -s ../../../theme customtheme && cd ../../../theme

#CSS
ln -s ../css css

#JS
ln -s ../js js

cd ..