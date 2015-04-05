class Player
  attr_reader :position

  def initialize
    @position = "0|0"
  end

  def update_position(new_position)
    @position = new_position
  end

end