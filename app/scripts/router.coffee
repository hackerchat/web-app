define [
  'app',
  'controller'
  './views',
  './marionette',
  'jquery',
  'jquery-cookie'
], (App, Controller, Views, Marionette, $) ->

  class App.Router extends Marionette.AppRouter

    appRoutes:
      "": "splash",
      "chat": "chatIndex",

  App.CustomRouter ?= new App.Router({
    controller: new App.Controller()
  });

  cookies = $.cookie()
  App.User = cookies.user

  App
