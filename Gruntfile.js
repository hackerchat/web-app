/*global module, require */
module.exports = function(grunt) {
  /* Begin Grunt Configuration */
  grunt.initConfig({
    pkg: grunt.file.readJSON('package.json'),
    yeoman: {
      app: 'app',
      dist: 'dist',
      tmp: '.tmp'
    },
    jshint: {
      all: [
        "Gruntfile.js"
      ]
    },
    uglify: {
      options: {
        mangle: false,
        exportAll: true
      }
    },
    connect: {
      options: {
        port: 9000,
        livereload: 35729,
        hostname: '0.0.0.0' /* localhost */
      },
      livereload: {
        options: {
          base: [ 
            '<%= yeoman.tmp %>/'
          ]
        }
      },
      dist: {
        options: {
          open: true,
          keepalive: true,
          base: '<%= yeoman.tmp %>/'    
        }
      }
    },
    clean: {
      server: '<%= yeoman.tmp %>/'
    },
    sync: {
      js: {
        files: [
          {
            cwd: '<%= yeoman.app %>/',
            dest: '<%= yeoman.tmp %>/',
            src: [
              'bower_components/**/*.js',
              'scripts/**/*.js',
              '*.js'
            ]
          }
        ]
      },
      styles: {
        files: [
          {
            cwd: '<%= yeoman.app %>/',
            dest: '<%= yeoman.tmp %>/',
            src: [
              'res/css/bootstrap*',
              'res/css/default.css'
            ]
          }
        ]
      },
      files: {
        files: [
          {
            cwd: '<%= yeoman.app %>/',
            dest: '<%= yeoman.tmp %>/',
            src: [
              '*.{ico,png,txt}',
              '.htaccess',
              './index.html'
            ]
          }
        ]
      },
      images: {
        files: [
          {
            cwd: '<%= yeoman.app %>/',
            dest: '<%= yeoman.tmp %>/',
            src: [
              'res/img/**/*.png',
              'res/img/**/*.jpeg',
              'res/img/**/*.jpg'
            ]
          }
        ]
      }
    },
    sass: {
      dist: {
        options: {
          style: 'expanded'
        },
        files: [
          {
            expand: true,
            cwd: '<%= yeoman.app %>/res/css/',
            src: ['*.scss'],
            dest: '<%= yeoman.tmp %>/res/css/',
            ext: '.css'
          }
        ]
      }
    },
    handlebars: {
      compile: {
        options: {
          amd: true,
          namespace: 'JST',
          processName: function (filename) {
            return filename.replace('app/templates/', '').replace('.hbs', '');
          }
        },
        files: {
          '<%= yeoman.tmp %>/scripts/templates.js': ['<%= yeoman.app %>/fixtures/templates/**/*.hbs']
        }
      }
    },
    watch: {
      coffee: {
        files: ['<%= yeoman.app %>/scripts/**/*.coffee'],
        tasks: ['coffee']
      },
      js: {
        files: ['<%= yeoman.app %>/scripts/**/*.js'],
        tasks: ['sync:js', 'jshint']
      },
      templates: {
        files: ['<%= yeoman.app %>/fixtures/**/*.hbs'],
        tasks: ['handlebars']
      },
      sass: {
        files: ['<%= yeoman.app %>/**/*.scss'],
        tasks: ['sass']
      },
      livereload: {
        options: {
          livereload: true,
          debounceDelay: 1,
          interval: 1
        },
        tasks: [],
        files: [
          '<%= yeoman.tmp %>/tmp/res/css/main.css',
          '<%= yeoman.tmp %>/scripts/**/*.js'
        ]
      }
    },
    concurrent: {
      server: {
        tasks: [
          'watch:coffee',
          'watch:js',
          'watch:templates',
          'watch:sass',
          'watch:livereload'
        ],
        options: {
          logConcurrentOutput: true
        }
      }
    },
    coffee: {
      dist: {
        files: [
          {
            expand: true,
            cwd: '<%= yeoman.app %>/scripts',
            src: '**/*.coffee',
            dest: '<%= yeoman.tmp %>/scripts',
            ext: '.js'
          }
        ]
      }
    }
  });
  /* End Grunt Config */
  /* Begin Loading Tasks */
  grunt.loadNpmTasks('grunt-contrib-jshint');
  grunt.loadNpmTasks('grunt-contrib-connect');
  grunt.loadNpmTasks('grunt-contrib-uglify');
  grunt.loadNpmTasks('grunt-contrib-coffee');
  grunt.loadNpmTasks('grunt-contrib-handlebars');
  grunt.loadNpmTasks('grunt-sync');
  grunt.loadNpmTasks('grunt-contrib-sass');
  grunt.loadNpmTasks('grunt-contrib-clean');
  grunt.loadNpmTasks('grunt-contrib-watch');
  grunt.loadNpmTasks('grunt-concurrent');
  /* End Loading Tasks */
  /* Begin Registering Tasks */
  grunt.registerTask('server', function () {
    grunt.task.run([
      'clean:server',
      'sass',
      'coffee',
      'handlebars',
      'sync',
      'connect:livereload',
      'concurrent:server'
    ]);
  });

  grunt.registerTask('default', ['uglify', 'sass', 'coffee', 'handlebars', 'sync']);
  /* End Registering Tasks */
};
