{spawn} = require 'child_process'
{print} = require 'util'
fs      = require 'fs'

spawnAndRun = (command, args, callback) ->
  subproc = spawn(command, args)
  subproc.stderr.on 'data', (data) ->
    process.stderr.write data.toString()
  subproc.stdout.on 'data', (data) ->
    print data.toString()
  subproc.on 'exit', (code) ->
    callback?() if code is 0

test = (callback) ->
  spawnAndRun 'jasmine-node', ['--coffee', './test/spec'], callback

buildForTest = (callback) ->
  #fs.mkdir 'lib', 0o0755
  print "Building project for testing..."
  spawnAndRun 'coffee', ['--compile', '--output', 'lib', 'src'], callback
  print "\n"

buildForRelease = (callback) ->
  #fs.mkdir 'lib', 0o0755
  print "Building project for release..."
  spawnAndRun 'coffee', ['--join', './lib/UiMessageQueue-release.js', '--compile', '--output', 'lib', 'src'], callback
  print "\n"

runCodeQualityTools = (callback) ->
  print "Running code quality tools"
  spawnAndRun 'coffeelint', ['src/'], callback
  print "\n"

task 'test', 'Run all tests', ->
  test()

task 'test.quality', 'Analyse code quality', ->
  runCodeQualityTools()

task 'build.test', 'Build the Javascript output for testing', ->
  buildForTest()

task 'build.release', 'Build the Javascript output for release version', ->
  buildForRelease()

