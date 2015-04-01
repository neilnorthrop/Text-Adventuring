class Inventory

  attr_accessor :items, :strength
  # @@items = []
  # @@strength = 0

  def initialize
    @items = []
    @strength = 0
  end
  
  def add(item)
    self.items.push(item)
    self.strength += item.strength
    "#{item.name} picked up!"
  end
  
  def drop(item_name)
    item = search_items(item_name)
    self.items.delete(item)
    self.strength -= item.strength
    return "#{item.name} dropped!", item
  end

  def search_items(item_name)
    items.each do |item|
      if item.name == item_name
        return item
      end
    end
  end

end
