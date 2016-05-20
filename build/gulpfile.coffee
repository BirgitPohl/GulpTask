gulp          = require('gulp-param')(require('gulp'), process.argv)
browserSync   = require('browser-sync')#.create #call this before gulp
watch         = require 'gulp-watch'
#jshint       = require 'gulp-jshint' #shows mistakes in your JS file
coffee        = require 'gulp-coffee'
concat        = require 'gulp-concat'
gutil         = require 'gulp-util'
fs            = require 'fs'
chalk         = require 'chalk'
clean         = require 'gulp-clean'
reload        = browserSync.reload
opn           = require 'opn'

##########################################
########### Sources & Targets ############
##########################################

sources =
  coffee:       "./build/src/coffee/*.coffee" #"./build/test-Coffee/*.coffee"
  coffeePath:   "./build/src/coffee/" #"./build/test-Coffee/*.coffee"

targets =
  js:           "./build/src/js/" #"./build/test-JS/"

##########################################
############## Log Colors ################
##########################################
#gutil.log requires self defined logs: https://github.com/gulpjs/gulp-util
#color them with chalk

logColor =
  error:    chalk.red
  success:  chalk.green
  detail:   chalk.yellow

##########################################
############# Watching files #############
##########################################

gulp.task 'clean', ->
  gulp.src([targets.js], {read: false}).pipe(clean())


gulp.task 'get-args', (source, target) ->
  if typeof source is 'string' and typeof target is 'string'
    if source.length > 0
      sources.coffeePath = "./build/#{source}/"
      sources.coffee = "./build/#{source}/*.coffee"
    if target.length > 0
      targets.js     = "./build/#{target}/"
  else
    gutil.log logColor.success "Using default path for --source and --target.
    \n Use: \'gulp --source your/source/folder --target your/target/folder\'
    \n if you like to change the default path temporarily."

gulp.task 'browser-sync', ->
  fs.stat sources.coffeePath, (err, stat) ->
    if err is null
      browserSync.init null,
#        root: './build'
        livereload: true
#        proxy    : 'http://localhost:3000'
        port     : 3000
        open: false
        browser: 'Google Chrome'
        notify: true ##false if you don't want the small popup
        injectChanges: true #somehow descripted for css use only
        codeSync: true #if true, sends file changes to browsers
        server:
          baseDir: './' ##sources.coffeePath
        watchOptions:
          debounceDelay: 1000
          reloadDelay:2000
      opn 'http://localhost:3000/build'
    else
    #you can make an error switch here to distinguish the error types
      if err.code is 'ENOENT' then gutil.log logColor.error "Error code: #{err.code} \n File or folder does not exist. \n It is: #{stat} \n Source: #{sources.coffee} \n Target: #{targets.js}"
      else gutil.log logColor.error "Error code: #{err.code} \n Please look up here: https://nodejs.org/api/errors.html#errors_error_code."

gulp.task 'write-coffee', ->
  gulp.src(sources.coffee)
  .pipe(coffee({bare: true}).on('error', gutil.log, 'end', gutil.log logColor.success "Successfully updated a file here: " + logColor.detail "#{targets.js}"))
  .pipe(concat('app.js'))
  .pipe(gulp.dest(targets.js))
  .pipe(browserSync.stream());

#If gutil.log or console.log comes after this, the function never finished. It will trigger once, but not many times.
  #todo: after syntax error .src doesn't fire anymore: https://github.com/contra/gulp-coffee/issues/68
  #Todo: error log is just cryptic shit

gulp.task 'watch', ->
  #  gulp.watch sources.sass, ['style']
  #  gulp.watch sources.app, ['lint', 'src', 'html']
  gulp.watch sources.html, ['html']
  gulp.watch("./build/index.html").on('change', reload)

  fs.stat sources.coffeePath, (err, stat) ->
    if err is null
      
      gulp.watch sources.coffee, ->
        gulp.start 'write-coffee'
        browserSync.reload()
        gulp.start 'browser-reload'

    else
      #you can make an error switch here to distinguish the error types
      if err.code is 'ENOENT' then gutil.log logColor.error "Error code: #{err.code} \n File or folder does not exist. \n It is: #{stat} \n Source: #{sources.coffee} \n Target: #{targets.js}"
      else gutil.log logColor.error "Error code: #{err.code} \n Please look up here: https://nodejs.org/api/errors.html#errors_error_code."

gulp.task 'browser-reload', ->
  
      
gulp.task 'default', ['get-args', 'browser-sync', 'watch'], ->
  http.createServer( ecstatic( root: __dirname ) ).listen(5000)