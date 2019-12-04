# frozen_string_literal: true

require 'spec_helper'

# rubocop:disable Metrics/BlockLength
RSpec.describe BowlingLine, type: :model do
  before(:each) do
    @bowling_line = BowlingLine.new
  end

  def finished_line(perfect = true)
    exception = Error::FinishedLineError.new(2, 'Test')
    complete_line(perfect)
    expect { @bowling_line.add_attempt('Test', 'F', 2) }
      .to raise_error(exception.class, exception.message)
  end

  def complete_line(perfect = true)
    number = perfect ? 12 : 20
    number.times do |x|
      @bowling_line.add_attempt('Test', perfect ? '10' : 'F', x)
    end
  end

  context 'add attempt' do
    it 'add attempts' do
      expect(@bowling_line.add_attempt('Test', '5', nil)).to be_falsey
      expect(@bowling_line.add_attempt('Test', '5', nil)).to be_truthy
    end

    it 'fails on blank finished line' do
      finished_line(false)
    end

    it 'fails on perfect finished line' do
      finished_line
    end
  end

  context 'valid format' do
    it 'error for unfinished lines' do
      exception = Error::UnfinishedLineError.new('Test')
      expect { @bowling_line.format('Test') }
        .to raise_error(exception.class, exception.message)
    end

    it 'perfect line' do
      result = "\nPins\t\tX\t\tX\t\tX\t\tX\t\tX\t\tX\t\tX\t\tX\t\tX\tX\tX\tX\n"\
               "Score\t30\t\t60\t\t90\t\t120\t\t150\t\t180\t\t210\t\t240"\
               "\t\t270\t\t300\t"
      complete_line
      expect(@bowling_line.format('Test')).to eq(result)
    end

    it 'blank line' do
      result = "\nPins\tF\tF\tF\tF\tF\tF\tF\tF\tF\tF\tF\tF\tF\tF\tF\tF\tF\tF"\
               "\tF\tF\nScore\t0\t\t0\t\t0\t\t0\t\t0\t\t0\t\t0\t\t0\t\t0\t\t0\t"
      complete_line(false)
      expect(@bowling_line.format('Test')).to eq(result)
    end
  end
end
# rubocop:enable Metrics/BlockLength
