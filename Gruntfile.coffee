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
          'stylesheets/*.scss'
        ]
        tasks: ['coffee:application', 'sass:application']
        options:
          reload: true

    sass:
      application:
        files: 'stylesheets/main.css': 'stylesheets/main.scss'

  grunt.registerTask 'default', [
    'coffee:application'
    'sass:application'
    'watch'
  ]
  # Load the grunt tasks
  require('load-grunt-tasks') grunt
