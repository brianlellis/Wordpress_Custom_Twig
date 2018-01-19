#!/bin/sh

if ! type gulp > /dev/null ; then
	npm install gulp-cli -g
	npm install gulp -D
fi

#ADD package.json
echo "
{ 
	\"name\": \"brianellis-customwp\", 
	\"version\": \"1.0.0\", 
	\"description\": \"\", 
	\"main\": \"index.js\", 
	\"scripts\": {
	\"test\": \"echo \\\"Error: no test specified\\\" && exit 1\" 
},
	\"author\": \"\", 
	\"license\": \"ISC\",
	\"devDependencies\": {
		\"browser-sync\": \"^2.23.5\",
		\"gulp\": \"^3.9.1\",
		\"gulp-concat\": \"^2.6.1\",
		\"gulp-imagemin\": \"^4.1.0\",
		\"gulp-jshint\": \"^2.1.0\",
		\"gulp-notify\": \"^3.2.0\",
		\"gulp-plumber\": \"^1.2.0\",
		\"gulp-sass\": \"^3.1.0\",
		\"jshint\": \"^2.9.5\"
	}
}" >> package.json 

#ADD gulpfile.js
echo "
var gulp = require('gulp'),
	sass = require('gulp-sass'),
	jshint = require('gulp-jshint'),
	imagemin = require('gulp-imagemin'),
	concat = require('gulp-concat'),
	plumber = require('gulp-plumber'),
	notify = require('gulp-notify'),
	browserSync = require('browser-sync').create();
 
gulp.task('default', function(){ 
    console.log('default gulp task...')
});

// ERROR HANDLING
var plumberErrorHandler = { errorHandler: notify.onError({ 
    title: 'Gulp', 
    message: 'Error: <%= error.message %>' 
  }) 
};

// CSS COMPILATION
gulp.task('sass', function () {
    gulp.src('./css/**/*.scss')
    	.pipe(plumber(plumberErrorHandler))
        .pipe(sass())
        .pipe(gulp.dest('./theme/'));
});
 

// JS COMPILATION
gulp.task('js', function () { 
	gulp.src('js/src/*.js')
		.pipe(jshint()) 
		.pipe(jshint.reporter('fail'))
		.pipe(concat('theme.js'))
		.pipe(gulp.dest('js'));
});

// Image Minification
gulp.task('img', function() {
  gulp.src('img/src/*.{png,jpg,gif}')
    	.pipe(imagemin({
      		optimizationLevel: 7,
      		progressive: true
    	}))
    	.pipe(gulp.dest('img'))
});

// Browser Sync 
gulp.task('browser-sync', function() {
    browserSync.init({
        proxy: 'localhost:8888'
    });
});

gulp.task('watch', function() { 
  gulp.watch('css/src/*.scss', ['sass']); 
  gulp.watch('js/src/*.js', ['js']); 
  gulp.watch('img/src/*.{png,jpg,gif}', ['img']); 
});

// ADDITIONAL TASKS
gulp.task('live-build', ['full-build', 'watch', 'browser-sync']);
gulp.task('light-build', ['sass', 'js']);
gulp.task('full-build', ['sass', 'js', 'img']);" >> gulpfile.js

#INSTALL THE NPM PACKAGES
npm install

#MAKE SRC BUILD APP DIR
if [ -d "./css" ]; then
	echo "CSS is already set up!"
else
	mkdir css 
	#Apply 7-1 SASS Architecture 
	cd css
	wget https://github.com/HugoGiraudel/sass-boilerplate/archive/master.zip
	unzip master.zip && rm master.zip
	mv sass-boilerplate-master/stylesheets/* ./
	rm -r sass-boilerplate-master
	mv main.scss style.scss
fi

if [ -d "./js" ]; then
	echo "JS is already set up!"
else
	mkdir js
fi