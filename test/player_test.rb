require 'minitest/autorun'
require './lib/player.rb'

class PlayerTest < MiniTest::Unit::TestCase

  def setup
    @player = Player.new
  end

  def test_update_position
    @player.update_position("0|1")

    assert_equal "0|1", @player.position
  end

end