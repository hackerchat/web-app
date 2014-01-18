/*global require, Backbone*/
require.config({
  paths: {
    jquery: '../bower_components/jquery/jquery',
    backbone: '../bower_components/backbone/backbone',
    marionette: '../bower_components/marionette/lib/backbone.marionette',
    requirejs: '../bower_components/requirejs/require',
    underscore: '../bower_components/underscore/underscore',
    handlebars: '../bower_components/handlebars/handlebars',
    templates: 'templates',
    text: '../bower_components/requirejs-text/text'
  },
  'shim': {
    'backbone': {
      deps: ['jquery', 'underscore'],
      exports: 'Backbone'
    },
    'jquery': {
      exports: '$'
    },
    'underscore': {
      exports: '_'
    },
    'marionette': {
      deps: ['backbone'],
      exports: 'Backbone.Marionette'
    },
    handlebars: {
      exports: 'Handlebars'
    },
    templates: {
      deps: ['handlebars'],
      exports: 'JST'
    }
  }
});

/*
 * specify the requirements needed for the application to run
 */
require([
  'app',
  'jquery'
], function(App, $) {
  'use strict';
  /* start the application */
  App.start();
});
