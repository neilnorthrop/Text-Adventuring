require 'minitest/autorun'
require './lib/inventory.rb'
require './lib/item.rb'

class InventoryTest < MiniTest::Test

  def setup
    @inventory = Inventory.new
    @item = Item.new({"name" => "test_item", "strength" => 1})
  end

  def test_add_item
    assert_equal "test_item picked up!", @inventory.add(@item)
  end

  def test_drop_item
    @inventory.add(@item)
    assert_equal "test_item dropped!", @inventory.drop(@item.name)
  end

  def test_search_items
    @inventory.add(@item)
    assert_equal @item, @inventory.search_items(@item.name)
  end

end