# Wordpress_Custom_Twig
A Wordpress scaffolding theme with Gulp, Timber and Twig


## What has been customized?

 * Twig templating engine
 * Timber starter theme to support Twig
 * SASS 7-1 Architecture system
 * Gulp task runner
 * Symlink Abstraction for easy theme customization
 * Full automated scaffolding system from CLI
 * Extensive test sample data easily imported
 * WP-CLI dependency check
 
## Future TODOs

 * e2e testing with phpUnit and Mocha framework
 * Centralized custom plugin(s) dir to dynamically register in theme
 * Abstraction of admin template for easy customization
 
 # How to Start
 
 __You do not need any files or directories for this system to run except:__
  
  * /bin

These scripts will bring in the latest version of Wordpress and Timber into your local environment.

## Start the process

Simply navigate to the root dir of the repo and run:
```
./bin/scaffold.sh
```

If you have already customized the site or want to bring in a compliant CSS theme or JS assets that is fine. The scaffolder checks for CSS and JS dirs in the root install before creating new ones to allow for modular migrations and sharing of assets between multiple WP_Twig instances.

## Gotchas

### Make sure to have your apache instance and host set up to be able to install the WP instance before continuing in scaffold.sh

The file permissions and hardening of Wordpress are not required. You can choose __'n'__ for these. Use at your own caution as they create .htaccess files across multiple dirs and reset your file permission in order to make WP more secure.

### Why is package.json and gulpfile.js done in BASH?

I chose to write the FED asset scaffolding in BASH as this is strictly a starter/scaffolding system. If you don't want Gulp or the modules intended then remove the __frontend.sh__ call in __scaffold.sh__ or keep and then configure the files as needed for your repo. The goal was to keep the system as minimal as possible till executed.

# EASY GULP 

 * __gulp live-build__ Executes watch on img, js, sass files while also serving a local browser instance through proxy
 * __gulp light-build__ Compiles JS and CSS but does not minify images
 * __gulp full-build__ Compiles JS, CSS, and optimizes images in the system
