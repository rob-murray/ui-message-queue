module.exports = (grunt) ->
  grunt.initConfig
    coffee:
      compile:
        files:
          'lib/ui-message-queue.js': ['src/*.coffee']
    mochaTest:
      src: ['test/*.coffee']

  grunt.loadNpmTasks 'grunt-contrib-coffee'
  grunt.loadNpmTasks 'grunt-mocha-test'

  grunt.registerTask 'default', ['mochaTest']