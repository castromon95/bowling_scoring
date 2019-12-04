# frozen_string_literal: true

RSpec.describe IntroductionService::Introducer, type: :model do
  before(:each) do
    @prompt = double('prompt')
    @introducer = IntroductionService::Introducer.new(@prompt)
  end

  def intro(continues = true)
    expect(@prompt).to receive(:ok).with('Welcome to de Bowling Scoring APP!')
    expect(@prompt)
      .to receive(:warn)
      .with("You're currently running v#{BowlingScoring::VERSION}")
    allow(@prompt).to receive(:yes?).with('Do you want to continue?') { continues }
  end

  it 'user continues' do
    intro
    @introducer.execute
  end

  it 'user does not continue' do
    intro(false)
    exception = Error::FinishExecutionError.new
    expect { @introducer.execute }
      .to raise_error(exception.class, exception.message)
  end
end
