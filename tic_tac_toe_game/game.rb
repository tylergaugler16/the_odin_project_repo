class Game 
	attr_reader :player1, :player2
	attr_accessor :board
	
	
	WINNING_COMBINATIONS=[[0,1,2], [3,4,5], [6,7,8], [0,3,6], [1,4,7],[2,5,8], [6,4,2], [0,4,8]]
	@something=4

		def initialize(player1, player2)
			
			@board=[nil,nil,nil,nil,nil,nil,nil,nil,nil]
			@player1=player1
			@player2=player2
			

		end

		

		def make_move(player, choice)
			symbol=player.symbol
			
			case 
			when (0..2).to_a.include?(choice)
				self.board[choice]=symbol if self.board[choice].nil?
			when (3..5).to_a.include?(choice) 
				self.board[choice]= symbol if self.board[choice].nil?
			when (6..8).to_a.include?(choice)
				self.board[choice]=symbol if self.board[choice].nil?
			else
				puts "#{choice} is not a valid move! Enter another move:"
				new_choice=gets.chomp.to_i-1
				
				self.make_move(player, new_choice)
			end
			


		end


		def wins?(player)
			checker=false
			
			WINNING_COMBINATIONS.each do |combo|
		
			checker= true if combo.all? {|num| self.board[num]==player.symbol} 
			end
			checker

		end

		def finished?
			checker=false
			if self.wins?(@player1) || self.wins?(@player2)
			checker= true
			end
			checker
		end

		def winner(winner)
			winner.won
			puts "#{winner.name} won the game!"
			puts "#{winner.name} has #{winner.wins} number of wins"
		end

		def display_board

			
			
			
			puts "-----------" 
			@board.each_with_index do |num,index|
				print num==nil ? "  " : num+" "
				if (index+1) % 3==0 and index>1 then
				puts "" 
				end
			end
			puts "___________"

		
		end



	end

