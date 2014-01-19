define('app',
  ['marionette',
   'backbone',
   'jquery',
   'underscore',
   'exports',
   './router',
   './controller',
   './views',
   './models',
   './codeformat'
  ],
  function (Marionette, Backbone, $, _, exports, Router, Controller, Views, Models, CodeFormater) {
    'use strict';
    var App = window.App = new Marionette.Application();
    App = _.extend(exports, App);

    App.API_URL = "http://hacker-chat-app.firebaseio.com";

    App.addInitializer(function (options) {
      var controller, router;
      controller = new App.Controller();
      router = new App.Router({
        controller: controller
      });
      Backbone.history.start();
      App.CustomRouter = router;
    });

    return App;
  }
);
