require_relative 'item'
require_relative 'zone'
require_relative 'player'
require_relative 'world_display'

class World
  attr_accessor :player, :world, :world_display, :items
  
  def initialize
    @player        = Player.new
    @world         = { player.position => Zone.generate }
    @world_display = WorldDisplay.new
  end

  def render_world
    world_display.render
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