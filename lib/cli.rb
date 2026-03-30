require_relative 'game'
require 'terminal-table'

class Cli
  attr_accessor :game, :infinity

  def initialize
    @ftty = File.new('/dev/tty')
    @game = Game.new
  end

  def start
    clear_screen
    render_display
    
    @infinity = true
    while @infinity
      process_actions
      render_display
    end
  end

  def process_actions
    command = gets.chomp
    puts
    if command == 'exit' || command == 'quit' || command == 'oh god why stop it why'
      puts "Bang! You're dead."
      @infinity = false
    else
      response = game.execute(command)
      puts response
    end
  end

  def render_display
    clear_screen
    game.render_game
  end

  private

  def clear_screen
    system("clear") or system("cls")
  end
end