require_relative 'world'
require_relative 'inventory'

class Dispatch
  attr_accessor :map, :inventory
  
  def initialize
    @map       = World.new
    @inventory = Inventory.new
  end
  
  def execute(command)
    verb, noun = command.split.map(&:downcase)  
    
    case verb
    when "help"      then help
    when "inventory" then get_inventory      
    when "move"      then self.map.move noun
    when "attack"    then monster.fight()
    when "pickup"    then pickup noun
    when "drop"      then drop noun
    when "dance!"    then dance
    when "burn"      then burn
    else "That's not a command!"
    end
  end

  def drop(noun)
    item = inventory.drop(noun)
    map.drop_item(item)
    return "#{item.name} dropped!"
  end

  def get_inventory
    inventory_array = []
    inventory.items.each do |item|
      inventory_array << "#{item.name} with a strength of #{item.strength}"
    end

    return "You have: " + inventory_array.join(', ')
  end

  def help
    "list of words you can use: move, inventory, attack, pickup, drop, and dance!"
  end

  def pickup(noun)
    current_item = self.map.current_item.shift
    inventory.add(current_item)
    "#{current_item.name} picked up!"
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
