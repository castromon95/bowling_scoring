# frozen_string_literal: true

require 'spec_helper'

# rubocop:disable Metrics/BlockLength
RSpec.describe Attempt, type: :model do
  context 'creation' do
    def expect_exception(score)
      exception = Error::InvalidAttemptError.new(2, 'Test', score)
      expect { Attempt.new('Test', score, 2, 1) }
        .to raise_error(exception.class, exception.message)
    end

    it 'fails with invalid number greater than 10' do
      expect_exception('11')
    end

    it 'fails with invalid non positive integer number' do
      expect_exception('-1')
    end

    it 'fails with invalid non numeric value' do
      expect_exception('A')
    end
  end

  context 'format shows' do
    def expected_format(score, format = nil, last = false, num = 1, prev = nil)
      expect(Attempt.new('Test', score, nil, num)
        .format(prev, last)).to eq(format || score)
    end

    def previous(score)
      Attempt.new('Previous', score, nil, 1)
    end

    it 'valid Foul' do
      expected_format('F')
    end

    it 'valid 0 value' do
      expected_format('0', '-')
    end

    it 'valid value value' do
      expected_format('5')
    end

    it 'valid strike' do
      expected_format('10', "\tX")
    end

    it 'valid last chance first strike' do
      expected_format('10', 'X', true)
    end

    it 'valid last chance second strike' do
      expected_format('10', 'X', true, 2, previous('10'))
    end

    it 'valid last chance third strike' do
      expected_format('10', 'X', true, 3)
    end

    it 'valid spare' do
      expected_format('5', '/', false, 2, previous('5'))
    end

    it 'valid last chance spare' do
      expected_format('10', '/', true, 2, previous('0'))
    end

    it 'invalid last chance spare' do
      expected_format('0', '-', true, 2, previous('10'))
    end
  end
end
# rubocop:enable Metrics/BlockLength
