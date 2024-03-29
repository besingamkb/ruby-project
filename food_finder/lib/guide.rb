require 'restaurant'
class Guide

	class Config
		@@actions = ['list', 'find', 'add', 'quit']

		def self.actions; @@actions; end
	end

	def initialize(path=nil)
		# locate the restaurant text file at path

		Restaurant.filepath = path
		if Restaurant.file_usable?
			puts "Found Restaurant file."
		elsif Restaurant.create_file
			puts "Created restaurant file."
		else
			puts "Exiting.\n\n"
			exit!
		end

		# or create a new file
		#exit if create fails
	end

	def launch!
		introduction
		# action loop
		result = nil
		until result == :quit
			action = get_action
			#  => do that action
			result = do_action(action)
		end
		conclusion
	end
	#  => what do you want to do? (list, fin, add, quit)
	def get_action
		action = nil
		# keep asking for user input until we get a valid action
		until Guide::Config.actions.include?(action)
			puts "Actions: " + Guide::Config.actions.join(", ") if action
			print "> "
			user_response = gets.chomp
			action = user_response.downcase.strip
		end
		return action
	end

	def do_action(action)
		case action
		when 'list'
			list
		when 'find'
			puts "Finding.."
		when 'add'
			add
		when 'quit'
			return :quit
		else
			puts "\n I don't understand that command. \n"
		end 
	end

	def list
		puts "\nListing a restaurants\n\n".upcase
		restaurants = Restaurant.saved_restaurants
		restaurants.each do |rest|
			puts rest.name + " | " + rest.cuisine + " | " + rest.price
		end
	end

	def add
		puts "\nAdd a restaurant\n\n".upcase
		
		restaurant = Restaurant.build_using_questions

		if restaurant.save
			puts "\n Restaurant Added\n\n"
		else
			puts "\n Save Error: Restaurant not Added\n\n"
		end
	end

	def introduction
		puts "\n\n<<< Welcome to the Food finder >>> \n\n"
		puts "This is an interactive guide to help you find the food you crave. \n\n"		
	end

	def conclusion
		puts "\n<<< Goodbye and Bon Appetit >>>\n\n\n"
	end
end