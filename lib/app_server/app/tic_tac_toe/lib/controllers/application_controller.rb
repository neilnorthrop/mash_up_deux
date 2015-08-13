require_relative '../../../../../../lib/app_server/file_handler'
require_relative '../../../../../../lib/app_server/response'
require_relative '../../../../../../lib/app_server/database'
require_relative '../../../../app/tic_tac_toe/lib/player'
require_relative '../../../../app/tic_tac_toe/lib/computer_ai'
require_relative '../../../../app/tic_tac_toe/lib/board'
require_relative '../../../../app/tic_tac_toe/lib/game'
require 'facets'

class ApplicationController
	attr_accessor :params

  def handle(file, opt=nil)
    file = FileHandler.new(file, opt)
    file.handle_file
    return file
  end

  def parse(params)
    if params.include?("&")
      @params = params.split("&").map_send(:split, "=").to_h
    else
      @params = [params.split("=")].to_h || ""
    end
  end

end
