# frozen_string_literal: true

module Error
  # Error to handle unexpected Bowling scoring APP errors
  class FatalError < Parent::CustomError
    def initialize
      super(:error)
    end

    def message
      'An unexpected error has occured, please contact '\
      "#{BowlingScoring::AUTHORS.first} via email "\
      "(#{BowlingScoring::EMAILS.first}) for technical support"
    end
  end
end
