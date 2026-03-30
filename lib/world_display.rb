class WorldDisplay
	attr_accessor :display_table

	def initialize
		@display_table = Terminal::Table.new
    display_table.title = "Adventuring of Text"
    display_table.headings = ['World', 'Player']
    display_table.style = {:width => 40}
	end

	def render
    rows = []
    rows << ['One', 1]
    rows << ['Two', 2]
    rows << ['Three', 3]
    display_table.rows = rows

    puts display_table
	end

	def render_help(text)
		puts text
	end

end