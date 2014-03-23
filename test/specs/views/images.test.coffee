define (require) ->

  ImagesView = require "views/images"
  ImagesCollection = require "collections/images"

  describe "ImagesView", ->
    sut = null
    create = null

    beforeEach ->
#      sut = new ImagesView

    describe 'render', ->

    describe 'initialize', ->
      instance = null
      listenTo = null

      beforeEach ->
        instance =
          constructor: env.stub()
          fetch: env.stub()
        env.stub(Object, 'create').withArgs(ImagesCollection::).returns instance
        listenTo = env.stub ImagesView::, 'listenTo'
        sut = new ImagesView
        Object.create.restore()

      it 'should create images collection', ->
        sut.imageCollection.should.equal instance

      it 'should has link to images collection', ->
        instance.constructor.should.have.been.called

      it 'should load data', ->
        instance.fetch.should.have.been.called

      it 'should render itsef on data fetch', ->
        listenTo.should.have.been.calledWith instance, 'sync', sut.render