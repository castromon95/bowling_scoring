# frozen_string_literal: true

module Error
  # Error to handle adding attempts to finished lines errors
  class UnfinishedLineError < Parent::CustomError
    def initialize(player_name)
      super(:error)
      @player_name = player_name
    end

    def message
      "Sorry, the player #{@player_name} didn't finish his bowling line"
    end
  end
end
