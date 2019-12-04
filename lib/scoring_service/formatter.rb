# frozen_string_literal: true

module ScoringService
  # Bowling scoring APP score formatter
  class Formatter < Parent::Speaker
    def initialize(prompt, file_path)
      super(prompt)
      @file_path = file_path
    end

    def execute
      File.open(@file_path, 'r') do |f|
        f.each_line.with_index do |line, index|
          attepmt = line.split(/\t/)
          scoreboard.add_attempt(attepmt[0], attepmt[1], index + 1)
        end
        @prompt.say(scoreboard.format)
      end
    end

    private

    def scoreboard
      @scoreboard ||= Scoreboard.new
    end
  end
end
