#!/usr/bin/env bash

#SET UP WP WITH COMPOSER AND MV FILES AS NEEDED
composer install && mv wp/wp-core/wp-content wp/wp-content #&& mv wp/wp-core/wp-config-sample.php wp/wp-config.php

#CREATE WP-CONFIG IN CORE TO INCLUDE THE OUTER WP-CONFIG
#touch wp/wp-core/wp-config.php && printf "<?php\ninclude('../wp-config.php');" >> wp/wp-core/wp-config.php

#EDIT WP-CONFIG WITH DEFINED OUT DIRs PREV MV
printf "\n//DEFINE ABSTRACTED ASSET PATHS\ndefine( 'WP_CONTENT_DIR', dirname(__FILE__) . '../wp-content' );" >> wp/wp-core/wp-config-sample.php