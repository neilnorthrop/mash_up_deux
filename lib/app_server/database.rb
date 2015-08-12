class Database
  $games = {}

  def self.get_game(id)
    return $games[id]
  end

  def self.save_game(game, id)
    $games[id] = game
  end

  def self.clear_database
    $games.clear
  end

end
