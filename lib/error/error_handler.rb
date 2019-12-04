# frozen_string_literal: true

module Error
  # Centralized bowling scoring APP custom error handler
  class ErrorHandler < Parent::Speaker
    def handle(error)
      @prompt.send(error.kind, error.message)
    end
  end
end
