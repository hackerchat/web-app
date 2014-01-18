define [
  'app',
  'views',
  'marionette'
], (App, Views, Marionette) ->

  class App.Controller extends Marionette.Controller
    initialize: () ->
      @region = new Backbone.Marionette.Region {
        el: ".content-container"
      }
      @layout = null
  
    splash: ->
      @layout = new App.Splash.Controller({region: @region})

    chatIndex: ->
      alert "Navigating to chat index"

    chatRoom: (room) ->
      alert "Navigating to chat room"

    @layout.on 'login', (credentials) ->
      # Triggers a login to firebase

  App
