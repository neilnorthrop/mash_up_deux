require 'haml'
require_relative 'application_controller'

class GameController < ApplicationController

  def initialize(params)
    super(params)
  end

	def run(file)
		body = handle(file)
		return Response.build_header(body)
	end
end
