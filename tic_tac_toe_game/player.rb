class Player
	attr_reader :name, :symbol, :wins
	
	def initialize(name,symbol)
		@name=name
		@symbol=symbol
		@wins=0
	end
	def won
		@wins+=1
	end

end