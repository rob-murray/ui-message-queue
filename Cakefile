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
  spawnAndRun 'jasmine-node', ['--coffee', 'spec'], callback

build = (callback) ->
  #fs.mkdir 'lib', 0o0755
  print "Building..."
  spawnAndRun 'coffee', ['--compile', '--output', 'lib', 'src'], callback
  print "\n"

task 'test', 'Run all tests', ->
  test()

task 'build', 'Build the Javascript output', ->
  build()
