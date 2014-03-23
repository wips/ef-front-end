define (require) ->

  Backbone = require 'backbone'
  templates = require 'templates'
  ImagesCollection = require "collections/images"

  class ApplicationView extends Backbone.View
    template: templates.images
    initialize: ->
      @imageCollection = Object.create(ImagesCollection::)
      @imageCollection.constructor()
    render: ->
      @.$el.html @template()
      @imageCollection.fetch()
