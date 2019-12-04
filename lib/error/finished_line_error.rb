# frozen_string_literal: true

module Error
  # Error to handle adding attempts to finished lines errors
  class FinishedLineError < Parent::CustomError
    def initialize(line, player_name)
      super(:error, line)
      @player_name = player_name
    end

    def message
      "Sorry, the player #{@player_name} already finished his "\
      "chances (line: #{@line})"
    end
  end
end
