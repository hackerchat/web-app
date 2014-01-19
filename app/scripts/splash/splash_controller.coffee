define [
  'app',
  'jquery',
  'firebase',
  'backbone',
  'marionette',
  'models',
  './splash_view'
], (App, $, Firebase, Backbone, Marionette, Models, Views) ->

  App.Splash ?= {}

  class App.Splash.Controller extends Marionette.Controller

    initialize: (opts) ->
      layout = new App.Splash.View
      users = new App.Models.UserCollection()
      @region = opts.region

      layout.on 'login', (payload) ->
        # Triggers a login to the Firebase User
        # Creating it if it doesn't exist
        user = users.get(payload.id)
        if not user
          if payload.name
            user = new App.Models.User(payload)
            user.save()
          else
            layout.showName()
        else
          App.User = user.id
          $.cookie('user', user.id)
          App.CustomRouter.navigate '/chat', true
  
      @region.show layout
