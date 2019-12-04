# frozen_string_literal: true

module Parent
  # Parent class for those that prompt to user
  class Speaker
    def initialize(prompt)
      @prompt = prompt
    end

    def execute
      raise Error::FatalError
    end

    private

    attr_reader :prompt
  end
end
