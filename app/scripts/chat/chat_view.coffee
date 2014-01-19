define [
  'app',
  '../views',
  'jquery',
  'backbone',
  'marionette',
  'underscore',
  'firebase',
  'templates'
], (App, Views, $, Backbone, Marionette, _, Firebase, JST) ->

  App.Chat ?= {}

  class App.Chat.Layout extends Marionette.Layout
    # The selected tab at the moment dictates which ItemView is
    # being displayed at any given time.
    template: JST["app/fixtures/templates/chat_main"]
    
    container: ".container.content"

    className: "chat-room-main"
  
    regions:
      menu: ".navbar.navbar-inverse"
      chat_region: ".chat-region"

    events:
      'click :not(.logout, .new-room) > a': 'onNavClick'
      'click .chat-room-tile': 'chatRoomSelect'

    triggers:
      'click .btn-right.btn.logout a': 'onLogout'
      'click .btn.btn-subright.new-room a': 'create:room'

    onNavClick: (event) ->
      event.preventDefault()
      $target = $(event.target)
      $(@el).find('.navbar.navbar-inverse li').removeClass('active')
      $target.parent().addClass('active')
      @trigger 'itemView:click'
        
    chatRoomSelect: (event) ->
      chat_id = $(event.currentTarget).parent().attr('id')
      event.preventDefault()
      if $('[data-id="' + chat_id + '"]').length == 0
        $new_nav = $('<li class="btn"><a href="#">' + chat_id + '</a></li>') 
        $(@el).find('.navbar.navbar-inverse ul').append($new_nav)
        $new_nav.attr('data-id', chat_id).find('a').click()

    onSelectTab: ->
      $selected = $(@el).find('.navbar.navbar-inverse li.active')
      view = $selected.find('a').text()
      if view == "Chat Rooms"
        new App.Chat.Room.CollectionView()
      else if view == "Users"
        new App.Chat.Users.CollectionView()
      else if view == "Settings"
        new App.Chat.SettingsView()
      else
        id = $selected.attr('data-id')
        new App.Chat.Room.View({'id': id}, {'id': id})

    onRender: ->
      $(@el).appendTo($(@container));
      $(@el).unwrap()


  App.Chat.Room ?= {}

  class App.Chat.Room.TileView extends Marionette.ItemView
    template: JST["app/fixtures/templates/chat_room_tile"]

  class App.Chat.Room.CollectionView extends Marionette.CollectionView
    itemView: App.Chat.Room.TileView

    className: "chat-push-down"

    initialize: (opts) ->
      @collection = new App.Models.Chat.RoomCollection()

    onRender: ->

    itemViewOptions: (model, index) ->
      lastMessage = model.get('lastMessage')
      lastMessage = new App.Models.Chat.Message
        id: lastMessage

      {
        'id': model.get('id'),
        'lastMessage': lastMessage
      }

  class App.Chat.Room.MessageView extends Marionette.ItemView
    template: JST["app/fixtures/templates/chat_room_message"]

    className: "chat-room-message"

    initialize: (model, opts) ->
      @options = opts
      @render()

    serializeData: ->
      @options

    onRender: ->
      $code = App.codeFormat(@options.text)
      @$el.find('.chat-message-text').append($code)

  class App.Chat.Room.View extends Marionette.ItemView
    template: JST["app/fixtures/templates/chat_room"]

    message_area: ".chat-message-area"

    text_area: ".chat-text-area textarea"

    events:
      'click button.form-control-submit': 'sendMessage'
      'click button.leave-room': 'leaveRoom'

    initialize: (model, opts) ->
      @id = model.id || opts.id
      @onEnterRoom()
      _.bindAll this, 'displayMessage'
      _.bindAll this, 'render'

    onRender: ->
      @messagesRef = new Firebase(App.API_URL + "/chats/#{@id}/messages/") # Get new messages
      @messagesRef.on('child_added', @displayMessage)

    displayMessage: (data, prev) ->
      # Display the message by getting it from Firebase and appending it to the chatroom
      id = data.val()
      messageRef = new Firebase(App.API_URL + "/messages/#{id}")
      view = null
      messageRef.once 'value', (data) -> # Get the message
        data = data.val()
        messageView = new App.Chat.Room.MessageView(data, data)
        messageView.render()
        view = messageView
      @$el.children('.chat-message-area').append(view.$el)

      if view.$el.find('.math').length > 0
        # Delay the rendering of LaTeX to allow the DOM to ready itself
        _.delay(MathJax.Hub.Queue(['Typeset', MathJax.Hub]), 500)

      # Push down the screen
      $(document.documentElement).animate({ scrollTop: $(document).height() }, 1);

    leaveRoom: ->
      id = @id
      roomMemberRef = new Firebase(App.API_URL + "/chats/#{id}/users/") # Reference to members of the chat room
      roomMemberRef.once 'value', (snapshot) ->
        _.each snapshot, (key, val) ->
          if val == App.user
            # Delete user
            roomMemberRef = new Firebase(App.API_URL + "/chats/#{id}/users/#{key}/")
            roomMemberRef.remove()
      $('li.active').remove()
      $('.navbar-nav.nav li a').eq(2).click()

    onEnterRoom: ->
      id = @id
      roomMemberRef = new Firebase(App.API_URL + "/chats/#{id}/users/")
      members = []
      roomMemberRef.once 'value', (snapshot) ->
        members = _.filter _.values(snapshot.val()), (val) ->
          return val == App.User
      if members.length == 0
        roomMemberRef = roomMemberRef.push()
        roomMemberRef.set(App.User)

    sendMessage: ->
      id = @id
      msg = $(@text_area).val()
      messages = new Firebase(App.API_URL + "/messages/")
      chatMessages = new Firebase(App.API_URL + "/chats/#{id}/messages/")
      newMessage = messages.push()
      newMessage.set
        text: msg
        sender: App.User
        time: (new Date).getTime()
      id = newMessage.name()
      chatMessages = chatMessages.push()
      chatMessages.set id
      $(@text_area).val('')

  App
