require_relative 'inventory'

class Player
  attr_accessor :inventory
  attr_reader :position

  def initialize
    @position = "0|0"
    @inventory = Inventory.new
  end

  def update_position(new_position)
    @position = new_position
  end

end