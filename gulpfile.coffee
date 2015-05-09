gulp        = require('gulp')
$           = require('gulp-load-plugins')()

browserify  = require('browserify')
watchify    = require('watchify')
source      = require('vinyl-source-stream')

browserSync = require('browser-sync')
runSequence = require('run-sequence')

environment = process.env['ENV'] || 'development'
isProduction = (environment == 'production')


#### browserify --------------------------------
getBundler = (opts) ->
  browserifyOpts =
    entries: ['./app/assets/javascripts/application.js.coffee']
    extensions: ['.coffee', '.ts']

  bundler = browserify(browserifyOpts)
    .transform('coffeeify')
    .plugin('tsify', { noImplicitAny: true })

  if opts? && opts.watch
    watchify(bundler).on('update', -> bundle(opts))
  else
    bundler

bundle = (opts) ->
  getBundler(opts)
    .bundle()
    .on('error', $.util.log)
    .pipe(source('bundle.js'))
    .pipe($.if(isProduction, $.streamify($.uglify())))
    .pipe($.streamify($.size(title: 'scripts')))
    .pipe(gulp.dest(if isProduction then 'public/assets' else 'public/javascripts'))

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
