require! {
  gulp
  path
  browserify
  liveify
  watchify

  envify: 'envify/custom'
  source: 'vinyl-source-stream'

  util: 'gulp-util'
  plumber: 'gulp-plumber'
  sourcemaps: 'gulp-sourcemaps'
  concat: 'gulp-concat'
  rename: 'gulp-rename'
  streamify: 'gulp-streamify'
}

build = "build"
src = "./src"
paths =
  source: "src"
  build: "build"

production = process.env.NODE_ENV is "production"
gulp.task "copy", !->
  gulp.src(src + "/index.html").pipe gulp.dest(build)

gulp.task "browserify-watch", ->
  rebundle = ->
    bundler.bundle().on("error", util.log).pipe(source("app.js")).pipe gulp.dest("./build")

  bundler = watchify(browserify("./src/ls/index.ls", watchify.args))

  bundler.transform liveify
  bundler.transform envify(NODE_ENV: "development")

  bundler.on "update", rebundle
  rebundle!

gulp.task "browserify", ->
  bundleMethod = (if global.isWatching then watchify else browserify)
  bundler = bundleMethod(

    # Specify the entry point of your app
    entries: ["./src/ls/index.ls"]

    # Add file extentions to make optional in your requires
    extensions: [".ls"]
    debug: false
  )
  bundle = ->

    # Report compile errors

    # Specify the output destination
    bundler.transform(liveify).transform(envify(NODE_ENV: "production")).bundle().on("error", util.log).pipe(source("app.js")).pipe(gulp.dest(build)).pipe(rename("app.min.js")).pipe(streamify(uglify())).pipe gulp.dest(build)

  bundler.on "update", bundle  if global.isWatching
  bundle()

gulp.task "watch", ->
  global.isWatching = true
  gulp.start "browserify-watch"
  gulp.watch "src/index.html", ["copy"]
  return

gulp.task "default", [
  "copy"
  "watch"
]
gulp.task "build", [
  "copy"
  "browserify"
]
