require_relative 'item'
require_relative 'zone'
require_relative 'player'

class World

  SCENES = [
    "You're just outside of a forest. You can hear a bubbling brook in the distance.",
    "You're at the edge of a cliff, peering into the dark abyss.",
    "You're at the top of a waterfall. Make a wish.",
    "You are deep in a thick jungle. You feel a dark gaze upon you.",
    "You stand before an ancient temple stretching deep into the ocean.",
    "You stand before an army of goblins, poised to attack.",
    "You're standing in a sea of roses. You smell blood in the air."
  ]

  attr_accessor :player, :world, :items
  
  def initialize
    @player = Player.new
    @world           = { player.position => Zone.new("You are in a dense wood.", [Item.new({"name" => "stick", "strength" => 1})]) }
  end
  
  def move(direction)
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
    
    position = "#{x}|#{y}"
    
    generate(position)
    self.player.update_position(position)
    
    world[position].describe
  end
  
  def generate(position)
    return if self.world[position]

    description = SCENES.sample
    
    if rand(1..2).even?
      world[position] = Zone.new(description, [Item.random])
    else
      world[position] = Zone.new(description)
    end
  end

  def current_item
    world[player.position].item
  end

  def drop_item(item)
    world[player.position].item << item
  end
  
end