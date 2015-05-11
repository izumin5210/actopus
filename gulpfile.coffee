gulp        = require('gulp')
$           = require('gulp-load-plugins')()

browserify  = require('browserify')
watchify    = require('watchify')
source      = require('vinyl-source-stream')

browserSync = require('browser-sync')
runSequence = require('run-sequence')

pkg         = require('./package.json')

environment = process.env['ENV'] || 'development'
isProduction = (environment == 'production')


#### browserify --------------------------------
getBundler = (opts) ->
  bundler = browserify(
    entries: pkg.browserify.entries
    extensions: pkg.browserify.extensions
    transform: pkg.browserify.transform
  )

  for p in pkg.browserify.plugins
    if typeof p == "object"
      for k, v of p
        bundler = bundler.plugin(k, v)
    else
      bundler = bundler.plugin(p)

  if opts? && opts.watch
    watchify(bundler)
  else
    bundler

bundle = (opts) ->
  bundler = getBundler(opts)

  rebundle = ->
    bundler.bundle()
      .on('error', $.util.log)
      .pipe(source('bundle.js'))
      .pipe($.if(isProduction, $.streamify($.uglify())))
      .pipe($.streamify($.size(title: 'scripts')))
      .pipe(gulp.dest(if isProduction then 'public/assets' else 'public/javascripts'))

  bundler = bundler.on('update', rebundle) if opts? && opts.watch

  rebundle()

gulp.task('browserify', bundle)
gulp.task('watchify', ->
  bundle(watch: true)
)

gulp.task('rev', ->
  gulp.src(['public/assets/**/*.js'])
    .pipe($.rev())
    .pipe(gulp.dest('public/assets'))
    .pipe($.revRailsManifest())
    .pipe(gulp.dest('public/assets'))
)


#### browserSync --------------------------------
gulp.task('dtsm', ->
  gulp.src('./dtsm.json')
    .pipe($.dtsm())
)

gulp.task('dtsm:test', ->
  gulp.src('./dtsm.test.json')
    .pipe($.dtsm())
)


#### browserSync --------------------------------
gulp.task('browser-sync', ->
  browserSync
    proxy: 'http://localhost:3000'
)

gulp.task('bs-reload', browserSync.reload)

gulp.task('watch', ['browser-sync', 'watchify'], ->
    gulp.watch(['public/{asset,javascript}s/**/*.js'], ['bs-reload'])
)

gulp.task('build', (callback) ->
  runSequence('browserify', 'rev', callback)
)
