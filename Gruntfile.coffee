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
    uglify:
      my_target:
        files:
          'lib/ui-message-queue.min.js': ['lib/ui-message-queue.js']

  grunt.loadNpmTasks 'grunt-contrib-coffee'
  grunt.loadNpmTasks 'grunt-mocha-test'
  grunt.loadNpmTasks 'grunt-coffeelint'
  grunt.loadNpmTasks 'grunt-contrib-uglify'

  grunt.registerTask 'default', ['mochaTest']
  grunt.registerTask 'test', ['mochaTest']
  grunt.registerTask 'build', ['coffee', 'uglify']
