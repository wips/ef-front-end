define (require) ->

  ImagesView = require "views/images"

  describe "Greeting Helper", ->
    sut = null

    beforeEach ->
      sut = new ImagesView

    it 'should load data after render', ->
      sut.imageCollection = fetch: env.stub()
      sut.render()
      sut.imageCollection.fetch.should.have.been.called