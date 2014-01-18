define [
  'app',
  './views',
  './marionette'
], (App, Views, Marionette) ->

  class App.Router extends Marionette.AppRouter

    appRoutes:
      "": "splash",
      "/chat": "chatIndex",
      "/chat/:room": "chatRoom"

  App
