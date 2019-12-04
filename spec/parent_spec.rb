# frozen_string_literal: true

# rubocop:disable Metrics/BlockLength
RSpec.describe Parent do
  before(:each) do
    @exception = Error::FatalError.new
  end

  context 'bowling' do
    it 'add_attempt' do
      bowling = Parent::Bowling.new
      expect { bowling.add_attempt('Test', 2, 1) }
        .to raise_error(@exception.class, @exception.message)
    end

    it 'format' do
      bowling = Parent::Bowling.new
      expect { bowling.format }
        .to raise_error(@exception.class, @exception.message)
    end
  end

  context 'speaker' do
    it 'execute' do
      prompt = double('prompt')
      speaker = Parent::Speaker.new(prompt)
      expect { speaker.execute }
        .to raise_error(@exception.class, @exception.message)
    end
  end

  context 'custom_error' do
    it 'execute' do
      custom_error = Parent::CustomError.new(:error)
      expect { custom_error.message }
        .to raise_error(@exception.class, @exception.message)
    end
  end
end
# rubocop:enable Metrics/BlockLength
