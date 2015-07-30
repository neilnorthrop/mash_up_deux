class Router
  attr_accessor :routes_path, :loader

  def initialize(opts={})
    @routes_path = opts[:routes]
    @loader      = opts[:loader]
  end
end
