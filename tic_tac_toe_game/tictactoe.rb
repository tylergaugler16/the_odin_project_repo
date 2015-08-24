require_relative 'player'
require_relative 'game'

class TicTacToe 

	attr_reader :player1, :player2, :player1_wins, :player2_wins, :current_player, :current_game
	@player1_wins=0
	@player2_wins=0

	def initialize
		puts "ENTER NAME FOR PLAYER 1: "
		player1_name=gets.chomp
		puts "ENTER NAME FOR PLAYER 2: "
		player2_name=gets.chomp
		@player1= Player.new(player1_name, "X")
		@player2= Player.new(player2_name, "O")

		self.new_game
	end

	def new_game
		
		@current_game= Game.new(@player1, @player2)
		
		while not @current_game.finished? do 
			@current_game.display_board
			puts "Your turn #{@player1.name}! Chose a number from 1-9 (boxes go from left to right): "
			choice=gets.chomp.to_i-1
			# for placing it on the board, it is easier to use 0-8, so we subtract 1
			
			@current_game.make_move(@player1, choice)

			

			@current_game.winner(@player1) if @current_game.wins?(@player1)
			break if @current_game.finished?

			@current_game.display_board
			puts "Your turn #{@player2.name}! Chose a number from 1-9 (boxes go from left to right): "
			choice=gets.chomp.to_i-1
			
			@current_game.make_move(@player2, choice)

			@current_game.winner(@player2) if @current_game.wins?(@player2)

			

		end

		puts "Do you want to play again?"
		user_input= gets.chomp
		if user_input.downcase== "yes" then
		
		self.new_game
		else
			puts "Thanks for playing!"
		end

	end





end

















game= TicTacToe.new()


