define (require) ->

  ImagesView = require "views/images"
  ImagesCollection = require "collections/images"

  describe "ImagesView", ->
    sut = null
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

    describe 'render', ->

      it 'should pass data to template', ->
        env.stub sut, 'template'
        sut.render()
        sut.template.should.have.been.calledWith sinon.match images: instance

      it 'should update HTML', ->
        html = 'some markup'
        env.stub(sut.$el, 'html')
        env.stub(sut, 'template').withArgs(sinon.match images: instance).returns html
        sut.render()
        sut.$el.html.should.have.been.calledWith html

    describe 'initialize', ->

      it 'should create images collection', ->
        sut.imageCollection.should.equal instance

      it 'should has link to images collection', ->
        instance.constructor.should.have.been.called

      it 'should load data', ->
        instance.fetch.should.have.been.called
        #With sinon.match method: 'POST'

      it 'should render itsef on data fetch', ->
        listenTo.should.have.been.calledWith instance, 'sync', sut.render