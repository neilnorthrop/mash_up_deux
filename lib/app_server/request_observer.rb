class RequestObserver
  def initialize(app)
    @app = app
  end

  def build(string)
    return @app.handle(string)
  end
end
