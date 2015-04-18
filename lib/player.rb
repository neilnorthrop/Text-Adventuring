require_relative 'inventory'

class Player
  attr_accessor :inventory, :strength
  attr_reader :position

  def initialize
    @position  = "0|0"
    @inventory = Inventory.new
  end

  def update_position(new_position)
    @position = new_position
  end

  def update_strength
    self.strength = inventory.strength
  end

end