# frozen_string_literal: true

module Error
  # Error to handle voluntary execution termination
  class FinishExecutionError < Parent::CustomError
    def initialize
      super(:ok)
    end

    def message
      'Application successfully terminated (: Hope to see you soon!'
    end
  end
end
