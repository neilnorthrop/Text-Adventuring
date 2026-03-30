require_relative 'dispatch'

class Game
	attr_accessor :world, :dispatch

	def initialize
		@world 		= World.new
		@dispatch = Dispatch.new(world)
	end

	def execute(command)
		dispatch.execute(command)
	end

	def render_game
		dispatch.render_game
	end

end