require 'haml'
require_relative 'application_controller'

class BoardController < ApplicationController
  attr_accessor :game, :game_id

  def initialize(params)
    super(params)
  end

  def find_or_create_game
    if @params["game_id"].nil?
      game_id = rand_id
      game = setup_game
      game.add_id(game_id)
      Database.save_game(game, game_id)
      return game
    else
      game = Database.get_game(@params["game_id"])
      return game
    end
  end

  def move(file)
    game = find_or_create_game
    if @params["player_move"].nil?
      body = handle(file, game)
      return Response.build_header(body)
    else
      processing_turn(game, @params)
      body = handle(file, game)
      return Response.build_header(body)
    end
  end

  def rand_id
    "#{rand}"
  end

  def setup_game
    board = Board.new
    player_one = Player.new(WebMover.new, 'X')
    player_two = which_opponent(board, @params["opponent"], player_one)
    game = Game.new(board, player_one, player_two)
    return game
  end

  def which_opponent(board, player, player_one)
    player == 'Computer' ? Player.new(ComputerMover.new(board, player_one.letter), 'O') : Player.new(WebMover.new, 'O')
  end

  def processing_turn(game, turn)
    game.next_move(turn)
    if check_game_over(game) == :draw
      puts "ITS A DRAW"
    else
      p "NOT A DRAW"
      game.toggle_players
      if game.current_player.mover.class == ComputerMover
        game.next_move(turn)
        game.toggle_players
      end
    end
  end

  def check_game_over(game)
    game.board.game_over?
  end
end
