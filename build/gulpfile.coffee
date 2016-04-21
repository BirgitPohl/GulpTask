gulp    = require 'gulp'

coffee  = require 'gulp-coffee'
concat  = require 'gulp-concat'
gutil   = require 'gulp-util'
fs      = require 'fs'

#Works with one parameter
gulp.task 'default', ->
  i = process.argv.indexOf('--option')
  if i > -1 then console.log "Hallo #{process.argv[i+1]}"

#Loop working
gulp.task 'give', ->
  params = process.argv
  input = params.indexOf('--input')
  output = params.indexOf('--output')
  if input > -1 then console.log "Hallo #{params[input+1]}"
  if output > -1 then console.log "Hallo #{params[output+1]}"

gulp.task 'coffee', ->
  params = process.argv
  #todo: http://stackoverflow.com/questions/30348833/check-if-file-exist-in-gulp
  #fs.stat('file.txt', function(err, stat) {
  #  if(err == null) {
  #    console.log('File exists');
  #} else {
  #  console.log(err.code);
  #}
  #});
  source = params.indexOf('--source')
  target = params.indexOf('--target')
  sourceString = params[source+1]
  targetString = params[target+1]
  sourcePath = "./build/#{sourceString}/"
  targetPath = "./build/#{targetString}/"

  if source > -1 and target > -1 and typeof sourceString is 'string' and typeof targetString is 'string' and sourceString.indexOf('--') == -1 and targetString.indexOf('--') == -1
    fs.stat sourcePath, (err, stat) ->
      if err == null
        gulp.src "#{sourcePath}*.coffee"
         .pipe coffee bare: true
         .pipe concat "test.js"
         .pipe gulp.dest "#{targetPath}"
         .on 'error', gutil.log
        console.log "\x1b[36m", "Successfully created a file here: \x1b[33m ./build/#{targetString}/", " \x1b[0m"
      else
        if err.code is 'ENOENT' then console.error '\x1b[31m', "Error code: #{err.code} \n File or folder does not exist. \n It is: #{stat}" ,'\x1b[0m'
        else console.error '\x1b[31m', "Error code: #{err.code} \n Please look up here: https://nodejs.org/api/errors.html#errors_error_code." ,'\x1b[0m'
  else
    console.error '\x1b[31m', '\Please, use: gulp coffee --source your/source/folder --target your/target/folder' ,'\x1b[0m'

##Loop working
#gulp.task 'give', ->
#  params = process.argv
#  input = params.indexOf('--input')
#  output = params.indexOf('--output')
#  if input > -1 then console.log "Hallo #{process.argv[input+1]}"
#  if output > -1 then console.log "Hallo #{process.argv[output+1]}"

##Loop working
#gulp.task 'give', ->
#  params = process.argv
#  item for item in params
#  console.log("Hallo #{item}")

#gulp.task 'default', ->
#  params = process.argv
#  for item in params when params.indexOf(params[item]) < params.length
#    console.log("Hallo #{params[item]}")

#gulp.task 'coffee', ->
#  gulp.src "#{parameters.app_path}/**/*.coffee"
#  .pipe coffee bare: true
#  .pipe concat parameters.app_main_file
#  .pipe gulp.dest "#{parameters.web_path}/js"
#  .on 'error', gutil.log
