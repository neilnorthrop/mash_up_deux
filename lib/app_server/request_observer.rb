class RequestObserver
  def initialize(request)
    @request = request
  end

  def build(string)
    return @request.build(string)
  end
end
