require_relative 'request'
require_relative 'file_handler'
require_relative 'router'
require_relative './app/tic_tac_toe/lib/player'
require_relative './app/tic_tac_toe/lib/computer_ai'
require_relative './app/tic_tac_toe/lib/board'
require_relative './app/tic_tac_toe/lib/game'

class Database
  def self.get_game(id)
  end

  def self.save_game(game, id)
  end

  @@games = {}
end

class App
  attr_accessor :router

  def initialize
    @router = Router.new
  end

  def handle(string)
    request = Request.new.parse(string)
    controller = @router.get_controller(request)
    method = @router.get_method(request)
    response = controller.new(request[:params]).call(method)
    return response
  end

  def setup_game
    board = Board.new
    player_one = Player.new(WebMover.new, 'X')
    player_two = ComputerMover.new(board, player_one.letter)
    game = Game.new(board, player_one, player_two)
    return game
  end

  def processing_turn(turn)
    game.next_move(turn)
    game.toggle_players
    if game.current_player.class == ComputerMover
      game.next_move(turn)
      game.toggle_players
    end
  end

  def check_game_over
    if game.board.game_over?
      game = setup_game
    end
  end
end
