# frozen_string_literal: true

# Model to represent a users bowling line
class BowlingLine < Parent::Bowling
  def initialize
    @chances = []
  end

  def add_attempt(player_name, score, line)
    chance = detect_chance
    if finished_line(chance)
      raise Error::FinishedLineError.new(line, player_name)
    end

    if @chances.empty? || chance.done
      add_chance(player_name, score, line)
    else
      chance.add_attempt(player_name, score, line)
    end
  end

  def format(player_name)
    chance = detect_chance
    raise Error::UnfinishedLineError, player_name unless finished_line(chance)

    format_results
  end

  private

  attr_reader :chances

  def detect_chance
    @chances.last
  end

  def finished_line(chance)
    @chances.length == 10 && chance&.done
  end

  def add_chance(player_name, score, line)
    new_chance = Chance.new(player_name, score, line, @chances.length == 9)
    @chances.push(new_chance)
    new_chance.done
  end

  def format_results
    pinfalls = "\nPins"
    total = 0
    score = "\nScore"
    @chances.each_with_index do |c, index|
      pinfalls += "\t#{c.format}"
      total += ScoringService::ScoreCalculator.new(index, @chances).execute
      score += "\t#{total}\t"
    end
    pinfalls + score
  end
end
