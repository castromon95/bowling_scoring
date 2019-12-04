# frozen_string_literal: true

# rubocop:disable Metrics/BlockLength
RSpec.describe Application, type: :model do
  before(:each) do
    @scoreboard = Scoreboard.new
    @path = 'test/test.txt'
    @prompt = double('prompt')
    @application = Application.new
    @application.prompt = @prompt
    @result = ''
    @sample = ''
  end

  def intro
    expect(@prompt).to receive(:ok).with('Welcome to de Bowling Scoring APP!')
    expect(@prompt)
      .to receive(:warn)
      .with("You're currently running v#{BowlingScoring::VERSION}")
    allow(@prompt).to receive(:yes?).with('Do you want to continue?') { true }
    ask_for_file
  end

  def ask_for_file
    question = 'Please insert the absoulte path for the .txt file?'
    allow(@prompt).to receive(:ask).with(question) { @path }
    allow(File).to receive(:file?).with(@path) { true }
  end

  def fetch(file_name)
    File.open("#{Dir.pwd}/spec/results/#{file_name}", 'r') do |f|
      f.each_line do |line|
        @result += line
      end
    end
    File.open("#{Dir.pwd}/spec/samples/#{file_name}", 'r') do |f|
      f.each_line do |line|
        @sample += line
      end
    end
  end

  def integration_test(file_name)
    intro
    fetch(file_name)
    file = StringIO.new(@sample)
    allow(File).to receive(:open).with(@path, 'r').and_yield(file)
    expect(@prompt).to receive(:say).with(@result)
    @application.start
  end

  it 'integration test perfect line' do
    integration_test('perfect_line.txt')
  end

  it 'integration test blank line' do
    integration_test('blank_line.txt')
  end

  it 'integration simple line' do
    integration_test('simple_line.txt')
  end

  it 'integration extra shot spare' do
    integration_test('extra_shot_spare.txt')
  end

  it 'integration extra shot strike' do
    integration_test('extra_shot_strike.txt')
  end

  it 'integration two simple lines' do
    integration_test('two_simple_lines.txt')
  end

  it 'integration two simple lines' do
    integration_test('complex_line.txt')
  end

  it 'rescues custom errors' do
    intro
    file = StringIO.new("Test\t10\nTest\t10\nTest2\t10")
    allow(File).to receive(:open).with(@path, 'r').and_yield(file)
    expect(@prompt)
      .to receive(:error)
      .with(Error::TurnError.new(3, 'Test', 'Test2').message)
    @application.start
  end

  it 'rescues unexpected errors' do
    intro
    expect(@prompt)
      .to receive(:error).with(Error::FatalError.new.message)
    @application.start
  end
end
# rubocop:enable Metrics/BlockLength
