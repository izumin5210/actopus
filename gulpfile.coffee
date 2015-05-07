gulp        = require('gulp')
$           = require('gulp-load-plugins')(rename: {'gulp-rev-rails-manifest': 'manifest'})

browserify  = require('browserify')
watchify    = require('watchify')
source      = require('vinyl-source-stream')

environment = process.env['ENV'] || 'development'
minify = (environment == 'production')


#### browserify --------------------------------
getBundler = (opts) ->
  bundler = browserify
    entries: ['./app/assets/javascripts/application.js.coffee']
    extensions: ['.coffee']
    transform: ['coffeeify']
  if opts? && opts.watch
    watchify(bundler).on('update', -> bundle(opts))
  else
    bundler

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
gulp.task('watchify', ->
  bundle(watch: true)
)
