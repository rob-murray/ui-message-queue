module.exports = (grunt) ->
  grunt.initConfig
    coffee:
      compile:
        files:
          'lib/ui-message-queue.js': ['src/*.coffee']
    mochaTest:
      src: ['test/*.coffee']
    coffeelint:
      app: ['src/*.coffee'],
      tests:
        files:
          src: ['test/*.coffee']
      options:
        configFile: 'coffeelint.json'

  grunt.loadNpmTasks 'grunt-contrib-coffee'
  grunt.loadNpmTasks 'grunt-mocha-test'
  grunt.loadNpmTasks 'grunt-coffeelint'

  grunt.registerTask 'default', ['mochaTest']
  grunt.registerTask 'test', ['mochaTest']
  grunt.registerTask 'build', ['coffee']
