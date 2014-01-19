define [
  "app",
  "firebase",
  "backbone",
  "backfire",
  "jquery",
  "underscore"
], (App, Firebase, Backbone, Backfire, $, _) ->

    App.Models ?= {}

    class App.Models.User extends Backbone.Model
      initialize: (opts) ->
        @firebase = new Backbone.Firebase(App.API_URL + "/users/")
        @attributes.chats = {}
        # We do an initial delete as if we fetch and it exists, we need not
        # worry about ID, otherwise it will be there and will store incorrectly
        delete @attributes.id
        @fetch()

    class App.Models.UserCollection extends Backbone.Firebase.Collection
      initialize: (opts) ->
        @firebase = App.API_URL + "/users/"
        @fetch()

    App.Models
