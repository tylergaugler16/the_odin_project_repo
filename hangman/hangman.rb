require 'yaml'

class Hangman
	attr_reader :word 
	attr_accessor :guesses , :solution, :guesses_remaining

	def initialize
	    @word= get_word_from_file()
		@guesses_remaining=@word.length()+1
		@solution=""
		@guesses=[]
		(@word.length-2).times{@solution.concat("-")}
		puts "do you want to load a file?(y/n)"
		reply=gets.chomp
		if reply=="y"
			load_game()
		else
		guess()
		end
	end

	def guess
		while( solution_not_found() ) 
			puts "guesses remaining #{guesses_remaining}"
			break if guesses_remaining < 1
			# validates that user gives proper guess. 
			while(true)
				guess=prompt_user().downcase()
				break if is_valid(guess)
			end
			puts "found solution" if(!solution_not_found)
			
			check(guess)

			display()
		end
	end

	def get_word_from_file
		words= File.readlines("words.txt")
		return words[rand(words.length)].downcase
	end

	def solution_not_found
		return true if @solution.split("").include?("-");
		return false;
	end

	def prompt_user
		puts "#{guesses_remaining} guesses remaining!"
		puts "Guesses: #{guesses.join(", ")}"
		puts "ENTER A LETTER: (OR PRESS S TO SAVE YOUR GAME) "
		reply=gets.chomp
		if reply=="S"
			save_game()
			exit 
		else
			return reply
		end
	end

	def is_valid(guess)
		if guesses.include?(guess)
			return false
		else
			return true
		end
	end

	def check(guess)
		@guesses<<guess
		add_letter(guess) if @word.include?(guess)
		@guesses_remaining -=1
	end

	def add_letter(guess)

		@solution.split("").each.with_index do |letter, index|
			if @word[index] == guess 
				@solution[index]=guess
			end
		end
	end

	def display
		puts "Congratulations you won!" if(!solution_not_found)
		puts ""
		puts @solution
		puts ""
	end

	  def save_game
    	Dir.mkdir('saved_games') unless Dir.exists? "saved_games"
    	file = "saved_games/saved.yaml"
  	    File.open(file, "w+"){|f| f.puts YAML.dump(self) }
    	puts "Game saved."
 	 end

 	  def load_game
   		game_file = File.open("saved_games/saved.yaml")
    	yaml = game_file.read
    	game_loaded = YAML::load(yaml)
    	game_loaded.guess 
  	end





end

