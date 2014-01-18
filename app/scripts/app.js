define('app',
  ['marionette',
   'backbone',
   'jquery',
   'underscore',
   'exports',
   './router',
   './controller',
   './views'
  ],
  function (Marionette, Backbone, $, _, exports, Router, Controller, Views) {
    'use strict';
    var App = window.App = new Marionette.Application();
    App = _.extend(exports, App);

    App.addInitializer(function (options) {
      var controller, router;
      controller = new App.Controller();
      router = new App.Router({
        controller: controller
      });
      Backbone.history.start();
    });
    return App;
  }
);
