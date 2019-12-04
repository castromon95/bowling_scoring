# frozen_string_literal: true

RSpec.describe BowlingScoring do
  it 'has a version number' do
    expect(BowlingScoring::VERSION).not_to be nil
  end

  it 'has an author' do
    expect(BowlingScoring::AUTHORS).not_to be_empty
  end

  it 'has an email' do
    expect(BowlingScoring::EMAILS).not_to be_empty
  end
end
