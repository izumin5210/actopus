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
  )

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


#### TypeScript --------------------------------
gulp.task('build:ts', $.shell.task([
  '$(npm bin)/tsc'
]))

gulp.task('build:ts:watch', $.shell.task([
  '$(npm bin)/tsc --watch'
]))


#### template --------------------------------
gulp.task('build:template', ->
  gulp.src('./ui/assets/templates/**/*.html')
    .pipe($.angularTemplatecache(module: 'actopus'))
    .pipe($.size(title: 'templates'))
    .pipe(gulp.dest('./tmp/assets/javascripts'))
)


#### dtsm --------------------------------
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


#### test --------------------------------
gulp.task('test', ['build'], $.shell.task([
  './node_modules/karma/bin/karma start karma.conf.js'
]))


#### build --------------------------------
gulp.task('watch', ['build', 'browser-sync', 'watchify'], ->
  gulp.watch('./public/{asset,javascript}s/**/*.js', ['bs-reload'])
  gulp.watch('./ui/assets/templates/**/*.html', ['build:template'])
  gulp.watch('./ui/assets/javascripts/**/*.ts', ['build:ts'])
)

gulp.task('build', (callback) ->
  if isProduction
    runSequence('build:ts', 'build:template', 'browserify', 'rev', callback)
  else
    runSequence('build:ts', 'build:template', 'browserify', callback)
)

gulp.task('rev', ->
  gulp.src(['public/assets/**/*.js'])
    .pipe($.rev())
    .pipe(gulp.dest('public/assets'))
    .pipe($.revRailsManifest())
    .pipe(gulp.dest('public/assets'))
)
