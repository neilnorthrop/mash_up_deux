class RequestObserver
  def initialize(app)
    @app = app
  end

  def notify(string)
    return @app.handle(string)
  end
end
