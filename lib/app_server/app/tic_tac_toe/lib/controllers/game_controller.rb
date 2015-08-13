require 'haml'
require_relative 'application_controller'

class GameController < ApplicationController

	def run(file)
		body = handle(file)
		return Response.build_header(body)
	end
end
