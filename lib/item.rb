require 'yaml'

class Item
  attr_accessor :strength, :name

  ITEMS_FILE = "./lib/yaml/items.yaml"
  
  def self.random
    item = YAML.load_file(ITEMS_FILE).sample
    new(item)
  end

  def self.generate
    random
  end
  
  def initialize(attributes)
    @strength = attributes["strength"] || false
    @name 	  = attributes["name"]     || false
  end
end