# MODULES
module Menu
	def menu
		"Welcome to the Movie Database.
		A) Add a movie to the database
		S) View the movie database
		U) Update a movie on the database
		D) Delete a movie from the database
		Q) Quit"
	end
end

module Prompt
	def prompt(message, symbol=":::>")
		print message
		print symbol
		gets.downcase.chomp
	end
end

# CLASSES
class Database
	attr_reader :movie_database

	def initialize
		@movie_database = {
		}
	end

	def add_to_database(title, rating) # update method not detecing if movie already exists
	  if @movie_database.key?(title)
	    puts "That movie already exists!"
	  else
	    @movie_database[title] = rating
	    puts "Movie added!"
	  end
	end

	def show
		puts "Your current database:"
		@movie_database.each do |movie, rating|
			puts "#{movie}".capitalize + ": #{rating}"
		end
	end

	def delete(movie)

	end
end



class Movie
	attr_accessor :rating, :title

	def initialize(title)
		@title = title
	end

	def to_s
		@title
	end

	def to_i
		@rating
	end
end


# PROGRAM RUNNER
if __FILE__ == $PROGRAM_NAME
	include Menu
	include Prompt
	# create new database
	database = Database.new
	# welcome menu
	until ['q'].include?(user_input = prompt(menu))
		case user_input
		when 'a'
				database.add_to_database(Movie.new(prompt('What is the title of the film you would like to add? ')), prompt('What is the rating of the film you would like to add? ').to_i)
		when 's'
			database.show
		end
		prompt('Press Enter to continue ', ':-)')
	end
end