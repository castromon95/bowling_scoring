# frozen_string_literal: true

# rubocop:disable Metrics/BlockLength
RSpec.describe IntroductionService::FileVerifier, type: :model do
  before(:each) do
    @prompt = double('prompt')
    @file_verifier = IntroductionService::FileVerifier.new(@prompt)
  end

  def intro(valid_file = true, path = 'test/test.txt')
    question = 'Please insert the absoulte path for the .txt file?'
    q = double('q')
    allow(@prompt).to receive(:ask).with(question).and_yield(q)
    allow(q).to receive(:required) { path }
    allow(q).to receive(:validate) { path }
    validate(valid_file, path)
  end

  def validate(valid_file, path)
    allow(File).to receive(:file?).with(path) { valid_file }
  end

  it 'selects valid file' do
    intro
    expect(@file_verifier.execute).to eq('test/test.txt')
  end

  it 'selects invalid file' do
    exception = Error::FinishExecutionError.new
    path = 'test/test.txt'
    question = "Sorry, the given file path wasn't found (#{path})"
    intro(false, path)
    expect(@prompt).to receive(:warn).twice.with(question)
    allow(@prompt)
      .to receive(:yes?)
      .with('Do you want to try again?')
      .and_return(true, false)
    expect { @file_verifier.execute }
      .to raise_error(exception.class, exception.message)
  end
end
# rubocop:enable Metrics/BlockLength
