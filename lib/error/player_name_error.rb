# frozen_string_literal: true

module Error
  # Error to handle blank player name errors
  class PlayerNameError < Parent::CustomError
    def initialize
      super(:error)
    end

    def message
      "Sorry, the player name can't be blank"
    end

    private

    attr_accessor :path
  end
end
