# frozen_string_literal: true

# Bowling scoring application container
class Application
  attr_writer :prompt

  def start
    file_path = IntroductionService::Initializer.new(prompt).execute
    ScoringService::Formatter.new(prompt, file_path).execute
  rescue Parent::CustomError => e
    Error::ErrorHandler.new(prompt).handle(e)
  rescue StandardError
    Error::ErrorHandler.new(prompt).handle(Error::FatalError.new)
  end

  private

  def prompt
    @prompt ||= TTY::Prompt.new
  end
end
