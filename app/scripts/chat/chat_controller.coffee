define [
  'app',
  'jquery',
  'underscore',
  'firebase',
  'backbone',
  'marionette',
  'models',
  './chat_view',
  'jquery-cookie'
], (App, $, _, Firebase, Backbone, Marioentte, Models, Views) ->

  App.Chat ?= {}

  class App.Chat.Controller extends Marionette.Controller

    initialize: (opts) ->
      @user = opts.user
      @region = opts.region
      layout = new App.Chat.Layout

      layout.on 'itemView:click', () ->
        view = layout.onSelectTab()
        layout.chat_region.show(view)

      layout.on 'onLogout', (event) ->
        $.cookie('user', null)
        App.CustomRouter.navigate '/'
        window.location.reload()

      layout.on 'create:room', () ->
        # Create a new chat room, then select it
        id = window.prompt("Please enter the name of the room","New Room")
        rooms = new Firebase(App.API_URL + "/chats/")
        rooms.push()
        rooms.set
          id: id
          users: []
          messages: []
        window.location.reload()

      @region.show layout
      layout.chat_region.show(layout.onSelectTab())

  App
