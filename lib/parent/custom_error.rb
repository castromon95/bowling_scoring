# frozen_string_literal: true

module Parent
  # Bowling scoring APP parent error
  class CustomError < StandardError
    attr_reader :kind

    def initialize(kind, line = nil)
      @kind = kind
      @line = line
    end

    def message
      raise Error::FatalError
    end

    private

    attr_reader :line
  end
end
