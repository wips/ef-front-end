define (require) ->

  ImagesCollection = require "collections/images"

  describe 'ImagesCollection', ->
    sut = null

    beforeEach ->
      sut = new ImagesCollection

    it 'should have url', ->
      ImagesCollection::url.should.equal '/index.php'

    anEmptyRequest =
      toString: -> 'empty request'

    aPartlyFilledRequest =
      width: 1
      user: 'some url'
      toString: -> 'partly filled request'

    aFullRequest =
      width: 1
      height: 2
      title: 'some title'
      user: 'some url'
      toString: -> 'full request'

    requests = [anEmptyRequest, aPartlyFilledRequest, aFullRequest]

    usingValuesIt 'should pass filer to back-end', requests, (request) ->
      sut[parameter] = value for parameter, value of request
      call = env.stub Backbone.Collection::fetch, 'call'
      sut.fetch()
      call.should.have.been.calledWith sut, sinon.match data: assembleParams request

    it 'should use correct method', ->
      call = env.stub Backbone.Collection::fetch, 'call'
      sut.fetch()
      call.should.have.been.calledWith sut, sinon.match method: 'POST'

    assembleParams = (request) ->
      result = {}
      result[parameter] = value for parameter, value of request when value isnt '' and typeof value isnt 'function'
      result