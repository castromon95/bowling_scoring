# frozen_string_literal: true

require 'spec_helper'

RSpec.describe ScoringService::Formatter, type: :model do
  context 'strike calculations' do
    before(:each) do
      @scoreboard = Scoreboard.new
      @prompt = double('prompt')
      @path = 'test/test.txt'
      @formatter = ScoringService::Formatter.new(@prompt, @path)
    end

    it 'formats' do
      12.times do
        @scoreboard.add_attempt('Test', '10', nil)
      end
      file = StringIO.new("Test\t10\nTest\t10\nTest\t10\nTest\t10\nTest\t10\n"\
             "Test\t10\nTest\t10\nTest\t10\nTest\t10\nTest\t10\n"\
             "Test\t10\nTest\t10")
      allow(File).to receive(:open).with(@path, 'r').and_yield(file)
      expect(@prompt).to receive(:say).with(@scoreboard.format)
      @formatter.execute
    end
  end
end
