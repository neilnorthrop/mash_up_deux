require 'json'

class Router
  attr_accessor :routes_path, :loader, :routes

  def initialize(opts={})
    @routes_path = opts[:routes]
    @loader      = opts[:loader]
    @routes      = load_routes
  end

  def load_routes
    JSON.parse(File.read(routes_path), symbolize_names: true)
  end

end
