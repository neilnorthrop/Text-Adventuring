require 'minitest/autorun'
require './lib/dispatch.rb'
require './lib/zone.rb'
require './lib/inventory.rb'
require './lib/item.rb'

class DispatchTest < MiniTest::Unit::TestCase

  def setup
    @dispatch      = Dispatch.new
    @expected_item = Item.new({"name" => "test", "strength" => 1})
    @second_item   = Item.new({"name" => "cat", "strength" => 2})
    @help_string   = "list of words you can use: move, inventory, attack, pickup, drop, and dance!"
  end

  def test_execute_command
    assert_equal "That's not a command!", @dispatch.execute("lakjsd;lkfjks")
  end

  def test_responds_to
    assert_respond_to @dispatch, "help"
    assert_respond_to @dispatch, "burn"
    assert_respond_to @dispatch, "pickup"
  end

  def test_get_inventory_with_single_item
    @dispatch.inventory.items << @expected_item

    assert_equal "You have: test with a strength of 1", @dispatch.execute("inventory")
  end

  def test_get_inventory_with_multiple_items
    expected_string = "You have: test with a strength of 1 and cat with a strength of 2"
    @dispatch.inventory.items << @expected_item << @second_item

    assert_equal expected_string, @dispatch.get_inventory
  end

  def test_list
    expected_string = "me, you, and I"
    actual_array    = ["me", "you", "I"]

    assert_equal expected_string, @dispatch.list(actual_array)
  end

  def test_prefix
    assert_equal "a dog", @dispatch.prefix("dog")
    assert_equal "an axe", @dispatch.prefix("axe")
  end

  def test_pickup
    expected_string = "Stick picked up!"

    assert_equal expected_string, @dispatch.pickup("stick")

    expected_string = "Could not find a tick!"
    @dispatch.map = World.new

    assert_equal expected_string, @dispatch.pickup("tick")

    expected_string = "Nothing to pick up!"
    zone = Zone.new("Test Zone")
    @dispatch.map.world["0|0"] = zone

    assert_equal expected_string, @dispatch.pickup("something")
  end

end