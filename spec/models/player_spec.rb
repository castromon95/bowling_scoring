# frozen_string_literal: true

require 'spec_helper'

# rubocop:disable Metrics/BlockLength
RSpec.describe Player, type: :model do
  before(:each) do
    @player = Player.new('Test', 1)
  end

  context 'creation' do
    it 'registered?' do
      expect(@player.registered?).to be_falsey
    end

    it 'turn' do
      expect(@player.turn).to eq(1)
    end

    it 'name' do
      expect(@player.name).to eq('Test')
    end

    it 'by_name?' do
      expect(@player.by_name?('TEST')).to be_truthy
    end

    it 'fails with invalida name' do
      exception = Error::PlayerNameError.new
      expect { Player.new('', 2) }
        .to raise_error(exception.class, exception.message)
    end
  end

  context 'valid format' do
    it 'perfect line' do
      result = "\nTest\nPins\t\tX\t\tX\t\tX\t\tX\t\tX\t\tX\t\tX\t\tX\t\tX\tX"\
               "\tX\tX\nScore\t30\t\t60\t\t90\t\t120\t\t150\t\t180\t\t210\t"\
               "\t240\t\t270\t\t300\t"
      12.times do
        @player.add_attempt('Test', '10', nil)
      end
      expect(@player.format).to eq(result)
    end
  end
end
# rubocop:enable Metrics/BlockLength
