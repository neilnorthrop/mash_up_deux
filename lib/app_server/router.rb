require 'json'
require_relative 'response'
require_relative 'class_loader'

class Router
  attr_accessor :routes_path, :loader, :routes

  def initialize
    @routes_path = './lib/app_server/config/routes.json'
    @routes      = load_classes
  end

  def load_classes
    class_loader = ClassLoader.new('/lib/app_server/app/tic_tac_toe/lib/controllers/')
    class_loader.run
    return class_loader
  end

  def load_routes
    JSON.parse(File.read(routes_path), symbolize_names: true)
  end

  def route(request)
    return Response.build_header(file)
  end

end
