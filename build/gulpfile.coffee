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


##########################################
############# Watching files #############
############# call functions #############
############ with gulp-params ############
##########################################

gulp.task 'default', ['browser-sync', 'watch'], ->

gulp.task 'coffee', (source, target) ->
  sourcePath = "./build/#{source}/"
  targetPath = "./build/#{target}/"

  gulp.src "#{sourcePath}*.coffee"
    #.pipe watch "#{sourcePath}*.coffee"
    .pipe coffee bare: true
    .pipe concat "test.js"
    .pipe gulp.dest "#{targetPath}"
    .pipe browserSync.reload({stream: true})
    .on 'error', gutil.log#, 'change', browserSync.stream, 'end', gutil.log successColor ['watch']
    #.on 'change', browserSync.stream, 'error', gutil.log
    #.pipe("#{sourcePath}*.coffee").watch
  gutil.log successColor "Successfully updated a file here: " + detailsColor "#{targetPath}"

gulp.task 'browser-sync', ->
  #todo maybe change UI
  browserSync.init(
     server: baseDir: "./build/test-Coffee")
  gutil.log "Server initiated and it is serving some files."

gulp.task 'watch', (source, target) ->
  gutil.log "I'm preparing watch now:"
  # control + C to stop it, cmd + s to save, alt + cmd + y to synchronize view
  sourcePath = "./build/#{source}/"
  targetPath = "./build/#{target}/"
  if typeof source is 'string' and typeof target is 'string'
    fs.stat sourcePath, (err, stat) ->
      if err is null
        #todo https://www.browsersync.io/docs/gulp/
        #todo watcher watches only one time - BS seems to watch it carefully
        watch "./build/#{source}/*.coffee"#, ['coffee'] #todo the function call is ignored
          .on 'change', browserSync.reload, -> #todo browsersync.reload prevents triggering everything after it
            gulp.start 'coffee'

          #.on 'change', coffee()
      else
        #you can make an error switch here to distinguish the error types
        if err.code is 'ENOENT' then gutil.log errorColor "Error code: #{err.code} \n File or folder does not exist. \n It is: #{stat} \n Source: #{sourcePath} \n Target: #{targetPath}"
        else gutil.log errorColor "Error code: #{err.code} \n Please look up here: https://nodejs.org/api/errors.html#errors_error_code."
  else
    gutil.log errorColor '\Please, use: gulp --source your/source/folder --target your/target/folder'