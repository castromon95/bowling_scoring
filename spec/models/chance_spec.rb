# frozen_string_literal: true

require 'spec_helper'

# rubocop:disable Metrics/BlockLength
RSpec.describe Chance, type: :model do
  def create(score, last, line = 2, name = 'Test')
    Chance.new(name, score, line, last)
  end

  def create_exception(total, line, name)
    Error::InvalidChanceError.new(line, name, total)
  end

  context 'creation' do
    it 'is valid without strike' do
      chance = create('5', false)
      expect(chance.last_chance).to be_falsey
      expect(chance.done).to be_falsey
    end

    it 'is done with a strike (not last chance)' do
      chance = create('10', false)
      expect(chance.last_chance).to be_falsey
      expect(chance.done).to be_truthy
      expect(chance.strike?).to be_truthy
    end

    it 'is valid with a strike (last chance)' do
      chance = create('10', true)
      expect(chance.last_chance).to be_truthy
      expect(chance.done).to be_falsey
      expect(chance.strike?).to be_truthy
    end
  end

  context 'add attempt' do
    it 'fails with invalid value over 10 pins (not last chance)' do
      chance = create('5', false, 2, 'Test')
      exception = create_exception('11', 2, 'Test')
      expect { chance.add_attempt('Test', '6', 2) }
        .to raise_error(exception.class, exception.message)
    end

    it 'is done after second shot (not last chance)' do
      chance = create('5', false)
      expect(chance.add_attempt('Test', '5', nil)).to be_truthy
      expect(chance.total).to eq(10)
      expect(chance.spare?).to be_truthy
    end

    it 'does not allow third shot without spare or strike (last chance)' do
      chance = create('5', true)
      expect(chance.add_attempt('Test', '4', nil)).to be_truthy
      expect(chance.total).to eq(9)
    end

    it 'allows third shot with spare (last chance)' do
      chance = create('5', true)
      expect(chance.add_attempt('Test', '5', nil)).to be_falsey
      expect(chance.add_attempt('Test', '5', nil)).to be_truthy
      expect(chance.total).to eq(15)
      expect(chance.spare?).to be_truthy
    end

    it 'allows third shot with strike (last chance)' do
      chance = create('10', true)
      expect(chance.add_attempt('Test', '0', nil)).to be_falsey
      expect(chance.add_attempt('Test', '5', nil)).to be_truthy
      expect(chance.total).to eq(15)
      expect(chance.detect_attempt(1).score).to eq(10)
      expect(chance.detect_attempt(2).score).to eq(0)
      expect(chance.detect_attempt(3).score).to eq(5)
    end
  end

  context 'valid format' do
    it 'strike shot (not last chance)' do
      chance = create('10', false)
      expect(chance.format).to eq("\tX")
    end

    it 'spare shot (not last chance)' do
      chance = create('F', false)
      chance.add_attempt('Test', '10', nil)
      expect(chance.format).to eq("F\t/")
    end

    it 'strike shot (last chance)' do
      chance = create('10', true)
      chance.add_attempt('Test', 'F', nil)
      chance.add_attempt('Test', '10', nil)
      expect(chance.format).to eq("X\tF\tX")
    end

    it 'spare shot (last chance)' do
      chance = create('0', true)
      chance.add_attempt('Test', '10', nil)
      chance.add_attempt('Test', 'F', nil)
      expect(chance.format).to eq("-\t/\tF")
    end
  end
end
# rubocop:enable Metrics/BlockLength
