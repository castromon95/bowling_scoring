# frozen_string_literal: true

# Model to represent the bowling scorebaord
class Scoreboard < Parent::Bowling
  def initialize
    @players = []
    @all_players_registered = false
    @next_player = nil
  end

  def add_attempt(player_name, score, line)
    player = current_player(player_name)
    players_turn?(player, line, player_name)
    @next_player = define_next_player(player, score, line)
  end

  def format
    result = "Frame\t1\t\t2\t\t3\t\t4\t\t5\t\t6\t\t7\t\t8\t\t9\t\t10"
    @players.each do |player|
      result += player.format
    end
    "#{result}\n"
  end

  private

  def define_next_player(player, score, line)
    player.add_attempt(player.name, score, line) ? next_player(player) : player
  end

  def players_turn?(player, line, player_name)
    return unless @next_player || (@all_players_registered && @next_player)
    return if player&.by_name?(@next_player.name)

    raise Error::TurnError.new(line, @next_player.name, player_name)
  end

  def current_player(player_name)
    player = detect_player(player_name)
    return player if @all_players_registered || first_second_attempt?(player)

    if player&.registered? && !@next_player
      @all_players_registered = true
    else
      player = Player.new(player_name, @players.length)
      @players.push(player)
    end
    player
  end

  def first_second_attempt?(player)
    player && player == @next_player && !@all_players_registered
  end

  def detect_player(player_name)
    @players.detect { |player| player.by_name?(player_name) }
  end

  def next_player(player)
    next_turn = detect_next_turn(player.turn + 1)
    return detect_next_turn(0) if !next_turn && @all_players_registered

    next_turn
  end

  def detect_next_turn(turn)
    @players.detect { |next_player| turn == next_player.turn }
  end
end
