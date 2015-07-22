require 'minitest/autorun'
require 'minitest/unit'
require './lib/app_server/tic_tac_toe/lib/board'
require './lib/app_server/tic_tac_toe/lib/computer_ai'
require './lib/app_server/tic_tac_toe/lib/player'

class TestConsoleMover < Minitest::Test
  def setup
    @board = Board.new
  end

  class StubIn
    attr_reader :input

    def initialize(input)
      @input = input
    end

    def gets
      @input.shift
    end
  end

  def test_that_listen_gets_integers_from_input
    stubin = StubIn.new(['4.3', 'asdf', '5', "6\n", "092834\t"])
    console = ConsoleMover.new(stubin)
    assert_equal console.get_move, 4
    assert_equal console.get_move, 0
    assert_equal console.get_move, 5
    assert_equal console.get_move, 6
    assert_equal console.get_move, 92_834
  end
end
