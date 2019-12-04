# frozen_string_literal: true

# Model to represent a scoreboard player
class Player < Parent::Bowling
  attr_reader :name
  attr_reader :turn

  def initialize(name, turn)
    raise Error::PlayerNameError if name.to_s.empty?

    @name = name
    @turn = turn
  end

  def add_attempt(player_name, score, line)
    bowling_line.add_attempt(player_name, score, line)
  end

  def registered?
    @bowling_line
  end

  def by_name?(input_name)
    @name.downcase == input_name&.downcase
  end

  def format
    "\n#{@name}#{bowling_line.format(@name)}"
  end

  private

  def bowling_line
    @bowling_line ||= BowlingLine.new
  end
end
