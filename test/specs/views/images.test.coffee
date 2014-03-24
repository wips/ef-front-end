define (require) ->

  ImagesView = require "views/images"
  ImagesCollection = require 'collections/images'

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

    describe 'on filter', ->
      show = null
      hide = null
      $ = null

      beforeEach ->
        show = env.stub()
        hide = env.stub()
        anyValue = env.stub()
        $ = env.stub sut, '$'
        $.withArgs('.loading').returns show: show
        $.withArgs('.data').returns hide: hide
        $.withArgs('[name=width]').returns val: anyValue
        $.withArgs('[name=height]').returns val: anyValue
        $.withArgs('[name=title]').returns val: anyValue
        $.withArgs('[name=user]').returns val: anyValue

      it 'should show data loader', ->
        sut.onFilter()
        show.should.have.been.called

      it 'should hide data', ->
        sut.onFilter()
        hide.should.have.been.called

      it 'should not reaload page on submit', ->
        sut.onFilter().should.equal off

      usingValuesIt 'should set params', ['width', 'height', 'title', 'user'], (name) ->
        value = 'some val'
        $.withArgs("[name=#{name}]").returns val: env.stub().returns value
        sut.onFilter()
        sut.imageCollection[name].should.equal value

    describe 'events', ->

      it 'should handle submit', ->
        sut.events['submit form'].should.equal 'onFilter'

    describe 'render', ->

      it 'should hide loading', ->
        hide = env.stub()
        env.stub(sut, '$').withArgs('.loading').returns hide: hide
        sut.render()
        hide.should.have.been.called

      it 'should pass data to template', ->
        env.stub sut, 'template'
        sut.render()
        sut.template.should.have.been.calledWith sinon.match images: instance

      it 'should update HTML', ->
        html = 'some markup'
        env.stub sut.$el, 'html'
        env.stub(sut, 'template').withArgs(sinon.match images: instance).returns html
        sut.render()
        sut.$el.html.should.have.been.calledWith html

      it 'should delegate events after template is rendered', ->
        env.stub sut, 'delegateEvents'
        env.stub sut.$el, 'html'
        sut.render()
        sut.delegateEvents.should.have.been.calledAfter sut.$el.html

      it 'should return rendered element', ->
        sut.render().should.equal sut.$el

    describe 'initialize', ->

      it 'should create images collection', ->
        sut.imageCollection.should.equal instance

      it 'should has link to images collection', ->
        instance.constructor.should.have.been.called

      it 'should load data', ->
        instance.fetch.should.have.been.called

      it 'should render itsef on data fetch', ->
        listenTo.should.have.been.calledWith instance, 'sync', sut.render