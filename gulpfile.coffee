gulp        = require('gulp')
$           = require('gulp-load-plugins')(rename: {'gulp-rev-rails-manifest': 'manifest'})

browserify  = require('browserify')
source      = require('vinyl-source-stream')

environment = process.env['ENV'] || 'development'
minify = (environment == 'production')


#### browserify --------------------------------
getBundler = (opts) ->
  browserify
    entries: ['./app/assets/javascripts/application.js.coffee']
    extensions: ['.coffee']
    transform: ['coffeeify']

bundle = (opts) ->
  getBundler(opts)
    .bundle()
    .on('error', $.util.log)
    .pipe(source('bundle.js'))
    .pipe($.if(minify, $.streamify($.uglify())))
    .pipe($.streamify($.rev()))
    .pipe($.streamify($.size(title: 'scripts')))
    .pipe(gulp.dest('public/assets'))
    .pipe($.manifest())
    .pipe(gulp.dest('public/assets'))

gulp.task('browserify', bundle)
