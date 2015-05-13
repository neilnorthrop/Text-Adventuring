require_relative 'world'

class Dispatch
  attr_accessor :map, :player, :inventory

  COMMANDS = {
    'help'      => 'help',
    'look'      => 'look',
    'move'      => 'map.send(:move, noun)',
    'inventory' => 'get_inventory',
    'attack'    => 'monster.fight',
    'pickup'    => 'pickup noun',
    'drop'      => 'drop, noun',
    'exit'      => 'exit',
    'dance'     => 'dance',
    'burn'      => 'burn'
  }
  
  def initialize
    @map       = World.new
    @player    = map.player
    @inventory = player.inventory
  end
  
  def execute(command)
    verb, noun = command.split.map(&:downcase)

    COMMANDS.each do |k,v|
      if k == verb
        return eval(v)
      end
    end

    return "That's not a command!"
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
