require 'minitest/autorun'
require './lib/inventory.rb'
require './lib/item.rb'

class InventoryTest < MiniTest::Unit::TestCase

  def setup
    @inventory = Inventory.new
    @item = Item.new({"name" => "test_item", "strength" => 1})
  end

  def test_add_item
    @inventory.add(@item)

    assert_equal @item, @inventory.items.last
    assert_equal 1, @inventory.strength


    second_item = Item.random
    expected_strength = @inventory.strength + second_item.strength
    @inventory.add(second_item)

    assert_equal second_item, @inventory.items.last
    assert_equal expected_strength, @inventory.strength
  end

  def test_drop_item
    @inventory.add(@item)
    assert_equal @item, @inventory.drop(@item.name)
  end

  def test_search_items
    @inventory.add(@item)
    random_item = Item.random
    @inventory.add(random_item)

    assert_equal random_item, @inventory.search_items(random_item.name)
    assert_equal @item, @inventory.search_items(@item.name)
  end

end