# frozen_string_literal: true

module ScoringService
  # Bowling scoring APP score calculator
  class ScoreCalculator
    def initialize(index, chances)
      @index = index
      @chances = chances
    end

    def execute
      if @chances[@index].strike?
        strike_calculation
      elsif @chances[@index].spare?
        spare_calculation
      else
        @chances[@index].total
      end
    end

    private

    def spare_calculation
      if @chances[@index].last_chance
        10 + @chances[@index].detect_attempt(3).score
      elsif strike?(@index + 1)
        20
      else
        10 + @chances[@index + 1].detect_attempt(1).score
      end
    end

    def strike_calculation
      if triple_strike?
        30
      elsif double_strike?
        20 + strike_second_value?(@index + 2)
      elsif @chances[@index].last_chance
        last_chance_strike
      else
        single_strike_calculation
      end
    end

    def single_strike_calculation
      if @index == 8
        10 + @chances[9].detect_attempt(1).score +
          @chances[9].detect_attempt(2).score
      else
        10 + @chances[@index + 1].total
      end
    end

    def triple_strike?
      strike?(@index + 1) && strike?(@index + 2)
    end

    def double_strike?
      strike?(@index + 1)
    end

    def last_chance_strike
      10 + strike_second_value?(10) + strike_second_value?(11)
    end

    def strike?(ind)
      if ind < 9
        @chances[ind].strike?
      else
        @chances[9].detect_attempt(ind - 8).score == 10
      end
    end

    def strike_second_value?(ind)
      if ind < 9
        @chances[ind].detect_attempt(1).score
      else
        @chances[9].detect_attempt(ind - 8).score
      end
    end
  end
end
