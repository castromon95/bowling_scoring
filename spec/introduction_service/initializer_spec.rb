# frozen_string_literal: true

RSpec.describe IntroductionService::Initializer, type: :model do
  before(:each) do
    @prompt = double('prompt')
    @initializer = IntroductionService::Initializer.new(@prompt)
  end

  it 'works correctly' do
    expect(@prompt).to receive(:ok).with('Welcome to de Bowling Scoring APP!')
    expect(@prompt)
      .to receive(:warn)
      .with("You're currently running v#{BowlingScoring::VERSION}")
    allow(@prompt).to receive(:yes?).with('Do you want to continue?') { true }
    question = 'Please insert the absoulte path for the .txt file?'
    allow(@prompt).to receive(:ask).with(question) { 'test/test.txt' }
    allow(File).to receive(:file?).with('test/test.txt') { true }
    expect(@initializer.execute).to eq('test/test.txt')
  end
end
