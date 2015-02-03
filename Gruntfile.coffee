module.exports = (grunt)->
  grunt.loadNpmTasks('grunt-wiredep')
  grunt.loadNpmTasks('grunt-bower-requirejs')
  grunt.initConfig(
    pkg: grunt.file.readJSON "package.json"
    wiredep:
      target:
        src: 'index.html'
    bowerRequirejs: target: rjsConfig: 'js/config.js'
  )

  grunt.registerTask('default', ['bowerRequirejs'])