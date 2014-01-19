define [
  'app',
  '../views',
  'jquery',
  'marionette',
  'underscore',
  'templates'
], (App, Views, $, Marionette, _, JST) ->

  App.Splash ?= {}
  
  class App.Splash.View extends Marionette.ItemView
    template: JST["app/fixtures/templates/splash"]

    getLogin: =>
      @$el.find('.splash-toggle-login-uncollapse').hide()
      @$el.find('.splash-toggle-login-collapse').show(1000)

    gitAuth: =>
      alert "Not implemented yet."

    showName: =>
      @$el.find('#login .name').show()
      @$el.find('#login input[name="user"]').attr('disabled', 'disabled')

    submitLogin: =>
      credentials = {
        id: @$el.find('#login input[name="user"]').val().toLowerCase()
      }

      $name = @$el.find('#login input.name')
      if $name.is(':visible')
        credentials.name = $name.val()

      # Reset error
      @$el.find('.splash-error').text('')

      if (credentials.id.length < 1)
        @trigger 'invalid:user', "Username is too short"
      else if (credentials.name and credentials.name.length < 1)
        @trigger 'invalid:user', "Name is too short"
      else
        @trigger 'login', credentials  

    onRender: ->
      $('.content.container').append(@el);
      @$el = $(@el).children()
      @$el.unwrap()

      # Hide elements
      @$el.find('.splash-toggle-login-collapse').hide()
      @$el.find('#login .name').hide()

      @$el.on 'click', 'button.splash-button', @getLogin
      @$el.on 'click', '#guest', @submitLogin
      @$el.on 'click', '#github', @gitAuth
      this.on 'invalid:user', (msg) =>
        @$el.find('.splash-error').text(msg)

  Views
