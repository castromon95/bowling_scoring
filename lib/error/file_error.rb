# frozen_string_literal: true

module Error
  # Error to handle unexpected Bowling scoring APP errors
  class FileError < Parent::CustomError
    def initialize(path)
      super(:warn)
      @path = path
    end

    def message
      "Sorry, the given absolute path wasn't found (#{@path})"
    end
  end
end
