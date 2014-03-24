define ->

  class Method

  Method::isFake = -> -1 isnt window.location.host.indexOf ':9000'
  Method::define = -> if @isFake() then 'GET' else 'POST'

  Method