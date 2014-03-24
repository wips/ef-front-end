define (require) ->

  Method = require 'routes/Method'

  describe 'Method', ->
    sut = null

    beforeEach ->
      sut = (Method::)

    it 'should be POST for real', ->
      env.stub(sut, 'isFake').returns no
      sut.define().should.equal 'POST'

    it 'should be GET for fake', ->
      env.stub(sut, 'isFake').returns yes
      sut.define().should.equal 'GET'

    it 'should work in fake mode if port 9000 is used', ->
      sut.isFake().should.equal (-1 isnt window.location.host.indexOf ':9000')