# frozen_string_literal: true

module Error
  # Error to handle invalid chance errors
  class InvalidChanceError < Parent::CustomError
    def initialize(line, player_name, total)
      super(:error, line)
      @player_name = player_name
      @total = total
    end

    def message
      "Sorry, #{@player_name} chance is invalid. A player can sum a maximum "\
      "of 10 pins per chance and he got #{@total} (line: #{@line})"
    end
  end
end
