require 'minitest/autorun'
require './lib/dispatch.rb'
require './lib/zone.rb'
require './lib/inventory.rb'
require './lib/item.rb'

class DispatchTest < MiniTest::Unit::TestCase

  def setup
    @dispatch = Dispatch.new
    @expected_item = Item.new({"name" => "test", "strength" => 1})
    @second_item = Item.new({"name" => "cat", "strength" => 2})
  end

  def test_execute_command
    assert_equal "list of words you can use: move, attack, pickup, drop, and dance!", @dispatch.execute("help\r")
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
    expected_string = "You have: test with a strength of 1, cat with a strength of 2"
    @dispatch.inventory.items << @expected_item << @second_item

    assert_equal expected_string, @dispatch.get_inventory
  end

end