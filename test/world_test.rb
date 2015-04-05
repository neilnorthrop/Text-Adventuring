require 'minitest/autorun'
require './lib/world.rb'

class WorldTest < MiniTest::Unit::TestCase

  class WorldMock 
    SCENES = ["TEST SCENE WORKS"]

    attr_accessor :player_position, :world, :items
    
    def initialize
      @player_position = '0|0'
      @world           = { player_position => Zone.new("You are in a dense wood.", [Item.new({"name" => "stick", "strength" => 1})]) }
    end

    def move(direction)
      x, y = self.player_position.split('|').map(&:to_i)
      
      case direction.downcase
      when "north"
        y += 1
      when "south"
        y -= 1
      when "east"
        x += 1
      when "west"
        x -= 1
      end
      
      position = "#{x}|#{y}"
      
      generate(position)
      self.player_position = position
      
      world[position].describe
    end
    
    def generate(position)
      return if self.world[position]

      description = SCENES.sample
      world[position] = Zone.new(description, [Item.new({"name" => "stick", "strength" => 1})])
    end
  end

	def setup
		@worldmock = WorldMock.new
	end

  def test_move
    expected_string = "TEST SCENE WORKS\nYou look about and see: stick.\n"

    assert_equal expected_string, @worldmock.move("north")
  end

end