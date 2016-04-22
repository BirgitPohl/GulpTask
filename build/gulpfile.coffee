gulp    = require 'gulp'

watcher   = require 'watch'
coffee  = require 'gulp-coffee'
concat  = require 'gulp-concat'
gutil   = require 'gulp-util'
#gutil.log requires self defined logs: https://github.com/gulpjs/gulp-util
#color them with chalk
fs      = require 'fs'
chalk   = require 'chalk'
#Some chalk color definitions:
error   = chalk.red
success = chalk.green
details = chalk.yellow

gulp.task 'default', ->
  gutil.log "Hello world"

gulp.task 'give', ->
  params = process.argv
  input = params.indexOf('--input')
  output = params.indexOf('--output')
  if input > -1 then gutil.log details "Hallo #{params[input+1]}"
  if output > -1 then gutil.log details "Hallo #{params[output+1]}"

#coffee -> js with parameter: path to the folders
gulp.task 'coffee', ['default', 'give'], ->
 #todo doobidoo parameter uebergabe with call function
  gulp.start 'give'
  params = process.argv
  source = params.indexOf('--source')
  target = params.indexOf('--target')
  sourceString = params[source+1]
  targetString = params[target+1]
  sourcePath = "./build/#{sourceString}/"
  targetPath = "./build/#{targetString}/"

  if source > -1 and target > -1 and typeof sourceString is 'string' and typeof targetString is 'string' and sourceString.indexOf('--') == -1 and targetString.indexOf('--') == -1
    fs.stat sourcePath, (err, stat) ->
      if err == null
        # control + C to stop it, cmd + s to save, alt + cmd + y to synchronize view
        gulp.watch "#{sourcePath}*.coffee", ->
          #todo doobidoo: Add Gulp Watch
          gulp.src "#{sourcePath}*.coffee"
            .pipe gulp.watch "#{sourcePath}*.coffee"
            .pipe coffee bare: true
            .pipe concat "test.js"
            .pipe gulp.dest "#{targetPath}"

            .on 'error', gutil.log
          gutil.log success "Successfully updated a file here: " + details "./build/#{targetString}/"
      else
        if err.code is 'ENOENT' then gutil.log error "Error code: #{err.code} \n File or folder does not exist. \n It is: #{stat}"
        else gutil.log error "Error code: #{err.code} \n Please look up here: https://nodejs.org/api/errors.html#errors_error_code."
  else
    gutil.log error '\Please, use: gulp coffee --source your/source/folder --target your/target/folder'