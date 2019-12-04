# frozen_string_literal: true

module IntroductionService
  # Bowling scoring APP initializer
  class Introducer < Parent::Speaker
    def execute
      introduction
      raise Error::FinishExecutionError unless validate
    end

    private

    def introduction
      @prompt.ok('Welcome to de Bowling Scoring APP!')
      @prompt.warn("You're currently running v#{BowlingScoring::VERSION}")
    end

    def validate
      @prompt.yes?('Do you want to continue?')
    end
  end
end
