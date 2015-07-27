require_relative 'request'
require_relative 'file_handler'
require_relative 'response'

class App
  def initialize
    @request = Request.new
    @file_handler = FileHandler.new
  end

  def handle(string)
    request = @request.parse(string)
    file_handler = FileHandler.new(request[:resource])
    file_handler.handle_file
    return Response.build_header(file_handler)
  end
end
