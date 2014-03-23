define (require) ->

  Backbone = require 'backbone'
  Images = require 'models/images'

  class ImagesCollection extends Backbone.Collection
    model: Images