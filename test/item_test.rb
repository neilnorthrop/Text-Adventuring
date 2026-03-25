require 'minitest/autorun'
require './lib/item.rb'

class ItemTest < Minitest::Test

	def setup
    @test_items = { "name" => "cat", "strength" => 1 }
	end

  def test_load_item
    item = Item.new(@test_items)
    assert_equal "cat", item.name
  end

end