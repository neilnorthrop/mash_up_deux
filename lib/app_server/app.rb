require_relative 'request'
require_relative 'router'

class App
  attr_accessor :router

  def initialize
    @router = Router.new
  end

  def handle(string)
    request = Request.new.parse(string)
    response = @router.route(request)
    return response
  end

end
