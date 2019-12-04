# frozen_string_literal: true

# Model to represent a users bowling chance
class Chance < Parent::Bowling
  attr_reader :done
  attr_reader :last_chance

  def initialize(player_name, score, line, last_chance)
    @attempts = [Attempt.new(player_name, score, line, 1)]
    @last_chance = last_chance
    @done = define_done
  end

  def add_attempt(player_name, score, line)
    @attempts.push(Attempt.new(player_name, score, line, @attempts.length + 1))

    if !@last_chance && total > 10
      raise Error::InvalidChanceError.new(line, player_name, total)
    end

    @done = define_done
  end

  def total
    @attempts.inject(0) { |sum, attempt| sum + attempt.score }
  end

  def format
    result = @attempts.map do |attempt|
      attempt.format(detect_previous(attempt), @last_chance)
    end
    result.join("\t")
  end

  def strike?
    (!@last_chance && total == 10 && @attempts.length == 1) ||
      (@last_chance && detect_attempt(1).score == 10)
  end

  def spare?
    (!@last_chance && total == 10 && @attempts.length == 2) ||
      (@last_chance &&
      (detect_attempt(1).score + detect_attempt(2).score) == 10)
  end

  def detect_attempt(number)
    @attempts.detect { |attempt| attempt.number == number }
  end

  private

  def define_done
    chance_done || last_chance_done
  end

  def chance_done
    !@last_chance && (@attempts.length == 2 || total == 10)
  end

  def last_chance_done
    @last_chance &&
      (@attempts.length == 3 || (@attempts.length == 2 && total < 10))
  end

  def detect_previous(attempt)
    return if attempt.number == 1

    detect_attempt(attempt.number - 1)
  end
end
