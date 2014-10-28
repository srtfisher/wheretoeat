module.exports = (grunt) ->
  grunt.initConfig
    coffee:
      application:
        files:
          'application/loader.js': 'application/loader.coffee'
          'application/main.js': 'application/main.coffee'
        options:
          bare: true

    watch:
      application:
        files: [
          'application/*.coffee'
          'application/**/*.coffee'
        ]
        tasks: ['coffee']
        options:
          reload: true

  grunt.registerTask 'default', ['coffee:application', 'watch']
  # Load the grunt tasks
  require('load-grunt-tasks') grunt
