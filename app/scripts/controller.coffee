define [
  'app',
  'jquery',
  'underscore',
  'views',
  'marionette',
  './router'
], (App, $, _, Views, Marionette, Router) ->

  class App.Controller extends Marionette.Controller
    initialize: () ->
      @region = new Backbone.Marionette.Region {
        el: ".content-container"
      }

    splash: ->
      layout = new App.Splash.Controller({region: @region})

      layout.on 'login', (credentials) ->
        # Triggers a login to firebase
        user = new App.Models.User(credentials)
        console.log user
    
    chatIndex: ->
      if not App.User
        App.CustomRouter.navigate '/', true
      else
        layout = new App.Chat.Controller({region: @region, user: App.User})
  
  App
