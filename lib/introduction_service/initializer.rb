# frozen_string_literal: true

module IntroductionService
  # Bowling scoring APP initializer
  class Initializer < Parent::Speaker
    def execute
      IntroductionService::Introducer.new(@prompt).execute
      IntroductionService::FileVerifier.new(@prompt).execute
    end
  end
end
