require_relative 'world'
require_relative 'inventory'

class Dispatch
  attr_accessor :map, :player, :inventory

  COMMANDS = [
    "look",
    "move",
    "inventory",
    "attack",
    "pickup",
    "drop",
    "exit",
    "dance"
  ]
  
  def initialize
    @map       = World.new
    @player    = map.player
    @inventory = player.inventory
  end
  
  def execute(command)
    verb, noun = command.split.map(&:downcase)  
    
    case verb
    when "help"      then help
    when "look"      then look
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

  def look
    map.describe
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

    return "You have: " + list(inventory_array)
  end

  def help
    "list of words you can use: #{list(COMMANDS)}!"
  end

  def pickup(noun)
    if self.map.current_item.empty?
      "Nothing to pick up!"
    else
      current_item = self.map.current_item.shift
      if current_item.name == noun
        inventory.add(current_item)
        "#{current_item.name.capitalize} picked up!"
      else
        self.map.current_item << current_item
        "Could not find a #{noun}!"
      end
    end
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

  def list(commands)
    commands[-1].insert(0, "and ") if commands.size > 1
    commands.size > 2 ? commands.join(", ") : commands.join(" ") 
  end

  def prefix(word)
    pattern = /a|e|i|o|u/
    pattern.match(word[0]) ? word.insert(0, "an ") : word.insert(0, "a ")
  end

end
