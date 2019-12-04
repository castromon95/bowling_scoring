# frozen_string_literal: true

require 'spec_helper'

RSpec.describe Scoreboard, type: :model do
  before(:each) do
    @scoreboard = Scoreboard.new
  end

  it 'fails with invalid turn' do
    exception = Error::TurnError.new(2, 'Test', 'Test2')
    @scoreboard.add_attempt('Test', '0', nil)
    expect { @scoreboard.add_attempt('Test2', '10', 2) }
      .to raise_error(exception.class, exception.message)
  end

  context 'valid format' do
    it 'perfect line' do
      result = "Frame\t1\t\t2\t\t3\t\t4\t\t5\t\t6\t\t7\t\t8\t\t9\t\t10"\
               "\nTest\nPins\t\tX\t\tX\t\tX\t\tX\t\tX\t\tX\t\tX\t\tX\t\tX\t"\
               "X\tX\tX\nScore\t30\t\t60\t\t90\t\t120\t\t150\t\t180\t\t210"\
               "\t\t240\t\t270\t\t300\t\n"
      12.times do
        @scoreboard.add_attempt('Test', '10', nil)
      end
      expect(@scoreboard.format).to eq(result)
    end
  end
end
