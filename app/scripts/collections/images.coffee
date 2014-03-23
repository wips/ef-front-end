define (require) ->

  Backbone = require 'backbone'
  Images = require 'models/images'

  class ImagesCollection extends Backbone.Collection
    url: '/index.php/images.json'
    model: Images