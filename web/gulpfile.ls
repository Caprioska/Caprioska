gulp = require("gulp")
path = require("path")
source = require("vinyl-source-stream")
browserify = require("browserify")
liveify = require("liveify")
watchify = require("watchify")
util = require("gulp-util")
plumber = require("gulp-plumber")
sourcemaps = require("gulp-sourcemaps")
concat = require("gulp-concat")
rename = require("gulp-rename")
streamify = require("gulp-streamify")
envify = require("envify/custom")

require! {
  gulp
  path
  browserify
  liveify
  watchify
  util: 'gulp-util'
  plumber: 'gulp-plumber'
  sourcemaps: 'gulp-sourcemaps'
  concat: 'gulp-concat'
  rename: "gulp-rename"
  streamify: "gulp-streamify"
  envify: "envify/custom"
}
build = "build"
src = "./src"
paths =
  source: "src"
  build: "build"

production = process.env.NODE_ENV is "production"
gulp.task "copy", ->

  # Copy html
  gulp.src(src + "/index.html").pipe gulp.dest(build)
  return

gulp.task "browserify-watch", ->
  rebundle = ->
    bundler.bundle().on("error", util.log).pipe(source("app.js")).pipe gulp.dest("./build")
  bundler = watchify(browserify("./src/scripts/index.ls", watchify.args))
  bundler.transform liveify
  bundler.transform envify(NODE_ENV: "development")
  bundler.on "update", rebundle
  rebundle()

gulp.task "browserify", ->
  bundleMethod = (if global.isWatching then watchify else browserify)
  bundler = bundleMethod(

    # Specify the entry point of your app
    entries: ["./src/scripts/index.ls"]

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
  "less"
  "watch"
  "browser-sync"
]
gulp.task "build", [
  "copy"
  "less"
  "browserify"
]
