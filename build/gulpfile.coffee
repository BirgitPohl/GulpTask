gulp          = require('gulp-param')(require('gulp'), process.argv)
browserSync   = require('browser-sync')#.create #call this before gulp
watch         = require 'gulp-watch'

#jshint       = require 'gulp-jshint' #shows mistakes in your JS file
coffee        = require 'gulp-coffee'
concat        = require 'gulp-concat'
gutil         = require 'gulp-util'
#gutil.log requires self defined logs: https://github.com/gulpjs/gulp-util
#color them with chalk
fs            = require 'fs'
chalk         = require 'chalk'
#Some chalk color definitions:
errorColor    = chalk.red
successColor  = chalk.green
detailsColor  = chalk.yellow

runSequence = require 'run-sequence'
clean = require 'gulp-clean'
isProd = gutil.env.type is 'prod'

##########################################
########## Sources & Targets #############
##########################################

sources =
  coffee: "" #"./build/test-Coffee/*.coffee" #todo doobido: put args here

targets =
  js: "" #"./build/test-JS/"


##########################################
############# Watching files #############
############# call functions #############
############ with gulp-params ############
##########################################

#gulp.task 'clean', ->
#  gulp.src(['./build/test-JS/'], {read: false}).pipe(clean())

#gulp.task 'default', ['recoursses', 'browser-sync', 'watch'], ->
#
#
#gulp.task 'recoursses', (source, target) ->
#  sources.coffee = "./build/#{source}/*.coffee"
#  targets.js     = "./build/#{target}/"
#
#gulp.task 'browser-sync', ->
#  browserSync.init null,
#    open: false
#    server:
#      baseDir: "./build/test-Coffee/"
#    watchOptions:
#      debounceDelay: 1000
#
#gulp.task 'src', ->
#  gulp.src(sources.coffee)
#  .pipe(coffee({bare: true}).on('error', gutil.log))
#  .pipe(concat('test.js'))
#  .pipe(gulp.dest(targets.js))
#
#  #If something comes after this, the function never finished. It will trigger once, but not many times.
#
#
#gulp.task 'watch', ->
#  #  gulp.watch sources.sass, ['style']
#  #  gulp.watch sources.app, ['lint', 'src', 'html']
#  #  gulp.watch sources.html, ['html']
#
#  # And we reload our page if something changed in the output folder
#  gulp.watch './build/test-Coffee/*.coffee', (file) ->
#    browserSync.reload(file.path) if file.type is "changed"
#    gulp.start 'src'


gulp.task 'default', ['browser-sync', 'watch'], ->

gulp.task 'coffee', (source, target, cb) ->
  sourcePath = "./build/#{source}/"
  targetPath = "./build/#{target}/"

  gulp.src "#{sourcePath}*.coffee"
    #.pipe watch "#{sourcePath}*.coffee"
    .pipe coffee bare: true
    .pipe concat "test.js"
    .pipe gulp.dest("#{targetPath}")

  #gutil.log successColor "Successfully updated a file here: " + detailsColor "#{targetPath}"

gulp.task 'browser-sync', ->
  #todo maybe change UI
  browserSync.init(
    server: baseDir: "./build/test-Coffee")
    #open: false
    #browser: "google chrome"
    #port: 7000
  gutil.log "Server initiated and it is serving some files."

gulp.task 'watch', (source, target) ->
  gutil.log "I'm preparing watching your files, now. "
  # control + C to stop it, cmd + s to save, alt + cmd + y to synchronize view
  sourcePath = "./build/#{source}/"
  targetPath = "./build/#{target}/"
  if typeof source is 'string' and typeof target is 'string'
    gutil.log "Your paths are strings, very good!"
    fs.stat sourcePath, (err, stat) ->
      if err is null
        #todo https://www.browsersync.io/docs/gulp/
        #todo watcher watches only one time - BS seems to watch it carefully
        gutil.log "No error occured. I'm about to watching your files now!"
        gulp.watch './build/test-Coffee/*.coffee', (file) ->
          browserSync.reload(file.path) if file.type is "changed"
          gulp.start 'coffee'
          #.on 'change', browserSync.reload("/build/test-JS/test.js")#, ['coffee'] #, ->
          #gulp.start 'coffee'
          #gutil.log "Reloading your page all the time!!"
          #.on 'change', coffee()
          #.on 'end ', gulp.start 'coffee', ->
      else
        #you can make an error switch here to distinguish the error types
        if err.code is 'ENOENT' then gutil.log errorColor "Error code: #{err.code} \n File or folder does not exist. \n It is: #{stat} \n Source: #{sourcePath} \n Target: #{targetPath}"
        else gutil.log errorColor "Error code: #{err.code} \n Please look up here: https://nodejs.org/api/errors.html#errors_error_code."
  else
    gutil.log errorColor '\Please, use: gulp --source your/source/folder --target your/target/folder'