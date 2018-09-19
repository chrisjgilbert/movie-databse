# MODULES
module Menu
	def menu
		"Welcome to the Movie Database.
		A) Add a movie to the database
		S) View the movie database
		U) Update a movie's rating
		or
		Q) Quit"
	end
end

module Prompt
	def prompt(message, symbol=":::> ")
		print message
		print symbol
		gets.chomp.downcase
	end

	def add_prompt(message, symbol=":::> ")
		print message
		print symbol
		title = gets.chomp.split.map(&:capitalize).join(' ')
	end
end

# CLASSES
class Database
	attr_accessor :movie_database, :title, :rating

	def initialize
		@movie_database = {
			"Bond" => 5
		}
	end

def is_valid?(title)
	@movie_database.include?(title) ? false : true
end

	def add(title, rating)
		@movie_database[title] = rating
	end

	def show
		@movie_database.each do |title, rating|
			puts "#{title}: #{rating}"
		end
	end

	def update(title, rating)
		@movie_database[title] = rating
	end


end

class Movie
	attr_reader :title

	def initialize(title)
		@title = title
	end

	def to_s
		@title
	end
end

# PROGRAM RUNNER
if __FILE__ == $PROGRAM_NAME
	include Menu
	include Prompt
	# create new database
	mydb = Database.new
	# welcome menu
	until ['q'].include?(user_input = prompt(menu))
		case user_input
			# add movie
			when 'a'	
			movie = Movie.new(add_prompt('What is the title of the film you would like to add?'))
			if mydb.is_valid?(movie.title) == true
				mydb.add(movie.title, prompt('What rating with you give ' + movie.title + ' ?'))
				puts "Your updated database:"
				mydb.show
			else 
				puts "That movie already exists!"
			end
		# show movie
			when 's'
				puts "Your current database:"
				mydb.show
			when 'u'
				puts "Your current database:"
				mydb.show
				mydb.update(add_prompt('Which movie woud you like to update?'), prompt('What rating would you like to give it?'))
				puts "Your updated database:"
				mydb.show
			else
				puts "I didn't catch that, please try again!"
		end
		prompt('Press Enter to continue ', ':-)')
	end
	puts "Goodbye!"
end

