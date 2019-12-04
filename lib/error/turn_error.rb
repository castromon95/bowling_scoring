# frozen_string_literal: true

module Error
  # Error to handle blank player name errors
  class TurnError < Parent::CustomError
    def initialize(line, expected, received)
      super(:error, line)
      @expected = expected
      @received = received
    end

    def message
      "Sorry, it was #{@expected} turn but got #{@received} (line: #{@line})"
    end
  end
end
