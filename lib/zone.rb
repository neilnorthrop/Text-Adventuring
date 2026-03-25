class Zone
  attr_accessor :description, :items, :debug

  SCENES = [
    "You are in a dense wood.",
    "You're just outside of a forest. You can hear a bubbling brook in the distance.",
    "You're at the edge of a cliff, peering into the dark abyss.",
    "You're at the top of a waterfall. Make a wish.",
    "You are deep in a thick jungle. You feel a dark gaze upon you.",
    "You stand before an ancient temple stretching deep into the ocean.",
    "You stand before an army of goblins, poised to attack.",
    "You're standing in a sea of roses. You smell blood in the air."
  ]

  def self.generate
    new(SCENES.sample, Item.generate)
  end

  def initialize(description, items=[])
    @description = description
    @items       = items
    @debug       = false
  end
  
  def describe
    zone_description = "#{self.description.dup}\n"
    
    if !items.empty?
      zone_description += "You look about and see: #{items.map(&:name).join(', ')}.\n"
    end

    if self.debug
      zone_description += "items: #{self.item.inspect}\n"
      zone_description += "zone: #{self.description.inspect}\n"
    end

    zone_description
  end

end