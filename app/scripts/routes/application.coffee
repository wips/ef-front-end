define (require) ->

  Backbone = require 'backbone'
  ImagesView = require 'views/images'

  class ApplicationRouter extends Backbone.Router

    routes:
      '*path': 'defaultRoute'

    defaultRoute: ->
      @view = new ImagesView()
      $('#main').html @view.render()