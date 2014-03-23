define (require) ->

  Backbone = require 'backbone'

  class ImagesModel extends Backbone.Model
    parse: (data) ->
      width: data[0]
      height: data[1]
      title: data[2]
      user: data[3]
      url: data[4]