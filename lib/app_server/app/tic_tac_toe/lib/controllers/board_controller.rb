require 'haml'
require_relative 'application_controller'

class BoardController < ApplicationController
	def run(board)
    id = @params[:game]
		body = Haml::Engine.new(File.read('../views/board.haml')).render(Object.new, :board => board)
		return body
	end
end
