define (require) ->

  Backbone = require 'backbone'
  templates = require 'templates'
  ImagesCollection = require "collections/images"

  class ApplicationView extends Backbone.View
    template: templates.images
    events:
      'submit form': 'onFilter'
      'click button': 'onFilter'

    initialize: ->
      @imageCollection = Object.create(ImagesCollection::)
      @imageCollection.constructor()
      @imageCollection.fetch()
      @listenTo @imageCollection, 'sync', @render

    render: =>
      @$el.html @template images: @imageCollection
      @delegateEvents()
      @$('.loading').hide()
      @$el

    onFilter: =>
      @imageCollection.width = @$('[name=width]').val()
      @imageCollection.height = @$('[name=height]').val()
      @imageCollection.title = @$('[name=title]').val()
      @imageCollection.user = @$('[name=user]').val()
      @$('.loading').show()
      @$('.data').hide()
      @imageCollection.fetch()
      off

