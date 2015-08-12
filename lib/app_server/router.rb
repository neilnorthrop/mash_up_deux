require 'json'
require_relative 'class_loader'

class Router
  attr_accessor :loaded_routes, :loader, :routes

  def initialize
    @loaded_routes = JSON.parse(File.read(Dir.pwd + '/lib/app_server/config/routes.json'), symbolize_names: true)
    @routes        = load_classes
  end

  def load_classes
    class_loader = ClassLoader.new('/lib/app_server/app/tic_tac_toe/lib/controllers/')
    class_loader.run
    return class_loader
  end

  def get_controller(request)
    method = request[:method].to_sym
    routes = loaded_routes[method]
    controller = routes[:controller]
    return controller
  end

  def get_method(request)
    method = request[:method].to_sym
    routes = loaded_routes[method]
    method = routes[:method]
    return method
  end

  def route(request)
    controller = get_controller(request)
    method = get_method(request)
    return Object.const_get(controller).new(request[:params]).send(method, request[:resource])
  end

end
