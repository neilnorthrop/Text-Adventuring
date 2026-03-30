require_relative 'world'

class Dispatch
  attr_accessor :map, :player, :inventory, :world_display

  COMMANDS = {
    'help'      => 'help',
    'look'      => 'look',
    'strength'  => 'strength',
    'move'      => 'map.send(:move, noun)',
    'inventory' => 'get_inventory',
    'attack'    => 'monster.fight',
    'pickup'    => 'pickup noun',
    'drop'      => 'drop noun',
    'exit'      => 'exit',
    'dance'     => 'dance',
    'burn'      => 'burn'
  }
  
  def initialize(world)
    @map           = world
    @player        = map.player
    @inventory     = player.inventory
    @world_display = world.world_display
  end

  def render_game
    map.render_world
  end
  
  def execute(command)
    verb, noun = split(command)

    return eval(COMMANDS.fetch(verb) { |verb| return "That is not a command." })
  end

  def look
    map.describe
  end

  def strength
    return "Your current strength is: #{player.strength}."
  end

  def drop(noun)
    item = inventory.drop(noun)
    map.drop_item(item)
    player.update_strength
    return "#{item.name} dropped!"
  end

  def get_inventory
    inventory_array = []
    inventory.items.each_with_index do |item, index|
      inventory_array << "#{index + 1} - #{item.name} with a strength of #{item.strength}"
    end

    return "You have: " + list(inventory_array)
  end

  def help    
    unfrozen_list = COMMANDS.keys.map(&:dup)
    world_display.render_help("Actions you can perform: #{list(unfrozen_list)}!")
  end

  def pickup(noun)
    if self.map.current_item.empty?
      "Nothing to pick up!"
    else
      current_item = self.map.current_item.shift
      if current_item.name == noun
        inventory.add(current_item)
        player.update_strength
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

  def list(array)
    if array.count > 1
      array[-1].insert(0, 'and ')
      return array.join(', ') if array.count > 2
    end

    array.join(' ')
  end

  def prefix(word)
    pattern = /a|e|i|o|u/
    pattern.match(word[0]) ? word.insert(0, 'an ') : word.insert(0, 'a ')
  end

  def split(command)
    command_list = command.split.map(&:downcase)
    verb = command_list.shift
    noun = command_list.join(' ')
    return verb, noun
  end

end
