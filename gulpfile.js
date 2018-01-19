
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
  gulp.watch('css/**/*.scss', ['sass']); 
  gulp.watch('js/**/*.js', ['js']); 
  gulp.watch('ulpoads/**/*.{png,jpg,gif}', ['img']); 
});

// ADDITIONAL TASKS
gulp.task('live-build', ['full-build', 'watch', 'browser-sync']);
gulp.task('light-build', ['sass', 'js']);
gulp.task('full-build', ['sass', 'js', 'img']);
