require 'minitest/autorun'
require './lib/world.rb'

class WorldTest < MiniTest::Unit::TestCase

	def setup
		@world = World.new
	end

end