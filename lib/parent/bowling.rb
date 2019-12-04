# frozen_string_literal: true

module Parent
  # Parent class for bowling items
  class Bowling
    def add_attempt(_player_name, _score, _line)
      raise Error::FatalError
    end

    def format(*_args)
      raise Error::FatalError
    end

    private

    attr_reader :prompt
  end
end
