# frozen_string_literal: true

# Model to represent a users bowling chance
class Attempt < Parent::Bowling
  attr_reader :score
  attr_reader :number

  def initialize(player_name, score, line, number)
    @number = number
    add_attemp(player_name, score, line)
  end

  def format(previous, last_chance)
    if strike?(previous, last_chance)
      last_chance ? 'X' : "\tX"
    elsif spare?(previous, last_chance)
      '/'
    else
      representation
    end
  end

  private

  attr_reader :representation

  def add_attemp(player_name, score, line)
    unless valid_score?(score)
      raise Error::InvalidAttemptError.new(line, player_name, score)
    end

    @score = score.to_i
    @representation = zero_value?(score) ? '-' : score.gsub("\n", '')
  end

  def zero_value?(score)
    @score.zero? && score.gsub("\n", '') != 'F'
  end

  def valid_score?(score)
    numeric?(score) || score.gsub("\n", '') == 'F'
  end

  def numeric?(score)
    score.match?(/^[0-9]+$/) && score.to_i >= 0 && score.to_i <= 10
  end

  def strike?(previous, last_chance)
    (@number != 2 || (last_chance && previous.score == 10)) && score == 10
  end

  def spare?(previous, last_chance)
    previous && ((!last_chance && previous.score + @score == 10) ||
      (last_chance && previous.score + score == 10 && previous.score != 10))
  end
end
