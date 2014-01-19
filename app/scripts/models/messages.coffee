define [
  "app",
  "firebase",
  "backbone",
  "jquery",
  "underscore"
], (App, Firebase, Backbone, $, _) ->

  App.Models ?= {}
  App.Models.Chat ?= {}

  class App.Models.Chat.Message extends Backbone.Model
    initialize: (opts) ->
      if opts.id
        @firebase = new Backbone.Firebase(App.API_URL + "/messages/#{opts.id}/")
      else
        @firebase = new Backbone.Firebase(App.API_URL + "/messages/")
      # Unlike the other models, we don't delete the ID as we can't
      # guarantee the uniqueness of any such ID
      @fetch()
      this.on('change', this.change, this);

  class App.Models.Chat.MessageCollection extends Backbone.Collection
    initialize: (opts) ->
      if opts.id
        @firebase = new Backbone.Firebase(App.API_URL + "/chats/#{opts.id}/messages/")
      else
        @firebase = new Backbone.Firebase(App.API_URL + "/chats/messages/")
      @fetch()

  App.Models
