class Zone
  attr_accessor :description, :item, :debug

  def initialize(description, item=[])
    @description = description
    @item        = item
    @debug       = false
  end
  
  def describe
    world_description = self.description
    items_here        = self.item
    item_descriptions = items_here.map(&:name) if items_here
    description       = "#{world_description}\n"
    
    
    if !items_here.empty?
      description += "You look about and see: #{item_descriptions.join(', ')}.\n"
    end

    if self.debug
      description += "items: #{self.item.inspect}\n"
      description += "world: #{self.description.inspect}\n"
    end

    description
  end

end