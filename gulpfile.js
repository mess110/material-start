var gulp = require('gulp');
var gutil = require('gulp-util');

var paths = {
  coffee: ['src/**/*.coffee'],
  sass: ['src/**/*.sass'],
  output: './app/'
};

var coffee = require('gulp-coffee');
gulp.task('coffee', function() {
  gulp.src(paths.coffee)
    .pipe(coffee({bare: true})
    .on('error', gutil.log))
    .pipe(gulp.dest(paths.output))
});

var sass = require('gulp-sass');
gulp.task('sass', function () {
  gulp.src(paths.sass)
    .pipe(sass().on('error', sass.logError))
    .pipe(gulp.dest(paths.output));
});

gulp.task('watch', function() {
  gulp.watch(paths.coffee, ['coffee']);
  gulp.watch(paths.sass, ['sass']);
});

gulp.task('default', ['watch']);
