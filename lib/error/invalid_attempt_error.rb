# frozen_string_literal: true

module Error
  # Error to handle invalid attempt value errors
  class InvalidAttemptError < Parent::CustomError
    def initialize(line, player_name, value)
      super(:error, line)
      @player_name = player_name
      @value = value
    end

    def message
      "Sorry, #{@player_name} attempt is invalid. Only numeric values from "\
      "0 to 10 or an F are valid. Got a '#{@value}' character (line: #{@line})"
    end
  end
end
