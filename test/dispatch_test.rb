require 'minitest/autorun'
require './lib/dispatch.rb'
require './lib/zone.rb'
require './lib/inventory.rb'
require './lib/item.rb'

class DispatchTest < MiniTest::Unit::TestCase

  def setup
    @dispatch = Dispatch.new
  end

  def test_execute_command
    assert_equal "list of words you can use: move, attack, pickup, drop, and dance!", @dispatch.execute("help\r")
    assert_equal "That's not a command!", @dispatch.execute("lakjsd;lkfjks")
  end

  def test_dispatch_responds_to
    assert_respond_to @dispatch, "help"
    assert_respond_to @dispatch, "burn"
    assert_respond_to @dispatch, "pickup"
  end

  def test_dispatch_to_list_inventory
    expected_item = Item.new({"name" => "test", "strength" => 1})
    @dispatch.inventory.items << expected_item
    assert_equal @dispatch.inventory.items, @dispatch.execute("inventory")
  end

end