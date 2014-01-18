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

    submitLogin: =>
      console.log @$el.find('#login input[name="user"]')
      credentials = {
        user: @$el.find('#login input[name="user"]').val()
      }

      # Reset error
      @$el.find('.splash-error').text('')

      if (credentials.user.length < 1)
        @trigger 'invalid:user', "Username is too short"
      else
        @trigger 'login', credentials  

    onRender: ->
      $('.content.container').append(@el);
      @$el = $(@el).children()
      @$el.unwrap()
      @$el.find('.splash-toggle-login-collapse').hide()
      @$el.on 'click', 'button.splash-button', @getLogin
      @$el.on 'click', '#guest', @submitLogin
      @$el.on 'click', '#github', @gitAuth
      this.on 'invalid:user', (msg) =>
        @$el.find('.splash-error').text(msg)

  Views
