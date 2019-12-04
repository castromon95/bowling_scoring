# frozen_string_literal: true

module IntroductionService
  # Bowling scoring APP file verifier
  class FileVerifier < Parent::Speaker
    def execute
      verify_path
    end

    private

    attr_accessor :file_path

    def verify_path
      ask_path
      invalid_path unless File.file?(@file_path)

      @file_path
    end

    def ask_path
      question = 'Please insert the absoulte path for the .txt file?'
      @file_path = @prompt.ask(question) do |q|
        q.required(true, 'You must insert a valid path')
        q.validate(/.*\.txt$/, 'File must be .txt extension!')
      end
    end

    def invalid_path
      @prompt.warn("Sorry, the given file path wasn't found (#{@file_path})")
      raise Error::FinishExecutionError unless continue

      verify_path
    end

    def continue
      @prompt.yes?('Do you want to try again?')
    end
  end
end
