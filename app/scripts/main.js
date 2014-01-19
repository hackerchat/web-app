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
    text: '../bower_components/requirejs-text/text',
    firebase: '../bower_components/firebase/firebase',
    backfire: '../bower_components/backfire/backbone-firebase',
    'jquery-cookie': '../bower_components/jquery-cookie/jquery.cookie',
    'highlight': 'lib/highlight.pack'
  },
  'shim': {
    'backbone': {
      deps: ['jquery', 'underscore'],
      exports: 'Backbone'
    },
    'jquery': {
      exports: '$'
    },
    'jquery-cookie': ['jquery'],
    'underscore': {
      exports: '_'
    },
    highlight: {
      exports: 'Highlight',
      deps: ['$']
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
    },
    firebase: {
      exports: 'Firebase'
    },
    backfire: {
      deps: ['backbone', 'firebase'],
      exports: 'Backfire'
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
