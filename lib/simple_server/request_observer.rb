require_relative '../app_server/request'

class RequestObserver
  def initialize(request=Request.new)
    @request = request
  end

  def build(string)
    return @request.build(string)
  end
end
