define [
  "app",
  "firebase",
  "backbone",
  "jquery",
  "underscore"
], (App, Firebase, Backbone, $, _) ->

  Client = Client || {}

  class Client.BaseModel extends BackBone.Firebase.Model
    firebase: "hacker-chat-app.firebaseio.com"

  class Client.Message extends Client.BaseModel
    initialize: ->
      @fetched = false

  class Client.ChatRoom extends Client.BaseModel
    initialize: ->
      @fetched = false

  Client
