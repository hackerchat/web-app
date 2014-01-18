define [
  'app',
  'jquery',
  './splash_view'
], (App, Views) ->

  App.Splash ?= {}

  class App.Splash.Controller extends Marionette.Controller

    initialize: (opts) ->
      layout = new App.Splash.View
      @region = opts.region

      layout.on 'login', (payload) ->
        console.log "Login in...."

      @region.show layout
