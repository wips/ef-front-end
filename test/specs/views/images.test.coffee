define (require) ->

  ImagesView = require "views/images"
  ImagesCollection = require "collections/images"

  describe "ImagesView", ->
    sut = null
    create = null

    beforeEach ->
      sut = new ImagesView

    it 'should load data after render', ->
      sut.imageCollection = fetch: env.stub()
      sut.render()
      sut.imageCollection.fetch.should.have.been.called

    describe 'initialize', ->
      instance = null

      beforeEach ->
        instance = constructor: env.stub()
        env.stub(Object, 'create').withArgs(ImagesCollection::).returns instance
        sut = new ImagesView
        Object.create.restore()

      it 'should create images collection', ->
        sut.imageCollection.should.equal instance

      it 'should has link to images collection', ->
        instance.constructor.should.have.been.called