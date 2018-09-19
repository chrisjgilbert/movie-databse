# MODULES
module Menu
	def menu
		"Welcome to the Movie Database.
		A) Add a movie to the database
		S) View the movie database
		U) Update a movie's rating
		D) Delete a movie from the database
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

	def valid_rating?(rating)
		rating > 10 || rating < 0 ? false : true
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

	def delete(title)
		@movie_database.delete(title)
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
				rating = prompt('What is your rating for ' + movie.title + '?').to_i
					if mydb.valid_rating?(rating) == true
						mydb.add(movie.title, rating)
					else
						puts "That rating is not between 1 and 10!"
					end
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
				movie = Movie.new(add_prompt('What is the title of the film you would like to update?'))
				if mydb.is_valid?(movie.title) == false
						mydb.update(movie.title, prompt('What rating would you give ' + movie.title + ' now?'))
						puts "Your updated database:"
						mydb.show
				else
					puts "That movie doesn't exist! Please add it!"
				end
			when 'd'
				movie = Movie.new(add_prompt('What is the title of the film you would like to delete?'))
				if mydb.is_valid?(movie.title) == false
						mydb.delete(movie.title)
						puts "Your updated database:"
						mydb.show
				else
					puts "That movie doesn't exist - which is maybe a good thing if you didn't rate it!"
				end
			else
				puts "I didn't catch that, please try again!"
		end
		prompt('Press Enter to continue ', ':-)')
	end
	puts "Goodbye!"
end

