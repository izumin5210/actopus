gulp        = require('gulp')
$           = require('gulp-load-plugins')(rename: {'gulp-rev-rails-manifest': 'manifest'})

browserify  = require('browserify')
source      = require('vinyl-source-stream')


#### browserify --------------------------------
getBundler = (opts) ->
  browserify
    entries: ['./app/assets/javascripts/application.js.coffee']
    extensions: ['.coffee']
    transform: ['coffeeify']

bundle = (opts) ->
  getBundler(opts)
    .bundle()
    .pipe(source('bundle.js'))
    .pipe($.streamify($.rev()))
    .pipe(gulp.dest('public/assets'))
    .pipe($.manifest())
    .pipe(gulp.dest('public/assets'))

gulp.task('browserify', bundle)
