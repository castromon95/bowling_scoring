# frozen_string_literal: true

# rubocop:disable Metrics/BlockLength
RSpec.describe Error do
  before(:each) do
    @exception
  end

  def validate(kind, message)
    expect(@exception.message).to eq(message)
    expect(@exception.kind).to eq(kind)
  end

  it 'error handler' do
    prompt = double('prompt')
    exception = Error::FinishExecutionError.new
    error_handler = Error::ErrorHandler.new(prompt)
    expect(prompt).to receive(:ok).with(exception.message)
    error_handler.handle(exception)
  end

  it 'fatal error' do
    message = 'An unexpected error has occured, please contact '\
              "#{BowlingScoring::AUTHORS.first} via email "\
              "(#{BowlingScoring::EMAILS.first}) for technical support"
    @exception = Error::FatalError.new
    validate(:error, message)
  end

  it 'file error' do
    path = 'test/file'
    message = "Sorry, the given absolute path wasn't found (#{path})"
    @exception = Error::FileError.new(path)
    validate(:warn, message)
  end

  it 'finish execution error' do
    message = 'Application successfully terminated (: Hope to see you soon!'
    @exception = Error::FinishExecutionError.new
    validate(:ok, message)
  end

  it 'finished line error' do
    player_name = 'Test'
    line = 2
    message = "Sorry, the player #{player_name} already finished his "\
              "chances (line: #{line})"
    @exception = Error::FinishedLineError.new(line, player_name)
    validate(:error, message)
  end

  it 'invalid attempt error' do
    player_name = 'Test'
    line = 2
    value = 4
    message = "Sorry, #{player_name} attempt is invalid. Only numeric values "\
    "from 0 to 10 or an F are valid. Got a '#{value}' character (line: #{line})"
    @exception = Error::InvalidAttemptError.new(line, player_name, value)
    validate(:error, message)
  end

  it 'invalid chance error' do
    player_name = 'Test'
    line = 2
    total = 12
    message = "Sorry, #{player_name} chance is invalid. A player can sum a "\
    "maximum of 10 pins per chance and he got #{total} (line: #{line})"
    @exception = Error::InvalidChanceError.new(line, player_name, total)
    validate(:error, message)
  end

  it 'player name error' do
    message = "Sorry, the player name can't be blank"
    @exception = Error::PlayerNameError.new
    validate(:error, message)
  end

  it 'turn error' do
    line = 2
    expected = 'Test'
    received = 'Test2'
    message = "Sorry, it was #{expected} turn but got "\
              "#{received} (line: #{line})"
    @exception = Error::TurnError.new(line, expected, received)
    validate(:error, message)
  end

  it 'unfinished line error' do
    player_name = 'Test'
    message = "Sorry, the player #{player_name} didn't finish his bowling line"
    @exception = Error::UnfinishedLineError.new(player_name)
    validate(:error, message)
  end
end
# rubocop:enable Metrics/BlockLength
