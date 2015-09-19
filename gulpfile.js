var gulp = require('gulp');
var gutil = require('gulp-util');
var order = require('gulp-order');
var concat = require('gulp-concat');

var paths = {
  coffee: ['src/**/*.coffee'],
  sass: ['src/**/*.sass'],
  html: ['src/**/*.html'],
  icons: ['src/**/*.svg'],
  vendor: {
    icons: [
      './bower_components/material-design-icons/communication/svg/production/contact_mail_48px.svg',
      { group: 'notification', icon: 'ic_adb_48px.svg' }
    ],
    js: [
      './bower_components/angular/angular.js',
      './bower_components/angular-animate/angular-animate.js',
      './bower_components/angular-aria/angular-aria.js',
      './bower_components/angular-material/angular-material.js'
    ],
    css: [
      './bower_components/angular-material/angular-material.css'
    ]
  },
  output: './build/',
  outputSvg: 'assets/svg/'
};

paths.vendor.icons = paths.vendor.icons.map(function (obj) {
  if (typeof(obj) === 'string') {
    return obj;
  } else {
    return './bower_components/material-design-icons/' + obj.group + '/svg/production/' + obj.icon;
  }
});

var coffee = require('gulp-coffee');
gulp.task('coffee', function () {
  gulp.src(paths.coffee)
    .pipe(coffee({bare: true})
    .on('error', gutil.log))
    .pipe(gulp.dest(paths.output));
});

gulp.task('vendor', function () {
  gulp.src(paths.vendor.js)
    .pipe(concat('vendor.js'))
    .pipe(gulp.dest(paths.output));

  gulp.src(paths.vendor.css)
    .pipe(concat('vendor.css'))
    .pipe(gulp.dest(paths.output));

  gulp.src(paths.vendor.icons)
    .pipe(gulp.dest(paths.output + paths.outputSvg))

  gulp.src(paths.icons)
    .pipe(gulp.dest(paths.output))
})

var sass = require('gulp-sass');
gulp.task('sass', function () {
  gulp.src(paths.sass)
    .pipe(sass().on('error', sass.logError))
    .pipe(gulp.dest(paths.output));
});

processhtml = require('gulp-processhtml')
gulp.task('html', function () {
  return gulp.src(paths.html)
    .pipe(processhtml({}))
    .pipe(gulp.dest(paths.output));
});

gulp.task('watch', function() {
  gulp.watch(paths.coffee, ['coffee']);
  gulp.watch(paths.sass, ['sass']);
  gulp.watch(paths.html, ['html']);
});

gulp.task('dev', ['vendor', 'sass', 'coffee', 'html', 'watch']);

gulp.task('default', ['dev']);
