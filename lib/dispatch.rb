require_relative 'zone'
require_relative 'inventory'

class Dispatch
  attr_accessor :map, :inventory
  
  def initialize
    @map       = Zone.new
    @inventory = Inventory.new
  end
  
  def execute(command)
    verb, noun = command.split.map(&:downcase)  
    
    case verb
    when "help"
      puts "list of words you can use: move, attack, pickup, drop, and dance!"
    when "move"
      self.map.move noun
    when "attack"
      monster.fight()
    when "pickup"
      current_item = self.map.items[self.map.player_position]
      inventory.add(current_item.shift)
    when "drop"
      inventory.drop(noun)
    when "dance!"
      puts "You win so hard!"
    when "burn"
      puts "DOOM! DESECRATION! THE RIVERS RUN RED WITH YOUR BLOOD!"
      puts "The angels will weep for a thousand years for your treacherous betrayal of people and country."
      puts "Thank you for playing."
      puts "<3 BenBen!"
    else
      "That's not a command!"
    end
  end

end
