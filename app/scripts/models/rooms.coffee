define [
  "app",
  "firebase",
  "backbone",
  "backfire",
  "jquery",
  "underscore"
], (App, Firebase, Backbone, Backfire, $, _) ->

  App.Models ?= {}
  App.Models.Chat ?= {}

  class App.Models.Chat.Room extends Backbone.Model
    initialize: (opts) ->
      @firebase = new Backbone.Firebase(App.API_URL + "/chats/")
      # Likewise here we must delete the ID if we intend to create
      # a new chat room as we already index by ID
      delete @attributes.id
      @fetch()

  class App.Models.Chat.RoomCollection extends Backbone.Firebase.Collection
    initialize: (opts) ->
      @firebase = App.API_URL + "/chats/"
      @fetch()

  App.Models
