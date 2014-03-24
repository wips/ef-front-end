define (require) ->

  Backbone = require 'backbone'
  Images = require 'models/images'

  class ImagesCollection extends Backbone.Collection
    url: '/index.php'
    model: Images
    fetch: ->
      params = {}
      params[name] = @[name] for name in ['width', 'height', 'title', 'user'] when @[name] isnt ''
      Backbone.Collection::fetch.call @,
        data: params
        method: 'POST'