define (require) ->

  Backbone = require 'backbone'
  templates = require 'templates'

  class ApplicationView extends Backbone.View
    template: templates.images
    render: ->
      @.$el.html @template()
      @imageCollection.fetch()
