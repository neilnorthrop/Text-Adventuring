require 'minitest/autorun'
require './lib/world.rb'
require_relative 'test_helper'

class WorldTest < MiniTest::Unit::TestCase

	def setup
		@worldmock = WorldMock.new
	end

  def test_move
    expected_string = "TEST SCENE WORKS\nYou look about and see: stick.\n"

    assert_equal expected_string, @worldmock.move("north")
  end

end