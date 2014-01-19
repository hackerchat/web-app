define [
  'models/users',
  'models/rooms',
  'models/messages',
  'firebase',
  'underscore',
  'exports'
], (Users, Rooms, Messages, Firebase, _, exports) ->

  _.extend(exports, Users, Rooms, Messages)

  exports
