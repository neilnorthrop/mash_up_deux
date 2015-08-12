require 'json'
require_relative 'file_handler'
require_relative 'class_loader'

class Router
  attr_accessor :routes_path, :loader, :routes

  def initialize(opts={})
    @routes_path = './lib/app_server/config/routes.json'
    @routes      = load_class_loader
  end

  def load_class_loader
    class_loader = ClassLoader.new('/lib/app_server/app/tic_tac_toe/lib/controllers/')
    class_loader.run
    return class_loader
  end

  def load_routes
    JSON.parse(File.read(routes_path), symbolize_names: true)
  end

  def route(request)
    file = FileHandler.new(request[:resource])
    file.handle_file
    return Response.build_header(file)
  end

end
