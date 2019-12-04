# frozen_string_literal: true

require 'spec_helper'

# rubocop:disable Metrics/BlockLength
RSpec.describe ScoringService::ScoreCalculator, type: :model do
  before(:each) do
    @chances = []
  end

  def chances(num)
    @chances = Array.new(num, Chance.new('Test', '10', nil, false))
  end

  def default_chances(num)
    num.times do
      chance = Chance.new('Test', '5', nil, false)
      chance.add_attempt('Test', '5', nil)
      @chances.push(chance)
    end
  end

  def add_chances(num)
    @chances += Array.new(num, Chance.new('Test', '10', nil, false))
  end

  def last_chance(atp3 = '10', atp2 = '10', atp1 = '10')
    last_chance = Chance.new('Test', atp1, nil, true)
    last_chance.add_attempt('Test', atp2, nil)
    last_chance.add_attempt('Test', atp3, nil) if atp3
    @chances.push(last_chance)
  end

  context 'strike calculations' do
    it 'triple strike' do
      chances(9)
      last_chance
      expect(ScoringService::ScoreCalculator.new(9, @chances).execute)
        .to eq(30)
      expect(ScoringService::ScoreCalculator.new(7, @chances).execute)
        .to eq(30)
    end

    it 'double strike' do
      chances(5)
      chance = Chance.new('Test', '5', nil, true)
      chance.add_attempt('Test', '5', nil)
      @chances.push(chance)
      add_chances(3)
      last_chance('5')
      expect(ScoringService::ScoreCalculator.new(9, @chances).execute)
        .to eq(25)
      expect(ScoringService::ScoreCalculator.new(3, @chances).execute)
        .to eq(25)
    end

    it 'last chance strike' do
      chances(9)
      last_chance('5', '5')
      expect(ScoringService::ScoreCalculator.new(9, @chances).execute)
        .to eq(20)
    end

    it 'single strike' do
      chances(5)
      chance = Chance.new('Test', '5', nil, true)
      chance.add_attempt('Test', '5', nil)
      @chances.push(chance)
      add_chances(3)
      last_chance(nil, 'F', 'F')
      expect(ScoringService::ScoreCalculator.new(4, @chances).execute)
        .to eq(20)
      expect(ScoringService::ScoreCalculator.new(8, @chances).execute)
        .to eq(10)
    end
  end

  context 'spare calculations' do
    it 'last chance' do
      default_chances(9)
      last_chance('5', '10', '0')
      expect(ScoringService::ScoreCalculator.new(9, @chances).execute)
        .to eq(15)
    end

    it 'next chance is strike' do
      default_chances(2)
      @chances.push(Chance.new('Test', '10', nil, false))
      expect(ScoringService::ScoreCalculator.new(1, @chances).execute)
        .to eq(20)
    end

    it 'default calculation' do
      default_chances(2)
      @chances.push(Chance.new('Test', '3', nil, false))
      expect(ScoringService::ScoreCalculator.new(1, @chances).execute)
        .to eq(13)
    end
  end

  it 'valid default calculation' do
    chance = Chance.new('Test', '5', nil, false)
    chance.add_attempt('Test', '3', nil)
    @chances.push(chance)
    expect(ScoringService::ScoreCalculator.new(0, @chances).execute)
      .to eq(8)
  end
end
# rubocop:enable Metrics/BlockLength
