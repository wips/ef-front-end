define (require) ->

  ImagesCollection = require "collections/images"

  describe 'ImagesCollection', ->
    sut = null

    beforeEach ->
      sut = new ImagesCollection

    it 'should have url', ->
      ImagesCollection::url.should.equal '/index.php/images.json'