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
    when "help" then help
    when "move" then self.map.move noun
    when "attack" then monster.fight()
    when "pickup" then pickup(noun)
    when "drop" then inventory.drop(noun)
    when "dance!" then dance
    when "burn" then burn
    else "That's not a command!"
    end
  end

  def help
    "list of words you can use: move, attack, pickup, drop, and dance!"
  end

  def pickup(noun)
    current_item = self.map.items[self.map.player_position]
    inventory.add(current_item.shift)
  end

  def dance
    "You win so hard!"
  end

  def burn
    "DOOM! DESECRATION! THE RIVERS RUN RED WITH YOUR BLOOD!\r\n" +
    "The angels will weep for a thousand years for your treacherous betrayal of people and country.\r\n" +
    "Thank you for playing.\r\n" +
    "<3 BenBen!\r\n"
  end

end
