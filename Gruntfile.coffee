module.exports = (grunt) ->
  grunt.loadNpmTasks 'grunt-bower-concat'
  grunt.loadNpmTasks 'grunt-browserify'
  grunt.loadNpmTasks 'grunt-este-watch'
  grunt.loadNpmTasks 'grunt-contrib-compass'
  grunt.loadNpmTasks 'grunt-karma'
  grunt.loadNpmTasks 'grunt-shell'
  grunt.initConfig
    bower_concat:
      all:
        dest: "www/vendor.js"
        bowerOptions:
          relative: false

    browserify:
      app:
        files:
          "www/all.js": [
            "app/**/*.coffee"
          ]
        options:
          transform: ["coffeeify", "brfs", "uglifyify"]

      spec:
        files: 
          "spec/build/test.js": [
            "spec/src/**/*.spec.coffee"
          ]
        options:
          transform: ["coffeeify"]

    karma:
      unit:
        options:
          frameworks: [
            'mocha',
            'sinon-chai'
          ]
          files: ["spec/build/test.js"]
          browsers: ['PhantomJS']
          reporters: "spec"
          singleRun: true

    compass:
      dist:
        options:
          sassDir: "app/styles"
          specify: "app/styles/all.scss"
          cssDir: "www"
          require: ["animation"]
          outputStyle: "compressed"

    esteWatch:
      options:
        dirs: [
          "app/**/"
          "spec/**/"
        ]
      coffee: (filepath) ->
        ["buildweb"]
      html: (filepath) ->
        ["buildweb"]
      scss: (filepath) ->
        ["compass"]

    shell:
      cordovaRun:
        command: (platform) ->
          "cordova run #{platform}"
      cordovaBuild:
        command: (platform, env) ->
          "cordova build #{platform} --#{env}"

  grunt.registerTask "buildweb", ["bower_concat", "browserify", "compass", "karma"]
  grunt.registerTask "watch", ["esteWatch"]

  grunt.registerTask "run", (platform) ->
    grunt.fail.warn "usage example: grunt run:android" if not platform?
    grunt.task.run "buildweb"
    grunt.task.run "shell:cordovaRun:#{platform}"

  grunt.registerTask "build", (platform, env) ->
    grunt.fail.warn "usage example: grunt build:android:release" if not platform? or not env?
    grunt.task.run "buildweb"
    grunt.task.run "shell:cordovaBuild:#{platform}:#{env}"
