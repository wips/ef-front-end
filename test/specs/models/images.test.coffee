define (require) ->

  ImagesModel = require "models/images"

  describe 'ImagesModel', ->
    sut = null

    beforeEach ->
      sut = new ImagesModel

    it 'should parse response', ->
      data = ['width', 'height', 'title', 'user', 'url']
      expected =
        width: data[0]
        height: data[1]
        title: data[2]
        user: data[3]
        url: data[4]
      JSON.stringify(sut.parse(data)).should.equal JSON.stringify expected