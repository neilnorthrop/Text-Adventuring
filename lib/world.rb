require_relative 'item'
require_relative 'zone'
require_relative 'player'

class World
  attr_accessor :player, :world, :items
  
  def initialize
    @player = Player.new
    @world  = { player.position => Zone.generate }
  end
  
  def move(direction)
    new_position = get_new_position(direction)
    
    generate(new_position)
    player.update_position(new_position)

    describe
  end
  
  def generate(position)
    return if self.world[position]

    world[position] = Zone.generate
  end

  def current_item
    world[player.position].items
  end

  def drop_item(item)
    world[player.position].items << item
  end

  def describe
    world[player.position].describe
  end

  def get_new_position(direction)
    x, y = self.player.position.split('|').map(&:to_i)
    
    case direction.downcase
    when "north"
      y += 1
    when "south"
      y -= 1
    when "east"
      x += 1
    when "west"
      x -= 1
    end
    
    "#{x}|#{y}"
  end
  
end